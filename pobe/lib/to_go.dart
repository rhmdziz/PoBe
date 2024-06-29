import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pobe/help.dart';
import 'package:pobe/section/to_go_map_section.dart';
import 'package:pobe/to_go_detail.dart';
import 'service/to_go_service.dart';

class ToGo extends StatefulWidget {
  final String category;

  const ToGo({super.key, required this.category});

  @override
  State<ToGo> createState() => _ToGoState();
}

class _ToGoState extends State<ToGo> {
  late Future<List<dynamic>> futureCategoryData;
  late String apiUrl;

  String selectedPriceFilter = 'Price';
  String selectedRatingFilter = 'Rating';

  @override
  void initState() {
    super.initState();
    final apiService = ApiService();
    apiUrl =
        '${apiService.baseUrl}${apiService.endpoints[widget.category] ?? ''}';
    futureCategoryData = apiService.fetchCategoryData(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
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
          ),
          ToGoMaps(apiUrl: apiUrl),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
            child: Text(
              'Nearby ${widget.category}',
              style: const TextStyle(
                color: Color.fromRGBO(31, 54, 113, 1),
                fontSize: 18,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // INI FILTER
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          //   child: Row(
          //     children: [
          //       const Icon(
          //         Icons.filter_list,
          //         color: Colors.grey,
          //       ),
          //       const SizedBox(width: 8),
          //       const Text(
          //         'Filter :',
          //         style: TextStyle(
          //           color: Color.fromRGBO(0, 0, 0, 0.75),
          //           fontSize: 16,
          //           fontFamily: 'Lexend',
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //       const SizedBox(width: 8),
          //       FilterDropdown(
          //         title: 'Price',
          //         onChanged: (newValue) {
          //           setState(() {
          //             selectedPriceFilter = newValue;
          //           });
          //         },
          //       ),
          //       const SizedBox(width: 8),
          //       FilterDropdown(
          //         title: 'Rating',
          //         onChanged: (newValue) {
          //           setState(() {
          //             selectedRatingFilter = newValue;
          //           });
          //         },
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
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
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
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
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    item['name'] ?? 'No Name',
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          24, 24, 24, 1),
                                                      fontSize: 20,
                                                      fontFamily: 'Lexend',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                            children:
                                                                List.generate(
                                                              () {
                                                                try {
                                                                  return int
                                                                      .parse(item[
                                                                          'rating']); // Convert the rating to an int
                                                                } catch (e) {
                                                                  return 0; // Default to 0 stars if there's an error
                                                                }
                                                              }(),
                                                              (index) =>
                                                                  Padding(
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
                                                            style:
                                                                const TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      24,
                                                                      24,
                                                                      24,
                                                                      1),
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Lexend',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: List.generate(
                                                          () {
                                                            try {
                                                              return int.parse(
                                                                  item[
                                                                      'price']);
                                                            } catch (e) {
                                                              return 0;
                                                            }
                                                          }(),
                                                          (index) => Padding(
                                                            padding:
                                                                const EdgeInsets
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
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterDropdown extends StatelessWidget {
  final String title;
  final ValueChanged<String> onChanged;

  const FilterDropdown(
      {required this.title, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 36,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(140, 140, 140, 0.20),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.5))),
      child: DropdownButton<String>(
        value: title,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 10,
        underline: Container(
          height: 0,
        ),
        onChanged: (String? newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
        items: <String>[title, 'Option 1', 'Option 2', 'Option 3']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.5),
                fontSize: 14,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
