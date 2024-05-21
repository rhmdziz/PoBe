import 'package:flutter/material.dart';
import 'package:pobe/splash/splash_forgot_pass.dart';

class ForgotPass extends StatelessWidget {
  const ForgotPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Back',
          style: TextStyle(
              color: Color.fromRGBO(31, 54, 113, 1),
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontFamily: 'Lexend'),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color.fromRGBO(31, 54, 113, 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png',
              width: 175,
              height: 175,
            ),
            const Text(
              'Forgot Password',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(80, 137, 198, 0.22),
                labelStyle: TextStyle(
                  color: Color.fromRGBO(31, 54, 113, 1),
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w300,
                ),
                labelText: 'Enter email or username',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.5)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreenForgotPass(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromRGBO(31, 54, 113, 1)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.infinity, 50)),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lexend',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
