import 'package:flutter/material.dart';
import '../to_go.dart';

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
            const SizedBox(
              width: 20,
            ),
            // SHOPPING
            _buildCategoryContainer(
              context,
              'Shopping',
              'assets/category/shopping.png',
            ),
            const SizedBox(
              width: 20,
            ),
            // MALL
            _buildCategoryContainer(
              context,
              'Mall',
              'assets/category/mall.png',
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // HOSPITAL
            _buildCategoryContainer(
              context,
              'Hospital',
              'assets/category/hospital.png',
            ),
            const SizedBox(
              width: 20,
            ),
            // SPORT
            _buildCategoryContainer(
              context,
              'Sport',
              'assets/category/sport.png',
            ),
            const SizedBox(
              width: 20,
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
    return Expanded(
      child: GestureDetector(
        onTap: () => _navigateToCategory(context, category),
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(140, 201, 246, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
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
                  fontSize: 16,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
