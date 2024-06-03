import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios),
              color: const Color.fromRGBO(31, 54, 113, 1),
            ),
          ],
        ),
        title: const Text(
          'Back',
          style: TextStyle(
            color: Color.fromRGBO(31, 54, 113, 1),
            fontSize: 18,
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
