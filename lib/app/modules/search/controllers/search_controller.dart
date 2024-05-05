import 'dart:math';

import 'package:get/get.dart';

import '../../../data/models/categories/searchResultsResponse.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants/strings.dart';

class SearchViewController extends GetxController {

  var searchResults = Rx<SearchResultsResponse?>(null);

  var isLoading = false.obs;

  getSearchResults(String? search) async {
    isLoading.value = true;
    var response = await http.get(Uri.parse("$baseUrl$searchEndPoint$search"));

    if (response.statusCode == 200) {
      searchResults.value = searchResultsResponseFromJson(response.body);
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getSearchResults("");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
