class FavoriteMealsFields {
  static const String favoriteTableName = 'favorites';
  static const String mealId = "idMeal";
  static const String mealName = "strMeal";
  static const String mealThumb = "strMealThumb";
  static const idType = 'TEXT PRIMARY KEY';
}

class PlannerFields{
  static const String plannerTableName = 'planner';
  static const String id = "id";
  static const String mealId = "idMeal";
  static const String mealName = "strMeal";
  static const String mealThumb = "strMealThumb";
  static const String dayPlan = "strDayOfTheWeek";
}
