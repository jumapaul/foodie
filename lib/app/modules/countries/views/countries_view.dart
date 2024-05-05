import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/countries_controller.dart';

class CountriesView extends GetView<CountriesController> {
  const CountriesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CountriesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CountriesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
