import 'package:flutter/material.dart';

class AddMealWidget extends StatefulWidget {

  final VoidCallback onPressed;
  const AddMealWidget({super.key, required this.onPressed});

  @override
  State<AddMealWidget> createState() => _AddMealWidgetState();
}

class _AddMealWidgetState extends State<AddMealWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade300
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.add_circle_outline,
          color: Colors.grey,
        ),
      ),
    );
  }
}
