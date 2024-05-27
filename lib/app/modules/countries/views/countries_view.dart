import 'package:flutter/material.dart';
import 'package:foodie/app/modules/countries/views/widgets/countries_widget.dart';
import 'package:foodie/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:foodie/app/modules/home/views/widgets/meal_widget.dart';
import 'package:get/get.dart';
import '../controllers/countries_controller.dart';

class CountriesView extends GetView<CountriesController> {
  const CountriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final CountriesController countriesController =
        Get.put(CountriesController());

    final FavoriteController favoriteController = Get.put(FavoriteController());
    return Scaffold(
      body: Obx(
        () {
          var index = countriesController.tabIndex.value;
          var item = countriesController.countries[index];
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 4,
                  child: Center(
                    child: Stack(children: [
                      SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: buildFlag(item.flagUrl),
                      ),
                      Positioned(
                          top: 10,
                          left: MediaQuery.of(context).size.width / 2.5,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.orange),
                            textAlign: TextAlign.center,
                          )),
                    ]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Select country",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: countriesController.countries.length,
                            itemBuilder: (context, index) {
                              var country = countriesController.countries[index];

                              return GestureDetector(
                                  onTap: () {
                                    countriesController.tabIndex.value = index;
                                    countriesController.getCountryMeal(country.name);
                                  },
                                  child: CountriesNameWidget(
                                      countryName: country.name));
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                width: 5,
                              );
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          flex: 7,
                          child: Obx(() {
                            if (countriesController.isLoading.value) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              );
                            } else {
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemBuilder: (context, index) {
                                  var areaMeal = countriesController
                                      .mealByArea.value?.meals?[index];
                                  return MealWidget(
                                    onPressed: (){
                                      favoriteController.addFavoriteMealToDb(areaMeal);
                                    },
                                      mealName: areaMeal?.strMeal ?? "",
                                      mealImage: areaMeal?.strMealThumb ?? "",
                                      mealId: areaMeal?.idMeal ?? "");
                                },
                                itemCount: countriesController.mealByArea.value?.meals?.length,
                              );
                            }
                          }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget buildFlag(String? flagUrl) {
  if (flagUrl != null && flagUrl.isNotEmpty) {
    return Image.network(flagUrl, fit: BoxFit.cover);
  } else {
    return const CircularProgressIndicator(
      strokeWidth: 2,
    );
  }
}
