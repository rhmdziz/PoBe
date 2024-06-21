import 'package:flutter/material.dart';
import 'package:pobe/make_new_pass.dart';
import 'package:flutter/services.dart';

class InsertOtp extends StatelessWidget {
  final String emailOrUsername;
  const InsertOtp({super.key, required this.emailOrUsername});

  @override
  Widget build(BuildContext context) {
    final String displayEmailOrUsername =
        emailOrUsername.isNotEmpty ? emailOrUsername : "aziz@gmail.com";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/otp.png'),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Insert OTP Code',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'We have sent OTP code to $displayEmailOrUsername',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return SizedBox(
                    width: 60,
                    height: 60,
                    child: TextField(
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Lexend',
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Color.fromRGBO(80, 137, 198, 0.22),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7.5)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '45 seconds before the current OTP code couldn’t be used',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const NewPass(),
                  ));
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
                    fontSize: 18,
                    fontFamily: 'Lexend',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Did not receive the code? ',
                    ),
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(
                        color: Color.fromRGBO(31, 54, 113, 1),
                      ),
                    ),
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
