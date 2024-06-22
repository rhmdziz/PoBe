import 'package:flutter/material.dart';
import 'package:pobe/help.dart';

class ResultDestiny extends StatefulWidget {
  final String startPoint;
  final String endPoint;
  final String fromTime;
  final String toTime;

  const ResultDestiny(
      {super.key,
      required this.startPoint,
      required this.endPoint,
      required this.fromTime,
      required this.toTime});

  @override
  State<ResultDestiny> createState() => _ResultDestinyState();
}

class _ResultDestinyState extends State<ResultDestiny> {
  //   // Contoh konversi dari String ke DateTime
  // DateTime fromDateTime = DateFormat.Hm().parse(_fromTimeController.text);
  // DateTime toDateTime = DateFormat.Hm().parse(_toTimeController.text);

  // // Contoh perhitungan durasi
  // Duration duration = toDateTime.difference(fromDateTime);
  // print('Durasi: ${duration.inHours} jam ${duration.inMinutes.remainder(60)} menit');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios),
                        color: const Color.fromRGBO(31, 54, 113, 1),
                      ),
                      const Text(
                        'Schedule',
                        style: TextStyle(
                          color: Color.fromRGBO(31, 54, 113, 1),
                          fontSize: 18,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HelpPage())),
                      );
                    },
                    icon: const Icon(
                      Icons.help_rounded,
                      color: Color.fromRGBO(31, 54, 113, 1),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset('assets/transport/world_map.png'),
        ],
      ),
    );
  }
}
