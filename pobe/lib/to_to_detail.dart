import 'package:flutter/material.dart';

class ToGoDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const ToGoDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name'] ?? 'Item Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                item['image'] ?? '',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            // Menampilkan nama item
            Text(
              item['name'] ?? 'No Name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Menampilkan deskripsi item
            Text(
              item['desc'] ?? 'No Description',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            // Menampilkan rating dan review item
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                SizedBox(width: 4),
                Text(
                  '${item['rating'] ?? '0.0'} (${item['review'] ?? '0'} Reviews)',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Menampilkan harga item
            Text(
              'Price: Rp${item['price'] ?? '0'}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
