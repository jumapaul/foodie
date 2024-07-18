import 'package:foodie/app/utils/resource/DataState.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/categories/categoriesResponse.dart';
import '../../../data/models/categories/categoryListing.dart';
import '../../../utils/constants/strings.dart';


class HomeController extends GetxController {
  var isLoading = false.obs;
  var categories = Rx<DataState<CategoriesResponse>>(const Initial());
  var categoryListing = Rx<CategoryListing?>(null);

  getCategories() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl$categoryEndPoint"));

      if (response.statusCode == 200) {
        var categoryResponse = categoriesResponseFromJson(response.body);
        categories.value = Success(categoryResponse);
      } else {
        categories.value = const Error("Failed to load categories}");
      }
    } catch (e) {
      categories.value = Error("Network error: $e");
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

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getCategoryListing("Beef");
    getCategories();
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
