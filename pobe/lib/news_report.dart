// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pobe/help.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:pobe/splash/reported.dart';
import 'package:pobe/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsReportPage extends StatefulWidget {
  const NewsReportPage({super.key});

  @override
  State<NewsReportPage> createState() => _NewsReportPageState();
}

class _NewsReportPageState extends State<NewsReportPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool _isLoading = false;
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('email') ?? '';
    });
  }

  File? _image;
  bool _isChecked = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> sendData(String title, String content, File? imageFile) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // var url = Uri.parse('http://192.168.50.64:8000/reports/');
      var url = Uri.parse('https://rhmdziz.pythonanywhere.com/reports/');
      var request = http.MultipartRequest('POST', url);
      request.fields['title'] = title;
      request.fields['author'] = userEmail;
      request.fields['content'] = content;

      TokenStorage tokenStorage = TokenStorage();
      String? accessToken = await tokenStorage.getAccessToken();

      if (accessToken == null) {
        throw Exception('Access token not found');
      }

      request.headers['Authorization'] = 'Bearer $accessToken';

      if (imageFile != null) {
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile('image', stream, length,
            filename: imageFile.path.split('/').last);
        request.files.add(multipartFile);
      }
      var response = await http.Response.fromStream(await request.send());
      print(response.statusCode);
      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreenReported()),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _report(String title, String content, File? imageFile) {
    if (_isChecked) {
      sendData(title, content, imageFile);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content:
                const Text("Please check the box before sending the report."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios),
                      color: const Color.fromRGBO(31, 54, 113, 1),
                    ),
                    const Text(
                      'Report',
                      style: TextStyle(
                        color: Color.fromRGBO(31, 54, 113, 1),
                        fontSize: 18,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const HelpPage())),
                    );
                  },
                  icon: const Icon(
                    Icons.help_rounded,
                    color: Color.fromRGBO(31, 54, 113, 1),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  'Report Title',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ' *',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 0, 0, 1),
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(77, 133, 241, 0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Write a title',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Text(
                  'Tell us what happened?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ' *',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 0, 0, 1),
                    fontSize: 18,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(77, 133, 241, 0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: 'Write a report',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Upload a File',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(77, 133, 241, 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _image == null
                    ? Center(
                        child: Image.asset(
                          'assets/news/add_file.png',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.file(
                        File(_image!.path),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '* Required',
              style: TextStyle(
                color: Color.fromRGBO(255, 0, 0, 1),
                fontSize: 14,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
                const Flexible(
                  child: Text(
                    'By checking this box I am willing to follow the existing terms and conditions and am ready to accept sanctions if I am found to have violated the terms and conditions of PoBe',
                    style: TextStyle(
                      color: Color.fromRGBO(31, 54, 113, 1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      _report(
                          titleController.text, contentController.text, _image);
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
                      'Send',
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
