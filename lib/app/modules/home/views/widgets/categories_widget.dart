import 'package:flutter/material.dart';

class CategoriesWidget extends StatefulWidget {
  final String? imageUrl;
  final String categoryName;
  final VoidCallback onPressed;

  const CategoriesWidget(
      {super.key,
      this.imageUrl,
      required this.categoryName,
      required this.onPressed});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(0.5)),
            child: Image.network(
              widget.imageUrl ?? "",
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            widget.categoryName,
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 10),
          )
        ],
      ),
    );
  }
}
