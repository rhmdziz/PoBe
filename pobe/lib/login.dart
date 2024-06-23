// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pobe/forgot_pass.dart';
import 'package:pobe/home.dart';
import 'package:pobe/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  late String _csrfToken = '';
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCsrfToken();
  }

  void _getCsrfToken() async {
    var response = await http.get(
      Uri.parse('http://192.168.50.226:8000/api-auth/login/'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _csrfToken = response.headers['set-cookie'] ?? '';
      });
    }
  }

  void _login(String username, String password) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    setState(() {
      _isLoading = true;
    });

    var response = await http.post(
      Uri.parse(
          // 'http://10.10.162.4:8000/api-auth/login/?next=/'),
          'http://192.168.50.226:8000/api-auth/login/'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': _csrfToken,
      },
      body: {
        'username': username,
        'password': password,
        'csrfmiddlewaretoken': _extractCsrfToken(),
      },
    );

    print(response.statusCode);

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 302) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const HomePage(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please check your credentials.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String _extractCsrfToken() {
    return _csrfToken.split(';')[0].split('=')[1];
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
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(80, 137, 198, 0.22),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(31, 54, 113, 1),
                    fontSize: 16,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w300,
                  ),
                  hintText: 'Username',
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
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(31, 54, 113, 1),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Lexend',
                  ),
                  hintText: 'Password',
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
                        builder: (context) => ForgotPass(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Color.fromRGBO(80, 137, 198, 0.75),
                        fontSize: 14,
                        fontFamily: 'Lexend'),
                  ),
                ),
              ),
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        _login(
                            _usernameController.text, _passwordController.text);
                      },
                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                      Color.fromRGBO(31, 54, 113, 1)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  minimumSize:
                      const MaterialStatePropertyAll(Size(double.infinity, 50)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        'Login',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo_google.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Continue with Google Account',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lexend',
                          fontSize: 16),
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
                        fontSize: 14,
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
                          fontSize: 14,
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
