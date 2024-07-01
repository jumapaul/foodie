import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PlannerController extends GetxController {

  var selectedDay = "".obs;

  List<String> daysOfTheWeek = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  void selectDay(String day){
    selectedDay.value = day;
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
