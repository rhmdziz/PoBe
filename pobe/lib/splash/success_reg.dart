import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:pobe/home.dart';

class SplashScreenSignUp extends StatefulWidget {
  const SplashScreenSignUp({super.key});

  @override
  State<SplashScreenSignUp> createState() => _SplashScreenSignUpState();
}

class _SplashScreenSignUpState extends State<SplashScreenSignUp>
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
                'Your Account Has Been Registered',
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
