import 'package:flutter/material.dart';

class CountriesNameWidget extends StatelessWidget {
  final String countryName;

  const CountriesNameWidget({super.key, required this.countryName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.withOpacity(0.5)),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(countryName),
        ),
      ),
    );
  }
}
