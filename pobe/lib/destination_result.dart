// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:http/http.dart' as http;
import 'package:pobe/help.dart';
import 'package:intl/intl.dart';

DateTime parseTime2(String timeString) {
  final format = DateFormat('HH:mm:ss');
  return format.parseStrict(timeString);
}

DateTime parseTime(String timeString) {
  final format = DateFormat('HH:mm');
  return format.parseStrict(timeString);
}

class ResultDestiny extends StatefulWidget {
  final String startPoint;
  final String endPoint;
  final String fromTime;
  final String toTime;
  final String startPointId;
  final String endPointId;

  const ResultDestiny({
    super.key,
    required this.startPoint,
    required this.endPoint,
    required this.fromTime,
    required this.toTime,
    required this.startPointId,
    required this.endPointId,
  });

  @override
  State<ResultDestiny> createState() => _ResultDestinyState();
}

class BusSchedule {
  final int rute;
  final int halte;
  final int nomorBis;
  final String url;
  final List<String> waktu;

  BusSchedule({
    required this.rute,
    required this.halte,
    required this.nomorBis,
    required this.url,
    required this.waktu,
  });

  factory BusSchedule.fromJson(Map<String, dynamic> json) {
    return BusSchedule(
      url: json['url'],
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
    );
  }

  List<String> getWaktuWithinRange(String fromTime, String toTime) {
    DateTime from = parseTime(fromTime);
    DateTime to = parseTime(toTime);

    return waktu.where((waktu) {
      DateTime time = parseTime2(waktu);
      return time.isAfter(from) && time.isBefore(to);
    }).toList();
  }
}

class _ResultDestinyState extends State<ResultDestiny> {
  late Future<List<BusSchedule>> futureBusSchedules;
  late Map<String, String> ruteMap;
  late Map<String, String> halteMap;

  @override
  void initState() {
    super.initState();
    futureBusSchedules = fetchBusSchedules();
    ruteMap = {};
    halteMap = {};
    fetchRuteMap();
    fetchHalteMap();
  }

  Future<List<String>> fetchBusRoutes(String ruteId) async {
    final response = await http
        .get(Uri.parse('http://192.168.50.226:8000/busroutes/$ruteId'));

    print(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<String> routes = List<String>.from(data['rute']);
      return routes;
    } else {
      throw Exception('Failed to load bus routes');
    }
  }

  Future<void> fetchRuteMap() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.50.226:8000/busroutes/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        ruteMap = {
          for (var item in jsonResponse)
            item['id'].toString(): item['nama_rute']
        };
        setState(() {});
      } else {
        throw Exception('Failed to load bus routes');
      }
    } catch (e) {
      print('Error fetching bus routes: $e');
    }
  }

  Future<void> fetchHalteMap() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.50.226:8000/haltes/'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        halteMap = {
          for (var item in jsonResponse)
            item['id'].toString(): item['nama_halte']
        };
        setState(() {});
      } else {
        throw Exception('Failed to load haltes');
      }
    } catch (e) {
      print('Error fetching haltes: $e');
    }
  }

  Future<List<BusSchedule>> fetchBusSchedules() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.50.226:8000/busscheduls/'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<BusSchedule> busSchedules =
            jsonResponse.map((data) => BusSchedule.fromJson(data)).toList();

        return filterSchedules(busSchedules);
      } else {
        throw Exception('Failed to load bus schedules');
      }
    } catch (e) {
      print('Error fetching bus schedules: $e');
      rethrow;
    }
  }

  List<BusSchedule> filterSchedules(List<BusSchedule> schedules) {
    try {
      List<BusSchedule> filteredSchedules = schedules.where((schedule) {
        bool isStartPointMatch =
            schedule.halte.toString() == widget.startPointId;

        print('CORET');

        bool isWithinRange = schedule.waktu.any((waktu) {
          DateTime time = parseTime2(waktu);
          DateTime fromTime = parseTime(widget.fromTime);
          DateTime toTime = parseTime(widget.toTime);

          return time.isAfter(fromTime) && time.isBefore(toTime);
        });

        return isStartPointMatch && isWithinRange;
      }).toList();

      return filteredSchedules;
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
            const SizedBox(height: 40),
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
                    const SizedBox(height: 60),
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
                          const SizedBox(height: 2.5),
                          Text(
                            '${widget.fromTime} - ${widget.toTime}',
                            style: const TextStyle(
                              color: Color.fromRGBO(31, 54, 113, 1),
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 15,
                    color: Color.fromRGBO(250, 135, 0, 1),
                  ),
                  SizedBox(width: 5),
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
            const SizedBox(height: 10),
            FutureBuilder<List<BusSchedule>>(
              future: futureBusSchedules,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data found'));
                } else {
                  List<BusSchedule> data = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<List<String>>(
                        future: fetchBusRoutes(data[index].rute.toString()),
                        builder: (context, routeSnapshot) {
                          if (routeSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (routeSnapshot.hasError) {
                            return Center(
                                child: Text('Error: ${routeSnapshot.error}'));
                          } else if (!routeSnapshot.hasData ||
                              routeSnapshot.data!.isEmpty) {
                            return const Center(child: Text('No routes found'));
                          } else {
                            List<String> routes = routeSnapshot.data!;
                            if (!routes.contains(widget.endPoint)) {
                              return Container(); // Skip rendering if endPoint is not in routes
                            }
                            List<String> filteredTimes = data[index]
                                .getWaktuWithinRange(
                                    widget.fromTime, widget.toTime);
                            String ruteName =
                                ruteMap[data[index].rute.toString()] ??
                                    'Unknown Route';
                            String halteName =
                                halteMap[data[index].halte.toString()] ??
                                    'Unknown Halte';

                            return Column(
                              children: filteredTimes.map((time) {
                                return GestureDetector(
                                  onTap: () {
                                    _showBusScheduleDetails(data[index], time);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 8),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 100,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  250, 135, 0, 1),
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
                                          Container(
                                            height: 100,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 190,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          halteName,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'Lexend',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Color.fromRGBO(
                                                                    46,
                                                                    70,
                                                                    197,
                                                                    1),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              ruteName,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Lexend',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        1),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Nomor Bis: ${data[index].nomorBis}',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Lexend',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        46,
                                                                        70,
                                                                        197,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: double.infinity,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        time.substring(0, 5),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 26,
                                                          fontFamily: 'Lexend',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color.fromRGBO(
                                                              46, 70, 197, 1),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      );
                    },
                  );
                }
              },
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  void _showBusScheduleDetails(BusSchedule schedule, time) {
    showModalBottomSheet(
        context: context,
        // isScrollControlled: true,
        builder: (BuildContext context) {
          String ruteName =
              ruteMap[schedule.rute.toString()] ?? 'Unknown Route';
          String halteName =
              halteMap[schedule.halte.toString()] ?? 'Unknown Halte';
          return FutureBuilder<List<String>>(
            future: fetchBusRoutes(schedule.rute.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load bus routes'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No routes available'));
              } else {
                List<String> routes = snapshot.data!;
                return Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(250, 135, 0, 1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Text(
                          ruteName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Starting Point:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(1, 1, 1, 1),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width: 175,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              0, 144, 250, 0.15),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        halteName,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(1, 1, 1, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'End Point:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w300,
                                        color: Color.fromRGBO(1, 1, 1, 1),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width: 175,
                                      decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              0, 144, 250, 0.15),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        widget.endPoint,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromRGBO(1, 1, 1, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 350,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: routes.map((route) {
                                    bool isHighlighted =
                                        route == widget.startPoint ||
                                            route == widget.endPoint;
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.circle,
                                                color: Color.fromRGBO(
                                                    0, 148, 250, 1),
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                route,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize:
                                                      isHighlighted ? 20 : 16,
                                                  fontFamily: 'Lexend',
                                                  fontWeight: isHighlighted
                                                      ? FontWeight.w700
                                                      : FontWeight.w300,
                                                  color: const Color.fromRGBO(
                                                      1, 1, 1, 1),
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Text(
                                          //   // WAKTU NYA TULIS DI SINI
                                          // );
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        });
  }
}
