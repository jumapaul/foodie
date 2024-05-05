import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MealWidget extends StatefulWidget {
  final String mealName;
  final String mealImage;

  const MealWidget(
      {super.key, required this.mealName, required this.mealImage});

  @override
  State<MealWidget> createState() => _MealWidgetState();
}

class _MealWidgetState extends State<MealWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
