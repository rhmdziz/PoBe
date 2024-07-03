// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pobe/edit_profile.dart';
import 'package:pobe/help.dart';
import 'package:pobe/login.dart';
import 'package:pobe/setting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String accessToken;
  late String userUrl;
  late Map<String, dynamic> userDetails = {};

  String userName = '';

  @override
  void initState() {
    super.initState();
    _getUserDetails();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? '';
    });
  }

  Future<void> _getUserDetails() async {
    TokenStorage tokenStorage = TokenStorage();
    accessToken = await tokenStorage.getAccessToken() ?? '';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    userUrl =
        prefs.getString('url') ?? 'https://rhmdziz.pythonanywhere.com/api/users/2/';

    try {
      // var userDetailUrl = Uri.parse(userUrl);
      var response = await http.get(
        Uri.parse(userUrl),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          userDetails = jsonDecode(response.body);
        });
        print('User details: $userDetails');
      } else {
        throw Exception('Failed to fetch user details');
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
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
                      'Back',
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
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/profile/user.png'),
              const SizedBox(
                height: 10,
              ),
              Text(
                userName,
                style: const TextStyle(
                  color: Color.fromRGBO(31, 54, 113, 1),
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(209, 235, 254, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(children: [
                Positioned(
                    bottom: -100,
                    right: -125,
                    child: Image.asset('assets/stack_elemen_2.png')),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const EditProfilePage()),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset('assets/profile/edit.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Edit Profile',
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
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 2.5),
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const SettingPage()),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset('assets/profile/setting.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Setting',
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
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            const url =
                                'https://wa.me/6285700435141?text=Hi,%20Aziz!';
                            launchUrl(Uri.parse(url));
                          },
                          child: Row(
                            children: [
                              Image.asset('assets/profile/cs.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Customer Service',
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(31, 54, 113, 1),
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const Login()),
                              (route) => false,
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset('assets/profile/keluar.png'),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Keluar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
