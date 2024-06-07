import 'package:flutter/material.dart';
import 'to_go.dart'; // import the ToGo page

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  void _navigateToCategory(BuildContext context, String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToGo(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // FOOD
            _buildCategoryContainer(
              context,
              'Food',
              'assets/category/food.png',
            ),
            // SHOPPING
            _buildCategoryContainer(
              context,
              'Shopping',
              'assets/category/shopping.png',
            ),
            // MALL
            _buildCategoryContainer(
              context,
              'Mall',
              'assets/category/mall.png',
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // HOSPITAL
            _buildCategoryContainer(
              context,
              'Hospital',
              'assets/category/hospital.png',
            ),
            // SPORT
            _buildCategoryContainer(
              context,
              'Sport',
              'assets/category/sport.png',
            ),
            // ENTERTAIN
            _buildCategoryContainer(
              context,
              'Entertain',
              'assets/category/entertain.png',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryContainer(
      BuildContext context, String category, String imagePath) {
    return GestureDetector(
      onTap: () => _navigateToCategory(context, category),
      child: Container(
        height: 120,
        width: 100,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(140, 201, 246, 1),
          borderRadius: BorderRadius.circular(7.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(209, 235, 254, 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: Image.asset(imagePath),
            ),
            Text(
              category,
              style: const TextStyle(
                color: Color.fromRGBO(31, 54, 113, 1),
                fontSize: 15,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
