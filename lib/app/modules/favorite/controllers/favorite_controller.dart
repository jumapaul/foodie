import 'package:foodie/app/data/models/categories/categoryListing.dart';
import 'package:foodie/app/data/models/categories/searchResultsResponse.dart';
import 'package:foodie/app/services/favorite_database.dart';
import 'package:foodie/app/utils/resource/DataState.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  var isLoading = false.obs;
  var isFavorite = false.obs;

  var favoriteMeals = Rx<DataState<CategoryListing>>(const Initial());

  Future<void> getAllFavorites() async {
    isLoading.value = true;
    var favoriteMeal = await FavoriteDatabase.getAllMealsFromDb();
    if (favoriteMeal != null) {
      favoriteMeals.value = Success(CategoryListing(meals: favoriteMeal.meals));

    } else {
      favoriteMeals.value = const Error("There is no favorite yet");
    }


    isLoading.value = false;
  }

  addSearchFavoriteMealToDb(SearchMeals? meal) async {
    await FavoriteDatabase.addSearchFavoriteMealsToDb(meal);
  }

  addFavoriteMealToDb(Meals? meal) async {
    await FavoriteDatabase.addMealsToDb(meal);
    getAllFavorites();
  }

  removeFavorite(String mealId) async{
    await FavoriteDatabase.removeFavoriteFromDb(mealId);
    getAllFavorites();
  }

  Future<bool?> isFavorites(String? mealId) async{
    var favorites = favoriteMeals.value.data?.meals;

    isFavorite.value = favorites!.any((meal) => meal.idMeal == mealId);

    return isFavorite.value;
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
