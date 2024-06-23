import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pobe/section/aqi_section.dart';
import 'package:pobe/section/category_section.dart';
import 'package:pobe/news_list.dart';
import 'package:pobe/news_report.dart';
import 'package:pobe/profile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pobe/set_destination.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _controller = PageController();
  bool _notificationsEnabled = false;

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
                        Stack(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _notificationsEnabled =
                                      !_notificationsEnabled;
                                });
                              },
                              icon: const Icon(
                                Icons.notifications_outlined,
                                color: Color.fromRGBO(31, 54, 113, 1),
                                size: 35,
                              ),
                            ),
                            if (_notificationsEnabled)
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: const BoxConstraints(
                                    minWidth: 18,
                                    minHeight: 18,
                                  ),
                                  child: const Text(
                                    '2',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 240,
                          width: double.infinity,
                          child: PageView(
                            controller: _controller,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/1.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.84,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    'assets/2.png',
                                    width: MediaQuery.of(context).size.width *
                                        0.82,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  'assets/3.png',
                                  width:
                                      MediaQuery.of(context).size.width * 0.84,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Discover BSD",
                          style: TextStyle(
                            color: Color.fromRGBO(31, 54, 113, 1),
                            fontSize: 20,
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SmoothPageIndicator(
                          controller: _controller,
                          count: 3,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: Color.fromRGBO(31, 54, 113, 1),
                            dotColor: Color.fromRGBO(31, 54, 111, 0.42),
                            dotHeight: 7,
                            dotWidth: 7,
                            expansionFactor: 4,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SetDestiny(
                                    startPoint: '',
                                    endPoint: '',
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(
                                    14, 47, 98, 1), // Dark blue color
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/bus.png'),
                                  const SizedBox(width: 20),
                                  const Text(
                                    "Find Your Transport With Us",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Lexend',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SetDestiny(
                                            startPoint: '',
                                            endPoint: '',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue[100],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "add a destination",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SetDestiny(
                                            startPoint: 'INTERMODA',
                                            endPoint: 'THE BREEZE',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Intermoda - The Breeze",
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(31, 54, 113, 1),
                                            fontSize: 14,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "l Category",
                      style: TextStyle(
                        color: Color.fromRGBO(31, 54, 113, 1),
                        fontSize: 20,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const CategoriesSection(),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "l News and Report",
                      style: TextStyle(
                        color: Color.fromRGBO(31, 54, 113, 1),
                        fontSize: 20,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const NewsListPage())),
                              );
                            },
                            child: FractionallySizedBox(
                              child: SizedBox(
                                height: 100,
                                child: Image.asset(
                                  'assets/news.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const NewsReportPage())),
                              );
                            },
                            child: Container(
                              height: 100,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.5, horizontal: 17.5),
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(209, 235, 254, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset(
                                'assets/report.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // AIR POLLUTION IN BSD
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "l Air Pollution in BSD",
                      style: TextStyle(
                        color: Color.fromRGBO(31, 54, 113, 1),
                        fontSize: 20,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w800,
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
      ),
    );
  }
}
