import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/app/modules/home/views/widgets/meal_widget.dart';
import 'package:foodie/app/modules/home/views/widgets/search_bar_widget.dart';
import 'package:foodie/app/modules/search/controllers/search_controller.dart';
import 'package:get/get.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchViewController searchViewController =
        Get.put(SearchViewController());
    final TextEditingController textEditingController =
        Get.put(TextEditingController());

    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SearchBarWidget(
              controller: textEditingController,
              hintText: "Search",
              enable: true,
              onSearch: (value) {
                searchViewController.getSearchResults(value);
                },
            ),

            const SizedBox(height: 10,),
            Expanded(
              flex: 8,
              child: LayoutBuilder(builder: (context, constraints) {
                return Obx(() {
                  if (searchViewController.searchResults.value?.meals!.isNotEmpty == true) {
                    return GridView.builder(
                      itemCount: searchViewController.searchResults.value?.meals?.length??0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        var searchResults = searchViewController
                            .searchResults.value?.meals?[index];

                        return MealWidget(
                            mealName: searchResults?.strMeal ?? "",
                            mealImage: searchResults?.strMealThumb ?? "");
                      },
                    );
                  }else{
                    return const Center(
                      child: Text("No results found"),
                    );
                  }
                });
              }),
            )
          ],
        ),
      )),
    );
  }
}
