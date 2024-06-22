// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pobe/help.dart';

class ResultDestiny extends StatefulWidget {
  final String startPoint;
  final String endPoint;
  final String fromTime;
  final String toTime;

  const ResultDestiny({
    super.key,
    required this.startPoint,
    required this.endPoint,
    required this.fromTime,
    required this.toTime,
  });

  @override
  State<ResultDestiny> createState() => _ResultDestinyState();
}

class BusSchedule {
  final int rute;
  final int halte;
  final int nomorBis;
  final List<String> waktu;
  final String ruteName;
  final String halteName;

  BusSchedule({
    required this.rute,
    required this.halte,
    required this.nomorBis,
    required this.waktu,
    required this.ruteName,
    required this.halteName,
  });

  factory BusSchedule.fromJson(
    Map<String, dynamic> json,
    Map<int, String> ruteNames,
    Map<int, String> halteNames,
  ) {
    return BusSchedule(
      rute: json['rute'],
      halte: json['halte'],
      nomorBis: json['nomor_bis'],
      waktu: [
        json['waktu_1'],
        json['waktu_2'],
        json['waktu_3'],
        json['waktu_4'],
        json['waktu_5'],
        json['waktu_6'],
        json['waktu_7'],
      ],
      ruteName: ruteNames[json['rute']] ?? 'Unknown Rute',
      halteName: halteNames[json['halte']] ?? 'Unknown Halte',
    );
  }
}

class _ResultDestinyState extends State<ResultDestiny> {
  late Future<List<BusSchedule>> futureBusSchedules;

  @override
  void initState() {
    super.initState();
    futureBusSchedules = fetchBusSchedules();
  }

  Future<Map<int, String>> fetchRuteNames() async {
    final response =
        await http.get(Uri.parse('http://192.168.50.226:8000/busroutes/'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return {for (var rute in jsonResponse) rute['id']: rute['nama_rute']};
    } else {
      throw Exception('Failed to load rute names');
    }
  }

  Future<Map<int, String>> fetchHalteNames() async {
    final response =
        await http.get(Uri.parse('http://192.168.50.226:8000/haltes/'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return {for (var halte in jsonResponse) halte['id']: halte['nama_halte']};
    } else {
      throw Exception('Failed to load halte names');
    }
  }

  Future<List<BusSchedule>> fetchBusSchedules() async {
    try {
      final ruteNames = await fetchRuteNames();
      final halteNames = await fetchHalteNames();

      final response =
          await http.get(Uri.parse('http://192.168.50.226:8000/busscheduls/'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<BusSchedule> busSchedules = jsonResponse
            .map((data) => BusSchedule.fromJson(data, ruteNames, halteNames))
            .toList();

        return filterSchedules(busSchedules);
      } else {
        throw Exception('Failed to load bus schedules');
      }
    } catch (e) {
      print('Error fetching bus schedules: $e');
      rethrow; // Rethrow the exception to propagate it further
    }
  }

  List<BusSchedule> filterSchedules(List<BusSchedule> schedules) {
    try {
      TimeOfDay fromTime = TimeOfDay(
        hour: int.parse(widget.fromTime.split(":")[0]),
        minute: int.parse(widget.fromTime.split(":")[1]),
      );
      TimeOfDay toTime = TimeOfDay(
        hour: int.parse(widget.toTime.split(":")[0]),
        minute: int.parse(widget.toTime.split(":")[1]),
      );

      return schedules.where((schedule) {
        bool isStartPointMatch = schedule.halteName == widget.startPoint;
        bool isEndPointMatch = schedule.halteName == widget.endPoint;

        bool isTimeInRange(String time) {
          TimeOfDay scheduleTime = TimeOfDay(
            hour: int.parse(time.split(":")[0]),
            minute: int.parse(time.split(":")[1]),
          );

          print('Schedule Time: ${scheduleTime.hour}:${scheduleTime.minute}');
          print('From Time: ${fromTime.hour}:${fromTime.minute}');
          print('To Time: ${toTime.hour}:${toTime.minute}');

          return scheduleTime.hour >= fromTime.hour &&
              scheduleTime.hour <= toTime.hour;
        }

        bool isAnyTimeInRange = schedule.waktu.any(isTimeInRange);

        return isStartPointMatch && isEndPointMatch && isAnyTimeInRange;
      }).toList();
    } catch (e) {
      print('Error filtering schedules: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/transport/world_map.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 30,
                  right: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.startPoint} - ${widget.endPoint}',
                            style: const TextStyle(
                              color: Color.fromRGBO(23, 23, 23, 1),
                              fontSize: 18,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 2.5,
                          ),
                          Text(
                            '${widget.fromTime} - ${widget.toTime}',
                            style: const TextStyle(
                              color: Color.fromRGBO(31, 54, 113, 1),
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.circle,
                                color: Color.fromRGBO(46, 70, 197, 1),
                                size: 18,
                              ),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              SizedBox(
                                width: 30,
                                child: Image.asset(
                                  'assets/transport/bus.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Text('_', style: TextStyle(fontSize: 14)),
                              const Icon(
                                Icons.circle,
                                color: Color.fromRGBO(46, 70, 197, 1),
                                size: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 15,
                    color: Color.fromRGBO(250, 135, 0, 1),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'BSD LINK',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder<List<BusSchedule>>(
              future: futureBusSchedules,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data found'));
                } else {
                  List<BusSchedule> data = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 90,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(250, 135, 0, 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/transport/bus_white.png',
                                  scale: 1.5,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Rute: ${data[index].rute}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w300,
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1),
                                              ),
                                            ),
                                            Text(
                                              'Halte: ${data[index].halte}',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    46, 70, 197, 1),
                                              ),
                                            ),
                                            Text(
                                              'Nomor Bis: ${data[index].nomorBis}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromRGBO(
                                                    46, 70, 197, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Waktu: ${data[index].waktu.join(", ")}',
                                              style: const TextStyle(
                                                fontSize: 22,
                                                fontFamily: 'Lexend',
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromRGBO(
                                                    46, 70, 197, 1),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
