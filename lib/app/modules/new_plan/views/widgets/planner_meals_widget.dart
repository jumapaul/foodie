import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../detail/controllers/detail_controller.dart';

class PlannerMealsWidget extends StatefulWidget {
  final String? mealName;
  final String? mealImage;
  final String? mealId;
  final VoidCallback onPressed;

  const PlannerMealsWidget(
      {super.key, this.mealName, this.mealImage, this.mealId, required this.onPressed});

  @override
  State<PlannerMealsWidget> createState() => _PlannerMealsWidgetState();
}

class _PlannerMealsWidgetState extends State<PlannerMealsWidget> {
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
                  widget.mealImage!,
                ),
                fit: BoxFit.fill,
              ),
              color: Colors.black,
            ),
          ),
          Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: widget.onPressed,
                child: const Icon(
                  Icons.remove_circle,
                  color: Colors.orangeAccent,
                ),
              )),
          Positioned(
            bottom: 10,
            left: 10,
            child: SizedBox(
              width: double.maxFinite,
              child: Text(
                widget.mealName!,
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
