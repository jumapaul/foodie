import 'package:flutter/material.dart';
import 'package:foodie/app/modules/planner/views/widgets/DaysWidget.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/planner_controller.dart';

class PlannerView extends GetView<PlannerController> {
  const PlannerView({super.key});

  @override
  Widget build(BuildContext context) {

    final PlannerController plannerController = Get.put(PlannerController());


    return Scaffold(
      appBar: AppBar(
        title: const Text('Planner'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              child: Obx((){
                final isSelectedDay = plannerController.selectedDay.value;
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: plannerController.daysOfTheWeek.length,
                    itemBuilder: (BuildContext context, int index) {
                      var dayOfTheWeek = plannerController.daysOfTheWeek[index];

                      return DaysOfTheWeek(
                        dayOfTheWeek: dayOfTheWeek,
                        isSelected: dayOfTheWeek == isSelectedDay,
                        onPressed: () {
                          plannerController.selectDay(dayOfTheWeek);
                        },
                      );
                    });
              }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.toNamed(Routes.NEW_PLAN);
        },
        mini: true,
        backgroundColor: Colors.orangeAccent,
        child: const Icon(
          Icons.add_circle_outline,
          color: Colors.white,
        ),
      ),
    );
  }
}
