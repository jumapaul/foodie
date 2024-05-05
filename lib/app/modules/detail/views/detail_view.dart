import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailController detailController = Get.put(DetailController());
    var mealDetail = detailController.mealDetail.value?.meals?.first;
    return SafeArea(
      child:Scaffold(
        body:  Expanded(
            flex: 3,
            child: Obx(() {
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
                          height: double.infinity,
                          width: double.infinity,
                          child: Image.network(
                            detailController.mealDetail.value?.meals?.first.strMealThumb ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Positioned(
                          top: 20,
                          left: 10,
                          child: Icon(
                            Icons.arrow_circle_left_outlined,
                            color: Colors.white,
                          ),
                        )
                      ]),
                    ),
                    Expanded(
                        flex: 8,
                        child: Column(
                          children: [
                            Text("${detailController.mealDetail.value?.meals?.first.strMeal}"),
                          ],
                        ))
                  ]),
                );
              }
            })),
      )
    );
  }
}
