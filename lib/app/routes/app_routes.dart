part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const DETAIL = _Paths.DETAIL;
  static const MAIN_PAGE = _Paths.MAIN_PAGE;
  static const COUNTRIES = _Paths.COUNTRIES;
  static const PLANNER = _Paths.PLANNER;
  static const FAVORITE = _Paths.FAVORITE;
  static const SEARCH = _Paths.SEARCH;
  static const NEW_PLAN = _Paths.NEW_PLAN;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const DETAIL = '/detail';
  static const MAIN_PAGE = '/main-page';
  static const COUNTRIES = '/countries';
  static const PLANNER = '/planner';
  static const FAVORITE = '/favorite';
  static const SEARCH = '/search';
  static const NEW_PLAN = '/new-plan';
}
