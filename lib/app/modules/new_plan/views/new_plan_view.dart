import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/modules/new_plan/views/widgets/AddMealWidget.dart';
import 'package:foodie/app/modules/planner/controllers/planner_controller.dart';
import 'package:foodie/app/modules/planner/views/widgets/DialogWidget.dart';
import 'package:get/get.dart';
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
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select Day of the week",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            Obx(
              () {
                var initialValue = newPlanController.selectedDay.value;

                daysOfTheWeek.map((String day) {
                  return DropdownMenuEntry<String>(
                    value: day,
                    label: day,
                  );
                }).toList();
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300),
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      value: initialValue,
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
                );
              },
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
            GestureDetector(
              onTap: () {
                Get.dialog(
                  Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    insetPadding: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 800,
                          maxWidth: Get.width
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: DialogWidget(
                          dayOfTheWeek: newPlanController.selectedDay.value,
                        ),
                      )
                    ),
                  ),
                );
              },
              child: const AddMealWidget(),
            )
          ],
        ),
      ),
    );
  }
}
