import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ToGoDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const ToGoDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                    color: const Color.fromRGBO(31, 54, 113, 1),
                  ),
                  Text(
                    item['name'],
                    style: const TextStyle(
                      color: Color.fromRGBO(31, 54, 113, 1),
                      fontSize: 18,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    item['image'] ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'More Info',
                    style: TextStyle(
                      color: Color.fromRGBO(31, 54, 113, 1),
                      fontSize: 22,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${item['rating'] ?? '0.0'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      Image.asset('assets/togo/star.png'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/togo/loc.png'),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            item['location'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset('assets/togo/hour.png'),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            '${item['operational_day']} (${item['operational_hour']})',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset('assets/togo/call.png'),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            '${item['operational_day']} (${item['operational_hour']})',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset('assets/togo/price_blue.png'),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            '${item['min_price']}${item['max_price']} / person',
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Divider(
                color: Colors.black26,
              ),
              const SizedBox(height: 8),
              Text(
                item['desc'] ?? 'No Description',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
