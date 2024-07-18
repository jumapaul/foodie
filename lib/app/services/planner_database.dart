import 'package:foodie/app/data/models/categories/searchResultsResponse.dart';
import 'package:foodie/app/services/create_database.dart';
import 'package:foodie/app/services/meals_field.dart';

class PlannerDatabase {
  static Future addMealListToPlannerDb(
      List<SearchMeals>? addedMeals, String? dayOfTheWeek) async {
    try {
      final db = await CreateDatabase.getDB();

      for (var meal in addedMeals!) {
        final mealData = meal.toJson();
        mealData['strDayOfTheWeek'] = dayOfTheWeek;
        await db.insert(PlannerFields.plannerTableName, mealData);
      }
    } catch (error) {
      return error;
    }
  }

  static Future<SearchResultsResponse?> getMealsFromDbForGivenDay(
      String? selectedDayOfWeek) async {
    final db = await CreateDatabase.getDB();

    if (selectedDayOfWeek == null) {
      return null;
    }

    final List<Map<String, dynamic>> maps = await db.query(
      PlannerFields.plannerTableName,
      where: '${PlannerFields.dayPlan} = ?',
      whereArgs: [selectedDayOfWeek],
    );

    if (maps.isEmpty) {
      return null;
    }

    List<SearchMeals> getMealsPerDay = List.generate(
        maps.length, (index) => SearchMeals.fromJson(maps[index]));

    return SearchResultsResponse(meals: getMealsPerDay);
  }

  static Future<int> removeFromPlannerDb(int? id) async {
    final db = await CreateDatabase.getDB();

    return await db.delete(PlannerFields.plannerTableName,
        where: '${PlannerFields.id} = ?', whereArgs: [id]);
  }
}
