import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'meals_field.dart';

class CreateDatabase {
  static const int _version = 3;
  static const String _dbName = "categories";

  static Future<Database> getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      print("-------------------> creating favorites");
      await db.execute("""
      CREATE TABLE ${FavoriteMealsFields.favoriteTableName}(
      ${FavoriteMealsFields.mealId} ${FavoriteMealsFields.idType},
      ${FavoriteMealsFields.mealName} TEXT,
      ${FavoriteMealsFields.mealThumb} TEXT
      )
      """);

      print("-------------------> creating planner");

      await db.execute("""
      CREATE TABLE ${PlannerFields.plannerTableName}(
      ${FavoriteMealsFields.mealId} ${FavoriteMealsFields.idType},
      ${FavoriteMealsFields.mealName} TEXT,
      ${FavoriteMealsFields.mealThumb} TEXT
      )
      """);
    }, version: _version);
  }
}
