import 'package:flutter/material.dart';
import 'package:foodie/app/modules/detail/views/widget/ingredientsListingWidget.dart';
import 'package:foodie/app/modules/detail/views/widget/instructionsWidget.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailController detailController = Get.put(DetailController());
    return SafeArea(child: Scaffold(
      body: Obx(() {
        if (detailController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        } else {
          return SafeArea(
            child: Column(children: [
              Expanded(
                flex: 3,
                child: Stack(children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Image.network(
                      detailController
                              .mealDetail.value?.meals?.first.strMealThumb ??
                          "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_circle_left_outlined,
                        color: Colors.white,
                      ),
                    ),
                  )
                ]),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  decoration: const BoxDecoration(color: Colors.orangeAccent),
                  width: double.infinity,
                  child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        appBar: AppBar(
                          automaticallyImplyLeading: false,
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${detailController.mealDetail.value?.meals?.first.strMeal}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    var processLink = detailController
                                        .mealDetail
                                        .value
                                        ?.meals
                                        ?.first
                                        .strYoutube;

                                    _launchUrl(processLink!);
                                  },
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child:
                                        Image.asset('asset/images/youtube.png'),
                                  ),
                                )
                              ]),
                          bottom: const TabBar(
                            tabs: [
                              TabBarTitle(
                                title: "Ingredients",
                                titleIcon: Ionicons.reader,
                              ),
                              TabBarTitle(
                                title: "Instructions",
                                titleIcon: Icons.fact_check,
                              )
                            ],
                          ),
                        ),
                        body: const TabBarView(
                          children: [
                            IngredientsListingWidget(),
                            InstructionWidget(),
                          ],
                        ),
                      )),
                ),
              )
            ]),
          );
        }
      }),
    ));
  }
}

class TabBarTitle extends StatelessWidget {
  final String title;
  final IconData titleIcon;

  const TabBarTitle({super.key, required this.title, required this.titleIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          titleIcon,
          color: Colors.orange,
        ),
        Text(title)
      ],
    );
  }
}

Future<void> _launchUrl(String link) async {
  if (!await canLaunchUrl(Uri.parse(link))) {
   await launch(link);
  }else{
    throw Exception("Could not launch $link");
  }
}
