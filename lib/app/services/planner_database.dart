import 'package:foodie/app/data/models/categories/searchResultsResponse.dart';
import 'package:foodie/app/services/create_database.dart';
import 'package:foodie/app/services/meals_field.dart';
import 'package:sqflite/sqflite.dart';

class PlannerDatabase {
  static Future<int> addMealsToPlannerDb(
      SearchMeals? meals, String? dayOfTheWeek) async {
    final db = await CreateDatabase.getDB();

    return await db.insert(
      PlannerFields.plannerTableName,
      meals!.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
