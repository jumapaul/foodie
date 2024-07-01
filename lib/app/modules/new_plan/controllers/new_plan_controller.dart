import 'package:foodie/app/data/models/categories/searchResultsResponse.dart';
import 'package:foodie/app/services/planner_database.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewPlanController extends GetxController {

  var selectedDay = "".obs;
  var dropDownBottomState = false.obs;

  void plannerSelectedDay(String day){
    selectedDay.value = day;
  }

  addPlannerToDb(SearchMeals? meals, String? dayOfTheWeek) async{
    await PlannerDatabase.addMealsToPlannerDb(meals, dayOfTheWeek);
  }

  void toggleDropDownButtonState(bool isOpen){
    dropDownBottomState.value = isOpen;
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
