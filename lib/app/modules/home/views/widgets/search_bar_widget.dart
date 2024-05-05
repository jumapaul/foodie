import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool enable;
  final VoidCallback? onPressed;
  final void Function(String) onSearch;

  const SearchBarWidget({
    super.key,
    this.controller,
    required this.hintText,
    required this.enable,
    this.onPressed,
    required this.onSearch,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: TextFormField(
            controller: widget.controller,
            enabled: widget.enable,
            onChanged: (value) => widget.onSearch(value),
            decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  child: const Icon(Icons.search),
                )),
          ),
        ),
      ),
    );
  }
}
