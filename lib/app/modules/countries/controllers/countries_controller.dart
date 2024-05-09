import 'package:foodie/app/data/models/countries.dart';
import 'package:foodie/app/utils/constants/strings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../data/models/mealByAreaResponse.dart';


class CountriesController extends GetxController {

  var countries = <Countries>[
    Countries(
        name: "American",
        flagUrl:
        "https://cdn.pixabay.com/photo/2017/01/25/10/04/usa-2007460_1280.jpg"),
    Countries(
        name: "British",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/11/15/31/united-28519_1280.png"),
    Countries(
        name: "Canadian",
        flagUrl:
        "https://flagcdn.com/w320/ca.png"),
    Countries(
        name: "Chinese",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/10/23/05/china-26841_1280.png"),
    Countries(
        name: "Croatian",
        flagUrl:
        "https://cdn.pixabay.com/photo/2016/01/23/22/04/flag-of-croatia-1158161_1280.png"),
    Countries(
        name: "Dutch",
        flagUrl:
        "https://cdn.pixabay.com/photo/2016/11/20/03/23/dutch-1841912_1280.png"),
    Countries(
        name: "Egyptian",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/10/23/13/egypt-26909_1280.png"),
    Countries(
        name: "French",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/11/15/19/france-28463_1280.png"),
    Countries(
        name: "Greek",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/10/23/09/greece-26871_1280.png"),
    Countries(
        name: "Indian",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/10/23/03/india-26828_1280.png"),
    Countries(
        name: "Irish",
        flagUrl:
        "https://cdn.pixabay.com/photo/2018/01/28/18/00/ireland-3114291_1280.png"),
    Countries(
        name: "Italian",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/11/15/35/flag-28543_1280.png"),
    Countries(
        name: "Jamaican",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/14/16/53/flag-34591_1280.png"),
    Countries(
        name: "Japanese",
        flagUrl:
        "https://flagcdn.com/w320/jp.png"),
    Countries(
        name: "Kenyan",
        flagUrl:
        "https://flagcdn.com/w320/ke.png"),
    Countries(
        name: "Malaysian",
        flagUrl:
        "https://cdn.pixabay.com/photo/2021/11/15/09/57/malaysia-6797563_1280.png"),
    Countries(
        name: "Mexican",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/26/11/55/flag-42281_1280.png"),
    Countries(
        name: "Moroccan",
        flagUrl:
        "https://flagcdn.com/w320/ma.png"),
    Countries(
        name: "Polish",
        flagUrl:
        "https://flagcdn.com/w320/pl.png"),
    Countries(
        name: "Portuguese",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/10/23/11/portugal-26886_1280.png"),
    Countries(
        name: "Russian",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/10/23/12/russia-26896_1280.png"),
    Countries(
        name: "Spanish",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/11/15/33/spain-28530_1280.png"),
    Countries(
        name: "Thai",
        flagUrl:
        "https://cdn.pixabay.com/photo/2021/11/16/02/35/thailand-6799924_1280.png"),
    Countries(
        name: "Tunisian",
        flagUrl:
        "https://cdn.pixabay.com/photo/2013/07/13/14/17/tunisia-162444_1280.png"),
    Countries(
        name: "Turkish",
        flagUrl:
        "https://flagcdn.com/w320/tr.png"),
    Countries(
        name: "Unknown",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/23/16/22/flag-38806_1280.png"),
    Countries(
        name: "Vietnamese",
        flagUrl:
        "https://cdn.pixabay.com/photo/2012/04/10/23/04/vietnam-26834_1280.png"),
  ].obs;

  var isLoading = false.obs;
  var mealByArea = Rx<MealByAreaResponse?>(null);

  getCountryMeal(String? countryName) async{
    isLoading.value = true;
    var response = await http.get(Uri.parse("$baseUrl$filterByAreaEndPoint$countryName"));

    if(response.statusCode == 200){
      mealByArea.value = mealByAreaResponseFromJson(response.body);

      isLoading.value = false;
    }
  }
  var tabIndex = 0.obs;

  void changeTabIndex(int? index) {
    tabIndex.value = index?? 0;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getCountryMeal("American");
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
