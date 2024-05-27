import 'package:flutter/material.dart';
import 'package:foodie/app/data/models/categories/categoryListing.dart';
import 'package:foodie/app/data/models/categories/searchResultsResponse.dart';
import 'package:foodie/app/services/favorite_database.dart';
import 'package:foodie/app/utils/resource/DataState.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger("FavoriteController");

class FavoriteController extends GetxController {
  var isLoading = false.obs;
  var isFavorite = false.obs;
  var favoriteMeals = Rxn<DataState<CategoryListing>>(const Initial());

  addSearchFavoriteMealToDb(SearchMeals? meal) async {
    await FavoriteDatabase.addSearchFavoriteMealsToDb(meal);
  }

  addFavoriteMealToDb(Meals? meal) async {
    await FavoriteDatabase.addMealsToDb(meal);
  }

  getAllFavorites() async {
    print("Starting");

    isLoading.value = true;
    var favoriteMeal = await FavoriteDatabase.getAllMealsFromDb();
    if (favoriteMeal != null) {
      favoriteMeals.value = Success(CategoryListing(meals: favoriteMeal.meals));
      print("Results");
      print("favorite meals value =====>${favoriteMeals.value?.data?.meals?.length}");

    } else {
      favoriteMeals.value = const Error("There is no favorite yet");
      print("No results");

    }

    print("Stop");

    isLoading.value = false;
  }

  @override
  void onInit() {
    getAllFavorites();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
