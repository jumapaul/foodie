import 'package:flutter/material.dart';
import 'package:foodie/app/modules/favorite/views/widget/favorite_meals_widget.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Meals'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          final favoriteMeals = controller.favoriteMeals.value;
          var favorites = favoriteMeals.data?.meals ?? [];

          if(controller.isLoading.value){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(favoriteMeals.error!.isNotEmpty) {
            return Center(
              child: Text(favoriteMeals.error?? ""),
            );
          }else{
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: ListView.separated(
               separatorBuilder: (context, index) {
                 return const SizedBox(
                   height: 10,
                 );
               },
               scrollDirection: Axis.vertical,
               itemCount: favorites.length,
               itemBuilder: (context, index) {
                 var favorite = favorites[index];

                 return Dismissible(
                   key: Key(index.toString()),
                   onDismissed: (direction) {
                     if (direction == DismissDirection.startToEnd) {
                       controller
                           .removeFavorite(favorite.idMeal.toString());
                     }
                   },
                   background: Container(
                     color: Colors.green.shade500,
                     alignment: Alignment.centerLeft,
                     child: const Icon(
                       Icons.delete,
                       color: Colors.white,
                     ),
                   ),
                   child: FavoriteMealWidget(
                     mealName: favorite.strMeal ?? "",
                     mealImage: favorite.strMealThumb ?? "",
                     mealId: favorite.idMeal ?? "",
                   ),
                 );
               },
             ),
           );
          }
        },
      ),
    );
  }
}
