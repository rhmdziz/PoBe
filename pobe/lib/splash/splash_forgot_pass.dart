import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:pobe/home.dart';

class SplashScreenForgotPass extends StatefulWidget {
  const SplashScreenForgotPass({super.key});

  @override
  State<SplashScreenForgotPass> createState() => _SplashScreenForgotPassState();
}

class _SplashScreenForgotPassState extends State<SplashScreenForgotPass>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const HomePage(),
      ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/success.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Your Password Has Been Updated',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(31, 54, 113, 1),
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Lexend',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
