// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pobe/help.dart';
import './news_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pobe/login.dart';

class NewsComment {
  final int id;
  final String name;
  final DateTime datetime;
  final String comment;
  final int newsId;

  NewsComment({
    required this.id,
    required this.name,
    required this.datetime,
    required this.comment,
    required this.newsId,
  });

  factory NewsComment.fromJson(Map<String, dynamic> json) {
    return NewsComment(
      id: json['id'],
      name: json['name'],
      datetime: DateTime.parse(json['datetime']),
      comment: json['comment'],
      newsId: json['newsId'],
    );
  }
}

class NewsDetailPage extends StatefulWidget {
  final News news;
  const NewsDetailPage({super.key, required this.news});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool _isChecked = false;
  bool _isLoading = false;
  TextEditingController commentController = TextEditingController();
  String userName = '';
  List<NewsComment> newsComment = [];

  @override
  void initState() {
    super.initState();
    _loadUserName();
    fetchNewsComment();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'user';
    });
  }

  Future<void> fetchNewsComment() async {
    TokenStorage tokenStorage = TokenStorage();
    String? accessToken = await tokenStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    const url = 'https://rhmdziz.pythonanywhere.com/newscomment/';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<NewsComment> fetchedComment = [];
      for (var commentData in data) {
        if (commentData['newsId'] == widget.news.url) {
          fetchedComment.add(NewsComment.fromJson(commentData));
        }
      }
      setState(() {
        newsComment = fetchedComment;
      });
    } else {
      throw Exception('Failed to load food comment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 52,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            'Back',
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
                  Text(
                    widget.news.title,
                    style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 26,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${DateFormat('EEEE').format(DateTime.parse(widget.news.datetime))} ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(widget.news.datetime))} WIB',
                      style: const TextStyle(
                        color: Color.fromRGBO(31, 54, 113, 0.59),
                        fontSize: 16,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7.5),
                    child: Image.network(
                      widget.news.image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  HtmlWidget(
                    widget.news.content,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(50, 50, 50, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'by ${widget.news.author}',
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.65),
                        fontSize: 18,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/news/view.png'),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.news.views,
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.65),
                          fontSize: 18,
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      // Image.asset('assets/news/up.png'),
                      // Text(
                      //   news.up,
                      //   style: const TextStyle(
                      //     color: Color.fromRGBO(0, 0, 0, 0.65),
                      //     fontSize: 15,
                      //     fontFamily: 'Lexend',
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 130,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(206, 232, 253, 1),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Comments',
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontSize: 20,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        _showAddCommentModal(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(31, 54, 113, 1)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        minimumSize: const MaterialStatePropertyAll(
                            Size(double.infinity, 50)),
                      ),
                      child: const Text(
                        'Add comment',
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: newsComment.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 65,
                              height: 65,
                              child: Image.asset(
                                'assets/profile/user.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    newsComment[index].name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lexend',
                                      color: Color.fromRGBO(31, 54, 113, 1),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat('dd-MM-yyyy HH:mm')
                                        .format(newsComment[index].datetime),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Lexend',
                                      color: Color.fromRGBO(31, 54, 113, 0.5),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '"${newsComment[index].comment}"',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Lexend',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Color.fromARGB(22, 0, 0, 0),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCommentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(builder: (context, setModalState) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 32,
            right: 32,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Comment',
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
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(77, 133, 241, 0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 3,
                  controller: commentController,
                  decoration: const InputDecoration(
                    hintText: 'Write comment',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setModalState(() {
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
              const SizedBox(height: 16),
              TextButton(
                onPressed: _isChecked
                    ? () async {
                        setState(() {
                          _isLoading = true;
                        });

                        TokenStorage tokenStorage = TokenStorage();
                        String? accessToken =
                            await tokenStorage.getAccessToken();

                        final requestData = {
                          "name": userName,
                          "comment": commentController.text,
                          "newsId": widget.news.url,
                        };

                        print("Request Data: $requestData");

                        final response = await http.post(
                          Uri.parse(
                              'https://rhmdziz.pythonanywhere.com/newscomment/'),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $accessToken',
                          },
                          body: json.encode(requestData),
                        );
                        print(response.statusCode);

                        setState(() {
                          _isLoading = false;
                        });

                        if (response.statusCode == 201) {
                          Navigator.pop(context); // Close the modal
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Comment added successfully!'),
                              backgroundColor: Color.fromRGBO(31, 54, 113, 1),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to add comment.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    : null,
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
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    );
  }
}
