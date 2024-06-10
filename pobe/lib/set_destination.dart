import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pobe/help.dart';

class SetDestiny extends StatefulWidget {
  const SetDestiny({super.key});

  @override
  State<SetDestiny> createState() => _SetDestinyState();
}

class _SetDestinyState extends State<SetDestiny> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
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
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            width: double.infinity,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Insert your starting point',
                    style: TextStyle(
                      color: Color.fromARGB(255, 26, 159, 255),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Image.asset('assets/starting.png'),
                          const SizedBox(
                            width: 15,
                          ),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Starting Point ...',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 26, 159, 255),
                                  fontSize: 16,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w300,
                                ),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Insert your end point',
                    style: TextStyle(
                      color: Color.fromARGB(255, 26, 159, 255),
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.25),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Image.asset('assets/end.png'),
                          const SizedBox(
                            width: 15,
                          ),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'End Point ...',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 26, 159, 255),
                                  fontSize: 16,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w300,
                                ),
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'From',
                            style: TextStyle(
                              color: Color.fromARGB(255, 26, 159, 255),
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: 175,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.25),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: '--',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 26, 159, 255),
                                  fontSize: 16,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w300,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'To',
                            style: TextStyle(
                              color: Color.fromARGB(255, 26, 159, 255),
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            width: 175,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.withOpacity(0.25),
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: '--',
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 26, 159, 255),
                                  fontSize: 16,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w300,
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromRGBO(31, 54, 113, 1)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      minimumSize: const MaterialStatePropertyAll(
                          Size(double.infinity, 50)),
                    ),
                    child: const Text(
                      'Find Transportation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Text(
              "Your Body Content Here",
              style: TextStyle(
                fontFamily: 'Lexend',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
