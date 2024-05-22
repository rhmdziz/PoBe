import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.account_circle_outlined,
          color: Color.fromRGBO(31, 54, 113, 1),
          size: 35,
        ),
        onPressed: () {
          // Handle profile icon press
        },
      ),
      title: Center(
        child: Image.asset(
          'assets/logo.png', // Path to your logo asset
          height: 50,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: Color.fromRGBO(31, 54, 113, 1),
            size: 35,
          ),
          onPressed: () {
            // Handle notification icon press
          },
        ),
      ],
    ));
  }
}
