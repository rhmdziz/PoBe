import 'package:flutter/material.dart';
// import './to_go_detail_map.dart';
import 'package:url_launcher/url_launcher.dart';

class ToGoDetailPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const ToGoDetailPage({super.key, required this.item});

  @override
  State<ToGoDetailPage> createState() => _ToGoDetailPageState();
}

class _ToGoDetailPageState extends State<ToGoDetailPage> {
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
              TextButton(
                onPressed: () async {
                  // Dapatkan latitude dan longitude dari widget.item
                  final double latitude = widget.item['latitude'];
                  final double longitude = widget.item['longitude'];

                  // Buat URL Google Maps untuk navigasi
                  final url =
                      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';

                  // Periksa apakah perangkat bisa membuka URL tersebut
                  if (await canLaunchUrl(Uri.parse(url))) {
                    await launchUrl(Uri.parse(url));
                  } else {
                    throw 'Could not launch Google Maps.';
                  }
                },

                // onPressed: () {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => DirectionsPage(
                //         latitude: widget.item['latitude'],
                //         longitude: widget.item['longitude'],
                //       ),
                //     ),
                //   );
                // },

                style: ButtonStyle(
                  backgroundColor: const MaterialStatePropertyAll(
                      Color.fromRGBO(31, 54, 113, 1)),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  minimumSize:
                      const MaterialStatePropertyAll(Size(double.infinity, 50)),
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
            ],
          ),
        ),
      ),
    );
  }
}
