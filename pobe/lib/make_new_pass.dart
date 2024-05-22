import 'package:flutter/material.dart';
import 'package:pobe/splash/splash_forgot_pass.dart';

class NewPass extends StatefulWidget {
  const NewPass({super.key});

  @override
  State<NewPass> createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/logo.png',
              width: 125,
              height: 125,
            ),
            const Text(
              'Enter your new password',
              style: TextStyle(fontFamily: 'Lexend', fontSize: 22),
            ),
            const SizedBox(
              height: 30,
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
                labelText: 'Email or username',
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
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(80, 137, 198, 0.22),
                labelStyle: const TextStyle(
                  color: Color.fromRGBO(31, 54, 113, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Lexend',
                ),
                labelText: 'New Password',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.5)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromRGBO(31, 54, 113, 1),
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(80, 137, 198, 0.22),
                labelStyle: const TextStyle(
                  color: Color.fromRGBO(31, 54, 113, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Lexend',
                ),
                labelText: 'Confirm New Password',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.5)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromRGBO(31, 54, 113, 1),
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
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
