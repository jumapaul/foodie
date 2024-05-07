import 'package:flutter/material.dart';
import 'package:foodie/app/modules/detail/controllers/detail_controller.dart';
import 'package:get/get.dart';

class IngredientsListingWidget extends StatelessWidget {
  const IngredientsListingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailController detailController = Get.put(DetailController());
    final mealIngredients = detailController.ingredientsWithMeasures;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          var mealIngredient = mealIngredients[index];

          return Ingredient(
            ingredientName: mealIngredient,
            icon: Icons.check_circle_outline,
          );
        },
        itemCount: detailController.ingredientsWithMeasures.length,
      ),
    );
  }
}

class Ingredient extends StatelessWidget {
  final String ingredientName;
  final IconData icon;

  const Ingredient(
      {super.key, required this.ingredientName, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: Colors.orange,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          ingredientName,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}
