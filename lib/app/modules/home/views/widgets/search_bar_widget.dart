import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {

  final TextEditingController? controller;
  final String hintText;

  const SearchBarWidget({super.key, this.controller, required this.hintText,

  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black)
      ),

      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            border: InputBorder.none,
            suffixIcon: GestureDetector(
              child: const Icon(
                Icons.search
              ),
            )
          ),
        ),
      ),
    );
  }
}
