import 'package:get/get.dart';

import '../controllers/new_plan_controller.dart';

class NewPlanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPlanController>(
      () => NewPlanController(),
    );
  }
}
