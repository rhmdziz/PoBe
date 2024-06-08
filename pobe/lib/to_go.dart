import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pobe/help.dart';
import 'package:pobe/to_to_detail.dart';
import './to_go_service.dart';

class ToGo extends StatefulWidget {
  final String category;

  const ToGo({super.key, required this.category});

  @override
  State<ToGo> createState() => _ToGoState();
}

class _ToGoState extends State<ToGo> {
  late Future<List<dynamic>> futureCategoryData;

  @override
  void initState() {
    super.initState();
    futureCategoryData = ApiService().fetchCategoryData(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
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
                    Text(
                      widget.category,
                      style: const TextStyle(
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
                        builder: ((context) => const HelpPage()),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.help_rounded,
                    color: Color.fromRGBO(31, 54, 113, 1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Nearby ${widget.category}',
              style: const TextStyle(
                color: Color.fromRGBO(31, 54, 113, 1),
                fontSize: 18,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: futureCategoryData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data found'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var item = snapshot.data![index];
                        return Card(
                          elevation: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ToGoDetailPage(item: item),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(7.5),
                                        child: Image.network(
                                          item['image'],
                                          width: 90,
                                          height: 90,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item['name'] ?? 'No Name',
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      24, 24, 24, 1),
                                                  fontSize: 20,
                                                  fontFamily: 'Lexend',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                item['desc'] ??
                                                    'No Description',
                                                style: const TextStyle(
                                                  color: Color.fromRGBO(
                                                      24, 24, 24, 1),
                                                  fontSize: 14,
                                                  fontFamily: 'Lexend',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: List.generate(
                                                          () {
                                                            try {
                                                              return int.parse(item[
                                                                  'rating']); // Convert the rating to an int
                                                            } catch (e) {
                                                              return 0; // Default to 0 stars if there's an error
                                                            }
                                                          }(),
                                                          (index) => Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right:
                                                                        4.0), // Add spacing between stars
                                                            child: Image.asset(
                                                                'assets/togo/star.png'),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        '(${item['review']})',
                                                        style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              24, 24, 24, 1),
                                                          fontSize: 14,
                                                          fontFamily: 'Lexend',
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: List.generate(
                                                      () {
                                                        try {
                                                          return int.parse(
                                                              item['price']);
                                                        } catch (e) {
                                                          return 0;
                                                        }
                                                      }(),
                                                      (index) => Padding(
                                                        padding: const EdgeInsets
                                                            .only(
                                                            right:
                                                                4.0), // Add spacing between stars
                                                        child: Image.asset(
                                                            'assets/togo/price.png'),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  const Divider(
                                    color: Colors.black26,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
