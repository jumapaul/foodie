import 'package:flutter/material.dart';
import 'package:foodie/app/modules/favorite/views/widget/favorite_meals_widget.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import '../controllers/favorite_controller.dart';

final Logger _logger = Logger("FavoriteView");

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getAllFavorites();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Meals'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          final favoriteMeals = controller.favoriteMeals.value;
          var favorites = favoriteMeals?.data?.meals ?? [];

          return controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  separatorBuilder: (context, index){
                    return const SizedBox(height: 10,);
                  },
                    scrollDirection: Axis.vertical,
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      var favorite = favorites[index];

                      return FavoriteMealWidget(
                        mealName: favorite.strMeal ?? "",
                        mealImage: favorite.strMealThumb ?? "",
                        mealId: favorite.idMeal ?? "",
                      );
                    },
                  ),
              );
        },
      ),
    );
  }
}
