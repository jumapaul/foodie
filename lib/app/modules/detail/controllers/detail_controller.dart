import 'package:foodie/app/utils/constants/strings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/detailResponse.dart';

class DetailController extends GetxController {
  var isLoading = false.obs;

  var mealDetail = Rx<DetailResponse?>(null);

  getMealDetails(String? mealId) async {
    isLoading.value = true;

    if(mealId != null){
      var response = await http.get(Uri.parse("$baseUrl$detailEndPoint$mealId"));

      if (response.statusCode == 200) {
        mealDetail.value = detailResponseFromJson(response.body);

        isLoading.value = false;
      }else {
        print("Failed to load meal details: ${response.statusCode}");
        isLoading.value = false;
      }
    }

  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getMealDetails("");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
