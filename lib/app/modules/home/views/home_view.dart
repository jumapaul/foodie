import 'package:flutter/material.dart';
import 'package:foodie/app/modules/home/views/widgets/categories_widget.dart';
import 'package:foodie/app/modules/home/views/widgets/meal_widget.dart';
import 'package:foodie/app/modules/home/views/widgets/search_bar_widget.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else {
            return SafeArea(
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(children: [
                    const SearchBarWidget(
                      hintText: "Search",
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Explore Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            controller.categories.value?.categories?.length ??
                                0,
                        itemBuilder: (BuildContext context, int index) {
                          var category =
                              controller.categories.value?.categories?[index];

                          return CategoriesWidget(
                            categoryName: category?.strCategory ?? "",
                            imageUrl: category?.strCategoryThumb ?? "",
                            onPressed: () => controller.getCategoryListing(
                                category?.strCategory ?? "Beef"),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    Expanded(
                      flex: 8,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Obx(
                            () => GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10),
                              itemBuilder: (BuildContext context, int index) {
                                var meal = controller
                                    .categoryListing.value?.meals?[index];
                                return MealWidget(
                                    mealName: meal?.strMeal ?? "",
                                    mealImage: meal?.strMealThumb ?? "");
                              },
                              itemCount: controller
                                      .categoryListing.value?.meals?.length ??
                                  0,
                            ),
                          );
                        },
                      ),
                    )
                  ]),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
