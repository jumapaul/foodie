import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import '../../../data/models/categories/categoriesResponse.dart';
import '../../../services/database_helper.dart';
import '../../../utils/constants/strings.dart';

final Logger _logger = Logger('HomeUseCase');
class HomeUseCase {
  Future<CategoriesResponse?> fetchAndSaveCategories() async {

    var response = await http.get(Uri.parse("$baseUrl$categoryEndPoint"));

    if (response.statusCode == 200) {
      var categoriesResponse = categoriesResponseFromJson(response.body);

      if (categoriesResponse.categories != null) {
        await DatabaseHelper.addCategoriesList(categoriesResponse.categories!);
      }
      //Save categories to database

      return categoriesResponse;
    } else {
      return null;
    }
  }
}
