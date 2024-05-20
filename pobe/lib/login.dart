import 'package:flutter/material.dart';
import 'package:pobe/forgotpass.dart';
import 'package:pobe/home.dart';
import 'package:pobe/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png'),
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
                  labelText: 'Password',
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPass(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Color.fromRGBO(80, 137, 198, 0.75),
                        fontSize: 12,
                        fontFamily: 'Lexend'),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
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
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'or',
                      style: TextStyle(fontFamily: 'Lexend'),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    minimumSize: const MaterialStatePropertyAll(
                        Size(double.infinity, 50)),
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromRGBO(0, 0, 0, 0.09))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/logo_google.png', // Ganti dengan path gambar logo Google Anda
                      width: 24, // Sesuaikan dengan ukuran logo Google
                      height: 24, // Sesuaikan dengan ukuran logo Google
                    ),
                    const SizedBox(width: 8), // Jarak antara logo dan teks
                    const Text(
                      'Continue with Google Account',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 12,
                        fontFamily: 'Lexend'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Regist(),
                        ),
                      );
                    },
                    child: const Text(
                      'Create a new account',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          fontFamily: 'Lexend'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
