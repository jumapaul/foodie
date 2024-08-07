import 'package:foodie/app/data/models/categories/searchResultsResponse.dart';
import 'package:foodie/app/services/planner_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewPlanController extends GetxController {
  var selectedDay = "".obs;
  var dialogState = true.obs;


  RxList<SearchMeals> addMeals = <SearchMeals>[].obs;

  void removeMealFromList(SearchMeals meal){
    addMeals.remove(meal);
    update();
  }

  void plannerSelectedDay(String day) {
    selectedDay.value = day;
  }

  addPlannerMealsToDb(List<SearchMeals>? addedMeals, String? dayOfTheWeek) async {
    await PlannerDatabase.addMealListToPlannerDb(addedMeals, dayOfTheWeek);
  }

  @override
  void onInit() {
    super.onInit();
    String currentDay = DateFormat("EEEE").format(DateTime.now());
    selectedDay.value = currentDay;
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
