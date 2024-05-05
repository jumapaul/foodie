import 'package:flutter/material.dart';
import 'package:foodie/app/modules/countries/views/countries_view.dart';
import 'package:foodie/app/modules/favorite/views/favorite_view.dart';
import 'package:foodie/app/modules/home/views/home_view.dart';
import 'package:foodie/app/modules/planner/views/planner_view.dart';

import 'package:get/get.dart';

import '../controllers/main_page_controller.dart';

class MainPageView extends StatelessWidget {
  final TextStyle unselectedLabelStyle = const TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
  );

  final TextStyle selectedLabelStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.w500);

  const MainPageView({super.key});

  buildBottomNavigationMenu(context, pageController) {
    return Obx(
      () => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: SizedBox(
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              // backgroundColor: Colors.white.withOpacity(0.7),
              showUnselectedLabels: true,
              showSelectedLabels: true,
              elevation: 1,
              onTap: pageController.changeTabIndex,
              currentIndex: pageController.tabIndex.value,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.green,
              unselectedLabelStyle: unselectedLabelStyle,
              selectedLabelStyle: selectedLabelStyle,
              items: [
                BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: const Icon(
                        Icons.home,
                        size: 20,
                      ),
                    ),
                    label: 'Discover',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: const Icon(
                        Icons.flag,
                        size: 20,
                      ),
                    ),
                    label: 'Countries',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: const Icon(
                        Icons.calendar_month,
                        size: 20,
                      ),
                    ),
                    label: 'Planner',
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(bottom: 7),
                      child: const Icon(
                        Icons.favorite,
                        size: 20,
                      ),
                    ),
                    label: 'Favorite',
                    backgroundColor: Colors.white)
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MainPageController pageController =
        Get.put(MainPageController(), permanent: false);
    return SafeArea(
      child: Scaffold(
        body: Obx(() => IndexedStack(
              index: pageController.tabIndex.value,
              children: const [
                HomeView(),
                CountriesView(),
                PlannerView(),
                FavoriteView()
              ],
            )),
        bottomNavigationBar: buildBottomNavigationMenu(
          context,
          pageController,
        ),
      ),
    );
  }
}
