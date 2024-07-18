import 'package:foodie/app/data/models/categories/searchResultsResponse.dart';
import 'package:foodie/app/services/planner_database.dart';
import 'package:foodie/app/utils/resource/DataState.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PlannerController extends GetxController {
  var selectedDay = "".obs;
  var isLoading = false.obs;

  var mealsOfTheDay = Rx<DataState<SearchResultsResponse>>(const Initial());

  List<String> daysOfTheWeek = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  void selectDay(String day) {
    selectedDay.value = day;
  }

  Future<void> getMealsOfTheDay(String? selectedDayOfTheWeek) async {
    isLoading.value = true;

    var mealOfTheDay =
        await PlannerDatabase.getMealsFromDbForGivenDay(selectedDayOfTheWeek);

    if (mealOfTheDay != null) {
      mealsOfTheDay.value =
          Success(SearchResultsResponse(meals: mealOfTheDay.meals));
    } else {
      mealsOfTheDay.value = const Error("There is no meal yet");
    }

    isLoading.value = false;
  }

  removePlanner(int? id) async{
    await PlannerDatabase.removeFromPlannerDb(id);
    getMealsOfTheDay(selectedDay.value);
  }

  @override
  void onInit() {
    String currentDay = DateFormat("EEEE").format(DateTime.now());
    selectedDay.value = currentDay;
    super.onInit();
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
