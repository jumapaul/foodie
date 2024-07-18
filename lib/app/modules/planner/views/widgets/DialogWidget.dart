import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie/app/modules/home/views/widgets/search_bar_widget.dart';
import 'package:foodie/app/modules/new_plan/controllers/new_plan_controller.dart';
import 'package:foodie/app/modules/planner/controllers/planner_controller.dart';
import 'package:foodie/app/modules/search/controllers/search_controller.dart';
import 'package:get/get.dart';

class DialogWidget extends StatefulWidget {

  String? dayOfTheWeek;
  DialogWidget({super.key, this.dayOfTheWeek});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    final SearchViewController searchController =
        Get.put(SearchViewController());

    final TextEditingController textEditingController =
        Get.put(TextEditingController());

    final NewPlanController newPlanController = Get.put(NewPlanController());

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SearchBarWidget(
            controller: textEditingController,
            hintText: 'Search',
            enable: true,
            onSearch: (search) {
              searchController.getSearchResults(search);
            },
          ),
        ),
        Obx(() {
          var searchListing = searchController.searchResults.value?.meals!;
          if (searchListing?.isNotEmpty == true) {
            return Flexible(
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: searchListing!.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    var searchItem = searchListing[index];

                    return DialogItem(
                      imageUrl: searchItem.strMealThumb ?? "",
                      mealName: searchItem.strMeal ?? "",
                      onPressed: (){
                        var existingMeals = newPlanController.addMeals.value;
                        if(!existingMeals.any((meal) => meal.idMeal == searchItem.idMeal)){
                          newPlanController.addMeals.add(searchItem);
                        }
                        newPlanController.dialogState.value = false;

                        if(newPlanController.dialogState.isFalse){
                          Get.back();
                        }
                      },
                    );
                  }),
            );
          } else {
            return const Center(child: Text("No results found"));
          }
        })
      ],
    );
  }
}

class DialogItem extends StatefulWidget {
  String? imageUrl;
  String? mealName;
  final VoidCallback onPressed;

  DialogItem({super.key, this.imageUrl, this.mealName, required this.onPressed});

  @override
  State<DialogItem> createState() => _DialogItemState();
}

class _DialogItemState extends State<DialogItem> {
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          alignment: Alignment.center,
          height: 80,
          width: 80,
          child: Image.network(
            widget.imageUrl ?? "",
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            widget.mealName!,
            maxLines: 2,
            style: TextStyle(color: Colors.grey.shade600),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // const Spacer(),

        GestureDetector(
          onTap: widget.onPressed,
          child: const Icon(
            Icons.add_circle_outline,
            color: Colors.orangeAccent,
          ),
        )
      ],
    );
  }
}
