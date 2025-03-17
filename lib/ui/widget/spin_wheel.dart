import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({Key? key}) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final selected = BehaviorSubject<int>();
  String rewards = '';
  int count = 0;

  // List<int> items = [1, 2, 3, 4, 1000, 2000];
  List<String> items = [
    'Putar Lagi',
    'Coba Lagi',
    'Pak Maulana',
    'Pak Anto',
    'Dian',
    'Fredy G.K',
    'Himawan',
    'Iva',
    'Yeni',
    'Rena',
    'Kasiman',
    'Antoni',
    'Rini',
    'Maria Magdalena',
    'Joe Marlen M.',
    'Helsa',
    'Lambok',
    'Prio',
    'Hadi',
    'Adhy',
    'Musa',
    'Hendra',
    'Tjasniati',
    'Rully',
    'Vury',
    'Diarresti',
    'Elva Silvia',
    'Dana',
    'Galuh',
    'Handhika',
    'Akbar',
    'Arif Erlangga',
    'Edi Pamungkas',
    'Gita',
    'Hari Windariyadi',
    'Elgi',
    'Reggi',
    'Bram',
    'Aris',
    'M. Kamil Idris',
    'Denny',
    'Boma',
    'Fauqi',
    'Subandrio',
    'Iwan',
    'Neneng',
    'M. Azis',
    'Beny',
    'Edy Susilo',
    'Yanto S.',
    'Budi Wiyanto',
    'Tatang',
    'Aziz Zaelani',
    'Yedi Herdiatna',
    'Wahyudin',
    'Daman',
    'M. Yusuf',
    'Darianto',
    'Yanto Salud',
    'Fani Setyono',
    'Ujang',
    'Aliudin',
    'Rohman',
    'Sanusi',
    'Fikrul',
    'Salehudin',
    'Jonatan Furcon',
    'Andrik',
    'Suhendi',
  ];

  List<String> usedItems = [];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        0,
        30,
        55,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SpinWheel(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 100,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Text(
                rewards.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Putaran ke: $count',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 300,
              child: FortuneWheel(
                selected: selected.stream,
                animateFirst: false,
                items: [
                  for (int i = 0; i < items.length; i++) ...<FortuneItem>{
                    FortuneItem(
                      child: Text(
                        items[i].toString(),
                      ),
                    ),
                  },
                ],
                onAnimationEnd: () {
                  setState(() {
                    rewards = items[selected.value];
                    if (!['Putar Lagi', 'Coba Lagi'].contains(rewards)) {
                      usedItems.add(rewards);
                      items.removeAt(selected.value);
                    }
                  });
                  if (!['Putar Lagi', 'Coba Lagi'].contains(rewards)) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${rewards} Silahkan ke Depan !')));
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    if (items.isNotEmpty) {
                      setState(() {
                        count++;
                        selected.add(Fortune.randomInt(0, items.length));
                      });
                    } else if (items.length == 2) {
                      rewards = "Terima Kasih, Semua nama sudah muncul!";
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('Terima Kasih, Semua nama sudah muncul!')));
                    }
                  },
                  child: const Text(
                    'PUTAR',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
