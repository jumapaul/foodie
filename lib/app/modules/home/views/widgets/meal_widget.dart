import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/data/models/categories/categoryListing.dart';
import 'package:foodie/app/modules/detail/controllers/detail_controller.dart';
import 'package:foodie/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:get/get.dart';

class MealWidget extends StatefulWidget {
  final String mealName;
  final String mealImage;
  final String mealId;
  final bool? isFavorite;


  const MealWidget(
      {super.key,
      required this.mealName,
      required this.mealImage,
      required this.mealId,
      required this.isFavorite});

  @override
  State<MealWidget> createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  late bool isFavorite;

  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  void initState(){
    super.initState();
    isFavorite = widget.isFavorite!;
    // checkFavoriteStatus();
  }

  // Future<void> checkFavoriteStatus() async{
  //   isFavorite = (await favoriteController.isFavorites(widget.mealId))!;
  //
  //   setState(() {});
  // }

  void toggleFavorite(){
    setState(() {
      isFavorite = !isFavorite;
    });
    final FavoriteController favoriteController = Get.find<FavoriteController>();

    if(isFavorite){
      favoriteController.addFavoriteMealToDb(Meals(idMeal: widget.mealId, strMeal: widget.mealName, strMealThumb: widget.mealImage));
    }else{
      favoriteController.removeFavorite(widget.mealId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final DetailController detailController = Get.put(DetailController());
    return GestureDetector(
      onTap: () {
        detailController.getMealDetails(widget.mealId);
        Get.toNamed(Routes.DETAIL);
      },
      child: Stack(
        children: [
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  widget.mealImage,
                ),
                fit: BoxFit.fill,
              ),
              color: Colors.black,
            ),
          ),
          Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: toggleFavorite,
                child: Icon(
                  isFavorite ? Icons.favorite: Icons.favorite_border,
                  color: Colors.orangeAccent,
                ),
              )),
          Positioned(
            bottom: 10,
            left: 10,
            child: SizedBox(
              width: 150,
              child: Text(
                widget.mealName,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
