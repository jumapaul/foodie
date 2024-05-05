import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/categories/categoriesResponse.dart';
import '../../../data/models/categories/categoryListing.dart';
import '../../../utils/constants/strings.dart';

class HomeController extends GetxController {
  //
  var isLoading = false.obs;

  var categories = Rx<CategoriesResponse?>(null);
  var categoryListing = Rx<CategoryListing?>(null);

  getCategories() async {
    isLoading.value = true;
    var response = await http.get(Uri.parse("$baseUrl$categoryEndPoint"));

    if (response.statusCode == 200) {
      categories.value = categoriesResponseFromJson(response.body);

      isLoading.value = false;
    }
  }


  getCategoryListing(String category) async {
    var response =
        await http.get(Uri.parse("$baseUrl$categoryListingEndpoint$category"));
    if (response.statusCode == 200) {
      categoryListing.value = categoryListingFromJson(response.body);
      isLoading.value = false;
    }
  }

  getSearchResults(String search) async{
    var response = await http.get(Uri.parse("$baseUrl$searchEndPoint$search"));

    // if(response.statusCode == 200){
    //   categoryListing.value =
    // }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getCategories();
    getCategoryListing("Beef");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
