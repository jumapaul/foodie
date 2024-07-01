import 'package:flutter/material.dart';

class AddMealWidget extends StatelessWidget {
  const AddMealWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade300
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.add_circle_outline,
        color: Colors.grey,
      ),
    );
  }
}
