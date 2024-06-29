// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pobe/login.dart';

class ToGoDetailPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const ToGoDetailPage({super.key, required this.item});

  @override
  State<ToGoDetailPage> createState() => _ToGoDetailPageState();
}

class FoodReview {
  final int id;
  final String rating;
  final String name;
  final String review;
  final int foodId;

  FoodReview({
    required this.id,
    required this.rating,
    required this.name,
    required this.review,
    required this.foodId,
  });

  factory FoodReview.fromJson(Map<String, dynamic> json) {
    return FoodReview(
      id: json['id'],
      rating: json['rating'],
      name: json['name'],
      review: json['review'],
      foodId: json['foodId'],
    );
  }
}

class _ToGoDetailPageState extends State<ToGoDetailPage> {
  bool _isChecked = false;
  bool _isLoading = false;
  int _rating = 0;
  TextEditingController reviewController = TextEditingController();
  String userName = '';
  List<FoodReview> foodReviews = [];

  @override
  void initState() {
    super.initState();
    _loadUserName();
    fetchFoodReviews();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'user';
    });
  }

  Future<void> fetchFoodReviews() async {
    TokenStorage tokenStorage = TokenStorage();
    String? accessToken = await tokenStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    const url = 'http://192.168.50.64:8000/foodreviews/';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<FoodReview> fetchedReviews = [];
      data.forEach((reviewData) {
        if (reviewData['foodId'] == widget.item['id']) {
          fetchedReviews.add(FoodReview.fromJson(reviewData));
        }
      });
      setState(() {
        foodReviews = fetchedReviews;
      });
    } else {
      throw Exception('Failed to load food reviews');
    }
  }

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
                    widget.item['name'],
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
                    widget.item['image'] ?? '',
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
                        '${widget.item['rating'] ?? '0.0'}',
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
                            widget.item['location'],
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
                            '${widget.item['operational_day']} (${widget.item['operational_hour']})',
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
                            widget.item['phone'],
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
                            '${widget.item['min_price']}${widget.item['max_price']} / person',
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
                widget.item['desc'] ?? 'No Description',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        _showAddReviewModal(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: const MaterialStatePropertyAll(
                            Color.fromRGBO(209, 235, 254, 1)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        minimumSize: const MaterialStatePropertyAll(
                            Size(double.infinity, 50)),
                      ),
                      child: const Text(
                        'Add a review',
                        style: TextStyle(
                          color: Color.fromRGBO(31, 54, 113, 1),
                          fontFamily: 'Lexend',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        final double latitude = widget.item['latitude'];
                        final double longitude = widget.item['longitude'];

                        final url =
                            'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';

                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'Could not launch Google Maps.';
                        }
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
                        'Directions',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lexend',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black26,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: foodReviews.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
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
                                    foodReviews[index].name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lexend',
                                      color: Color.fromRGBO(31, 54, 113, 1),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: List.generate(
                                      int.parse(foodReviews[index].rating),
                                      (index) => Row(
                                        children: [
                                          Image.asset('assets/togo/star.png'),
                                          const SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '"${foodReviews[index].review}"',
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
            ],
          ),
        ),
      ),
    );
  }

  void _showAddReviewModal(BuildContext context) {
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
              const Row(
                children: [
                  Text(
                    'Rating',
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
                height: 75,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(77, 133, 241, 0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setModalState(() {
                          _rating = rating.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Review',
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
                  controller: reviewController,
                  decoration: const InputDecoration(
                    hintText: 'Write a review',
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
                          "rating": _rating.toString(),
                          "name": userName,
                          "review": reviewController.text,
                          // "foodId": foodIdUrl,
                          "foodId": widget.item['id'],
                        };

                        print("Request Data: $requestData");

                        final response = await http.post(
                          Uri.parse('http://192.168.50.64:8000/foodreviews/'),
                          headers: {
                            'Content-Type': 'application/json',
                            'Authorization': 'Bearer $accessToken',
                          },
                          body: json.encode(requestData),
                        );
                        print(response.statusCode);
                        print("Response Status: ${response.statusCode}");
                        print("Response Body: ${response.body}");

                        setState(() {
                          _isLoading = false;
                        });

                        if (response.statusCode == 201) {
                          Navigator.pop(context); // Close the modal
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Review added successfully!'),
                              backgroundColor: Color.fromRGBO(31, 54, 113, 1),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to add review.'),
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
