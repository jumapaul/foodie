import 'package:foodie/app/data/models/categories/categoryListing.dart';
import 'package:foodie/app/data/models/categories/searchResultsResponse.dart';
import 'package:foodie/app/services/create_database.dart';
import 'package:foodie/app/services/meals_field.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDatabase {

  static Future<int> addMealsToDb(Meals? meals) async {
    final db = await CreateDatabase.getDB();

    return await db.insert(FavoriteMealsFields.favoriteTableName, meals!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> addSearchFavoriteMealsToDb(SearchMeals? meals) async {
    final db = await CreateDatabase.getDB();
    return await db.insert(FavoriteMealsFields.favoriteTableName, meals!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<CategoryListing?> getAllMealsFromDb() async {
    final db = await CreateDatabase.getDB();
    final List<Map<String, dynamic>> maps =
        await db.query(FavoriteMealsFields.favoriteTableName);

    if (maps.isEmpty) {
      return null;
    }

    List<Meals> mealList =
        List.generate(maps.length, (index) => Meals.fromJson(maps[index]));

    return CategoryListing(meals: mealList);
  }

  static Future<int> removeFavoriteFromDb(String? mealId) async {
    final db = await CreateDatabase.getDB();
    return await db.delete(FavoriteMealsFields.favoriteTableName,
        where: '${FavoriteMealsFields.mealId} = ?', whereArgs: [mealId]);
  }
}
