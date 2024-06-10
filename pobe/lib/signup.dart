import 'package:flutter/material.dart';
import 'package:pobe/splash/success_reg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Regist extends StatefulWidget {
  const Regist({super.key});

  @override
  State<Regist> createState() => _RegistState();
}

class _RegistState extends State<Regist> {
  bool _obscureText = true;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _registerUser() async {
    final url = Uri.parse('http://192.168.50.61:8000/api/signup/');
    final response = await http.post(
      url,
      body: json.encode({
        'username': _usernameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreenSignUp()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(80, 137, 198, 0.22),
                labelStyle: TextStyle(
                  color: Color.fromRGBO(31, 54, 113, 1),
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w300,
                ),
                labelText: 'Username',
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
              controller: _emailController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(80, 137, 198, 0.22),
                labelStyle: TextStyle(
                  color: Color.fromRGBO(31, 54, 113, 1),
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w300,
                ),
                labelText: 'Email',
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
              controller: _passwordController,
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
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _confirmPasswordController,
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
                labelText: 'Confirm Password',
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
              onPressed: _registerUser,
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                    Color.fromRGBO(31, 54, 113, 1)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                minimumSize:
                    const MaterialStatePropertyAll(Size(double.infinity, 50)),
              ),
              child: const Text(
                'Register a New Account',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lexend',
                  fontSize: 16,
                ),
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
                  minimumSize:
                      const MaterialStatePropertyAll(Size(double.infinity, 50)),
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
          ],
        ),
      ),
    );
  }
}
