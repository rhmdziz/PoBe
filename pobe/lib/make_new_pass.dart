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

  bool _obscureText2 = true;

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureText2 = !_obscureText2;
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
            const SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(80, 137, 198, 0.22),
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(31, 54, 113, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Lexend',
                ),
                hintText: 'New Password',
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
              obscureText: _obscureText2,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(80, 137, 198, 0.22),
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(31, 54, 113, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Lexend',
                ),
                hintText: 'Confirm New Password',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.5)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText2 ? Icons.visibility : Icons.visibility_off,
                    color: const Color.fromRGBO(31, 54, 113, 1),
                  ),
                  onPressed: _toggleConfirmPasswordVisibility,
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
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
