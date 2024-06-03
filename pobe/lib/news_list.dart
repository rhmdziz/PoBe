// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:pobe/help.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class News {
  final String url;
  final String title;
  final String author;
  final String datetime;
  final String content;
  final String views;
  final String up;
  final String image;

  News({
    required this.url,
    required this.title,
    required this.author,
    required this.datetime,
    required this.content,
    required this.views,
    required this.up,
    required this.image,
  });
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      url: json['url'],
      title: json['title'],
      author: json['author'],
      datetime: json['datetime'],
      content: json['content'],
      views: json['views'],
      up: json['up'],
      image: json['image'],
    );
  }
}

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  late Future<List<News>> futureNews;
  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  Future<List<News>> fetchNews() async {
    final response =
        await http.get(Uri.parse('http://192.168.50.61:8000/newss/'));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<News> newsList = data.map((json) => News.fromJson(json)).toList();
      return newsList;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
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
                      'News',
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
            Expanded(
              child: FutureBuilder<List<News>>(
                future: futureNews,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No news available'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        News news = snapshot.data![index];
                        return Card(
                          child: ListTile(
                            leading: Image.network(news.image,
                                width: 100, fit: BoxFit.cover),
                            title: Text(news.title),
                            subtitle: Text('${news.author} | ${news.datetime}'),
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         NewsDetailPage(news: news),
                              //   ),
                              // );
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
