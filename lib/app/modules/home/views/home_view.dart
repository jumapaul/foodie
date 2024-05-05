import 'package:flutter/material.dart';
import 'package:foodie/app/modules/home/views/widgets/categories_widget.dart';
import 'package:foodie/app/modules/home/views/widgets/meal_widget.dart';
import 'package:foodie/app/modules/home/views/widgets/search_bar_widget.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (homeController.isLoading.value) {
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
                    SearchBarWidget(
                      onSearch: (value) {},
                      hintText: "Search",
                      enable: false,
                      onPressed: () => Get.toNamed(Routes.SEARCH),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const Row(
                      children: [
                        Text(
                          "Explore Categories",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 15),
                        ),
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
                            homeController.categories.value?.categories?.length ??
                                0,
                        itemBuilder: (BuildContext context, int index) {
                          var category =
                              homeController.categories.value?.categories?[index];

                          return CategoriesWidget(
                            categoryName: category?.strCategory ?? "",
                            imageUrl: category?.strCategoryThumb ?? "",
                            onPressed: () => homeController.getCategoryListing(
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
                                var meal = homeController
                                    .categoryListing.value?.meals?[index];
                                return MealWidget(
                                    mealName: meal?.strMeal ?? "",
                                    mealImage: meal?.strMealThumb ?? "");
                              },
                              itemCount: homeController
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
