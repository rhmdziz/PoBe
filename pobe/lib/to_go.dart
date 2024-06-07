import 'package:flutter/material.dart';
import './to_go_service.dart'; // import the ApiService

class ToGo extends StatefulWidget {
  final String category;

  const ToGo({Key? key, required this.category}) : super(key: key);

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
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: FutureBuilder<List<dynamic>>(
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
                return ListTile(
                  title: Text(item['name'] ??
                      'No Name'), // Adjust the key based on your data structure
                  subtitle: Text(item['desc'] ??
                      'No Description'), // Adjust the key based on your data structure
                );
              },
            );
          }
        },
      ),
    );
  }
}
