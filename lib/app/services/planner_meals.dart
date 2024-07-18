class PlannerMeals {
  final int? id;
  final String? idMeal;
  final String? name;
  final String? dayPlan;
  final String? mealThumb;

  PlannerMeals({this.id, this.idMeal, this.name, this.mealThumb, this.dayPlan});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'idMeal': idMeal,
      'name': name,
      'mealThumb': mealThumb,
      'dayPlan': dayPlan
    };
  }

  static PlannerMeals fromMap(Map<String, dynamic> map){
    return PlannerMeals(
      id: map['id'],
      idMeal: map['idMeal'],
      name: map['name'],
      mealThumb: map['mealThumb'],
      dayPlan: map['dayPlan']
    );
  }
}