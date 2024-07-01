import 'package:flutter/material.dart';

class DaysOfTheWeek extends StatefulWidget {
  final String dayOfTheWeek;
  final bool isSelected;
  final VoidCallback onPressed;

  const DaysOfTheWeek(
      {super.key,
      required this.dayOfTheWeek,
      required this.onPressed,
      required this.isSelected});

  @override
  State<DaysOfTheWeek> createState() => _DaysOfTheWeekState();
}

class _DaysOfTheWeekState extends State<DaysOfTheWeek> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.isSelected ? Colors.orangeAccent : Colors.white,
                  border: Border.all(color: Colors.orangeAccent, width: 1)),
              child: Text(widget.dayOfTheWeek),
            ),
          ],
        ));
  }
}
