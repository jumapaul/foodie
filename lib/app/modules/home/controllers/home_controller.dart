import 'package:foodie/app/modules/home/use_cases/home_use_case.dart';
import 'package:foodie/app/services/database_helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import '../../../data/models/categories/categoriesResponse.dart';
import '../../../data/models/categories/categoryListing.dart';
import '../../../utils/constants/strings.dart';

final Logger _logger = Logger('HomeController');
class HomeController extends GetxController {

  var isLoading = false.obs;

  var categories = Rx<CategoriesResponse?>(null);
  var categoryListing = Rx<CategoryListing?>(null);

  final HomeUseCase _homeUseCase = HomeUseCase();

  Future<void> getCategoriesFromDatabase() async {
    isLoading.value = true;
    List<Categories>? categoriesFromDb =
        await DatabaseHelper.getAllCategories();

    _logger.info("------------>$categoriesFromDb");

    if (categoriesFromDb != null) {
      categories.value = CategoriesResponse(categories: categoriesFromDb);
    } else {
      categories.value = null;
    }

    isLoading.value = false;
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
    _homeUseCase.fetchAndSaveCategories();
  }

  @override
  void onReady() {
    getCategoriesFromDatabase();
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
