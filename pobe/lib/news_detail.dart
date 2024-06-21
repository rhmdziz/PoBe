import 'package:flutter/material.dart';
import 'package:pobe/help.dart';
import './news_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;
  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                news.title,
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
              Text(
                '${DateFormat('EEEE').format(DateTime.parse(news.datetime))} ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(news.datetime))} WIB',
                style: const TextStyle(
                  color: Color.fromRGBO(31, 54, 113, 0.59),
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(7.5),
                child: Image.network(
                  news.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              HtmlWidget(
                news.content,
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(50, 50, 50, 1),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'by ${news.author}',
                style: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 0.65),
                  fontSize: 18,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
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
                    news.views,
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
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
