import 'package:foodie/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:get/get.dart';

import '../controllers/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(
      () => MainPageController(),
    );

    Get.lazyPut<FavoriteController>(
      () => FavoriteController(),
    );
  }
}
