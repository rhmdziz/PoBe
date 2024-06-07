// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pobe/help.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pobe/news_detail.dart';

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
  String selectedTab = 'Latest';

  void onTabTap(String tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  late Future<List<News>> futureNews;
  @override
  void initState() {
    super.initState();
    futureNews = fetchNews();
  }

  Future<List<News>> fetchNews() async {
    final response =
        // await http.get(Uri.parse('http://192.168.50.61:8000/newss/'));
        await http.get(Uri.parse('http://10.10.161.232:8000/newss/'));
    // print(response.body);
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
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            child: Row(
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
          ),
          Container(
            width: double.infinity,
            height: 250,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(31, 54, 113, 1),
            ),
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
                    scrollDirection: Axis.horizontal,
                    // itemCount: snapshot.data!.length,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      News news = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewsDetailPage(news: news)),
                          );
                        },
                        child: Container(
                          width: 300,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 7.5, vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.075),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  news.image,
                                  height: 210,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.8),
                                        Colors.black.withOpacity(0.0),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        news.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        '${news.author} | ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(news.datetime))}',
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(231, 125, 48, 1),
                                          fontSize: 12,
                                          fontFamily: 'Lexend',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // TABS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTab('Latest'),
                buildTab('Trending'),
                buildTab('Politic'),
                buildTab('Pop'),
              ],
            ),
          ),
          // NEWS LIST
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
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
                            child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewsDetailPage(news: news)),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.5, horizontal: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.075),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(7.5),
                                  child: Image.network(
                                    news.image,
                                    width: 125,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          news.title,
                                          style: const TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontSize: 14,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '${news.author} | ${DateFormat('dd-MM-yyyy').format(DateTime.parse(news.datetime))}',
                                          style: const TextStyle(
                                            color:
                                                Color.fromRGBO(231, 125, 48, 1),
                                            fontSize: 13,
                                            fontFamily: 'Lexend',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ));
                      },
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTab(String tab) {
    return GestureDetector(
      onTap: () => onTabTap(tab),
      child: Text(
        tab,
        style: TextStyle(
          color: selectedTab == tab
              ? const Color.fromRGBO(231, 125, 48, 1)
              : Colors.black,
          fontSize: 16,
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
