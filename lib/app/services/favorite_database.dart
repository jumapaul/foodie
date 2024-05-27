import 'package:foodie/app/data/models/categories/categoriesResponse.dart';
import 'package:foodie/app/data/models/categories/categoryListing.dart';
import 'package:foodie/app/data/models/categories/searchResultsResponse.dart';
import 'package:foodie/app/services/meals_field.dart';
import 'package:logging/logging.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final Logger _logger = Logger('FavoriteDatabase');
class FavoriteDatabase {
  static const int _version = 3;
  static const String _dbName = "categories";

  static Future<Database> _getDB() async {

    _logger.info("========>Creating database");
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute("""
      CREATE TABLE ${MealFields.tableName}(
      ${MealFields.mealId} ${MealFields.idType},
      ${MealFields.mealName} TEXT,
      ${MealFields.mealThumb} TEXT
      )
      """);
    }, version: _version);
  }

  static Future<int> addMealsToDb(Meals? meals) async {
    final db = await _getDB();
    return await db.insert(MealFields.tableName, meals!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> addSearchFavoriteMealsToDb(SearchMeals? meals) async {
    final db = await _getDB();
    return await db.insert(MealFields.tableName, meals!.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<CategoryListing?> getAllMealsFromDb() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps =
        await db.query(MealFields.tableName);

    if (maps.isEmpty) {
      return null;
    }

    List<Meals> mealList = List.generate(
        maps.length, (index) => Meals.fromJson(maps[index]));

    return CategoryListing(meals: mealList);
  }

  static Future<int> removeFavoriteFromDb(String? mealId) async{
    final db = await _getDB();
    return await db.delete(MealFields.tableName,
    where: 'mealId = ${MealFields.mealId} = ?',
      whereArgs: [mealId]
    );
  }
}
