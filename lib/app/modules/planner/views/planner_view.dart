import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/planner_controller.dart';

class PlannerView extends GetView<PlannerController> {
  const PlannerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlannerView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PlannerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
