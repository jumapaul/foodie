import 'package:foodie/app/utils/constants/strings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/detailResponse.dart';

class DetailController extends GetxController {
  var isLoading = false.obs;

  var mealDetail = Rx<DetailResponse?>(null);

  List<String> ingredientsWithMeasures = [];

  List<String> recipe = [];

  getMealDetails(String? mealId) async {
    isLoading.value = true;

    if (mealId != null) {
      var response =
          await http.get(Uri.parse("$baseUrl$detailEndPoint$mealId"));

      if (response.statusCode == 200) {
        mealDetail.value = detailResponseFromJson(response.body);

        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  void getIngredientsLists() {
    ever<DetailResponse?>(mealDetail, (response) {
      if (response != null && response.meals != null) {
        var meals = response.meals?.first;

        for (int i = 1; i <= 20; i++) {
          String? ingredient = meals?.getIngredient(i);
          String? measure = meals?.getMeasure(i);

          if (ingredient != null &&
              ingredient.isNotEmpty &&
              measure != null &&
              measure.isNotEmpty) {
            ingredientsWithMeasures.add("$ingredient - $measure");
          } else if (ingredient != null && ingredient.isNotEmpty) {
            ingredientsWithMeasures.add(ingredient);
          } else {
            break;
          }
        }
      }
    });
  }

  void getMealInstructions() {
    ever<DetailResponse?>(mealDetail, (response) {
      var mealInstruction = mealDetail.value?.meals?.first.strInstructions;

      if(mealInstruction!=null){
        var steps = mealInstruction.split(". ");

        for(String step in steps){
          recipe.add(step);
        }
      }
    });
  }

  // getRecipe() {
  //   var mealInstruction = mealDetail.value?.meals?.first.strInstructions;
  //   if (mealInstruction != null) {
  //     var steps = mealInstruction.split(". ");
  //
  //     for(String steps in steps){
  //       recipe.add(steps);
  //     }
  //     print("========>${recipe.length}");
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getMealDetails("");
    getIngredientsLists();
    getMealInstructions();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
