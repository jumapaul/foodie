import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/app/modules/new_plan/views/widgets/AddMealWidget.dart';
import 'package:foodie/app/modules/new_plan/views/widgets/planner_meals_widget.dart';
import 'package:foodie/app/modules/planner/controllers/planner_controller.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import '../../../routes/app_pages.dart';
import '../../planner/views/widgets/DialogWidget.dart';
import '../controllers/new_plan_controller.dart';

class NewPlanView extends GetView<NewPlanController> {
  const NewPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    final PlannerController plannerController = Get.put(PlannerController());
    final NewPlanController newPlanController = Get.put(NewPlanController());
    List<String> daysOfTheWeek = plannerController.daysOfTheWeek;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Plan'),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
        child: Obx(
          () {
            var addedMeals = newPlanController.addMeals.value;
            var day = newPlanController.selectedDay.value;
            daysOfTheWeek.map((String day) {
              return DropdownMenuEntry<String>(
                value: day,
                label: day,
              );
            }).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select Day of the week",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300),
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: day,
                      items: daysOfTheWeek.map((String dayOfTheWeek) {
                        return DropdownMenuItem<String>(
                            value: dayOfTheWeek, child: Text(dayOfTheWeek));
                      }).toList(),
                      onChanged: (dynamic newValue) {
                        newPlanController.plannerSelectedDay(newValue);
                      },
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                          openMenuIcon: Icon(Icons.arrow_drop_up_outlined),
                          icon: Icon(Icons.arrow_drop_down)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Click to add meal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 10,
                ),
                // var addedMeals = newPlanController.addMeals.value;
                Expanded(
                    flex: 6,
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        if (addedMeals.isEmpty && index == 0) {
                          return AddMealWidget(onPressed: () {
                            Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                insetPadding: const EdgeInsets.all(5.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight: 800,
                                      maxWidth: Get.width,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: DialogWidget(
                                      dayOfTheWeek:
                                          newPlanController.selectedDay.value,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        }

                        if (index == addedMeals.length) {
                          return AddMealWidget(onPressed: () {
                            Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                insetPadding: const EdgeInsets.all(5.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight: 800,
                                      maxWidth: Get.width,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    child: DialogWidget(
                                      dayOfTheWeek:
                                          newPlanController.selectedDay.value,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        }

                        var singleMeal = addedMeals[index];

                        return PlannerMealsWidget(
                          mealName: singleMeal.strMeal!,
                          mealImage: singleMeal.strMealThumb!,
                          mealId: singleMeal.idMeal!,
                          onPressed: () {
                            newPlanController.removeMealFromList(singleMeal);
                          },
                        );
                      },
                      staggeredTileBuilder: (int index) {
                        return const StaggeredTile.count(1, 1);
                      },
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemCount: addedMeals.isEmpty ? 1 : addedMeals.length + 1,
                    )),
                Center(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              width: 0, color: Colors.orangeAccent),
                          backgroundColor: Colors.orangeAccent,
                          textStyle: const TextStyle(color: Colors.white)),
                      onPressed: () {
                        if (addedMeals.isNotEmpty) {
                          newPlanController.addPlannerMealsToDb(
                              addedMeals, day).then((_){
                                addedMeals.clear();
                          });

                          Get.toNamed(Routes.PLANNER);
                          Fluttertoast.showToast(
                              msg: "Plan created for $day",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade500,
                              textColor: Colors.white);
                        } else {
                          Fluttertoast.showToast(
                              msg: "No meal selected",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade500,
                              textColor: Colors.white);
                        }
                      },
                      child: Text("Create plan for $day")),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
