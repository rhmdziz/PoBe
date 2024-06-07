import 'package:flutter/material.dart';
import 'package:pobe/aqi_section.dart';
import 'package:pobe/news_list.dart';
import 'package:pobe/news_report.dart';
import 'package:pobe/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              left: -150,
              top: -150,
              child: Image.asset('assets/stack_elemen.png'),
            ),
            Positioned(
              right: -200,
              top: 500,
              child: Image.asset('assets/stack_elemen.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const ProfilePage())),
                          );
                        },
                        icon: const Icon(
                          Icons.account_circle_outlined,
                          color: Color.fromRGBO(31, 54, 113, 1),
                          size: 35,
                        ),
                      ),
                      Image.asset(
                        'assets/logo.png', // Path to your logo asset
                        height: 50,
                      ),
                      const Icon(
                        Icons.notifications_outlined,
                        color: Color.fromRGBO(31, 54, 113, 1),
                        size: 35,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 195,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/1.png',
                            width: MediaQuery.of(context).size.width * 0.84,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/2.png',
                              width: MediaQuery.of(context).size.width * 0.82,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/3.png',
                            width: MediaQuery.of(context).size.width * 0.84,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Discover BSD",
                    style: TextStyle(
                      color: Color.fromRGBO(31, 54, 113, 1),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "l Category",
                    style: TextStyle(
                      color: Color.fromRGBO(31, 54, 113, 1),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // CATEGORY
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(140, 201, 246, 1),
                                borderRadius: BorderRadius.circular(7.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(209, 235, 254, 1),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                  child:
                                      Image.asset('assets/category/food.png'),
                                ),
                                const Text(
                                  'Food',
                                  style: TextStyle(
                                    color: Color.fromRGBO(31, 54, 113, 1),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(140, 201, 246, 1),
                                borderRadius: BorderRadius.circular(7.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(209, 235, 254, 1),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                  child: Image.asset(
                                      'assets/category/shopping.png'),
                                ),
                                const Text(
                                  'Shopping',
                                  style: TextStyle(
                                    color: Color.fromRGBO(31, 54, 113, 1),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(140, 201, 246, 1),
                                borderRadius: BorderRadius.circular(7.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(209, 235, 254, 1),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                  child:
                                      Image.asset('assets/category/mall.png'),
                                ),
                                const Text(
                                  'Mall',
                                  style: TextStyle(
                                    color: Color.fromRGBO(31, 54, 113, 1),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(140, 201, 246, 1),
                                borderRadius: BorderRadius.circular(7.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(209, 235, 254, 1),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                  child: Image.asset(
                                      'assets/category/hospital.png'),
                                ),
                                const Text(
                                  'Hospital',
                                  style: TextStyle(
                                    color: Color.fromRGBO(31, 54, 113, 1),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(140, 201, 246, 1),
                                borderRadius: BorderRadius.circular(7.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(209, 235, 254, 1),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                  child:
                                      Image.asset('assets/category/sport.png'),
                                ),
                                const Text(
                                  'Sport',
                                  style: TextStyle(
                                    color: Color.fromRGBO(31, 54, 113, 1),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(140, 201, 246, 1),
                                borderRadius: BorderRadius.circular(7.5)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(209, 235, 254, 1),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                  child: Image.asset(
                                      'assets/category/entertain.png'),
                                ),
                                const Text(
                                  'Entertain',
                                  style: TextStyle(
                                    color: Color.fromRGBO(31, 54, 113, 1),
                                    fontSize: 15,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  // NEWS AND REPORT
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "l News and Report",
                    style: TextStyle(
                      color: Color.fromRGBO(31, 54, 113, 1),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const NewsListPage())),
                          );
                        },
                        child: SizedBox(
                          width: 160,
                          height: 100,
                          child: Image.asset(
                            'assets/news.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const NewsReportPage())),
                          );
                        },
                        child: Container(
                          width: 170,
                          height: 100,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.5, horizontal: 17.5),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(209, 235, 254, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            'assets/report.png',
                            fit: BoxFit.cover,
                          ),
                          // rgba(209, 235, 254, 1)
                        ),
                      ),
                    ],
                  ),
                  // AIR POLUTION IN BSD
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "l Air Polution in BSD",
                    style: TextStyle(
                      color: Color.fromRGBO(31, 54, 113, 1),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AqiSection(),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
