import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'meals_field.dart';

class CreateDatabase {
  static const int _version = 4;
  static const String _dbName = "categories";

  static Future<Database> getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        await db.execute("""
      CREATE TABLE IF NOT EXISTS ${FavoriteMealsFields.favoriteTableName}(
      ${FavoriteMealsFields.mealId} ${FavoriteMealsFields.idType},
      ${FavoriteMealsFields.mealName} TEXT,
      ${FavoriteMealsFields.mealThumb} TEXT
      )
      """);

        await db.execute("""
      CREATE TABLE IF NOT EXISTS ${PlannerFields.plannerTableName}(
      ${PlannerFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${PlannerFields.mealId} TEXT,
      ${PlannerFields.mealName} TEXT,
      ${PlannerFields.mealThumb} TEXT,
      ${PlannerFields.dayPlan} TEXT
      )
      """);
      },
      version: _version,
    );
  }
}
