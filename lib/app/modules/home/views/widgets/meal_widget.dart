import 'package:flutter/material.dart';
import 'package:foodie/app/modules/detail/controllers/detail_controller.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:get/get.dart';

class MealWidget extends StatefulWidget {
  final String mealName;
  final String mealImage;
  final String mealId;

  const MealWidget(
      {super.key,
      required this.mealName,
      required this.mealImage,
      required this.mealId});

  @override
  State<MealWidget> createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  @override
  Widget build(BuildContext context) {
    final DetailController detailController = Get.put(DetailController());
    return GestureDetector(
      onTap: () {
        detailController.getMealDetails(widget.mealId);
        Get.toNamed(Routes.DETAIL);
      },
      child: Stack(
        children: [
          Container(
            height: double.maxFinite,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  widget.mealImage,
                ),
                fit: BoxFit.fill,
              ),
              color: Colors.black,
            ),
          ),
          const Positioned(
              top: 20,
              right: 20,
              child: Icon(
                Icons.favorite_border,
                color: Colors.orangeAccent,
              )),
          Positioned(
            bottom: 10,
            left: 10,
            child: SizedBox(
              width: 150,
              child: Text(
                widget.mealName,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
