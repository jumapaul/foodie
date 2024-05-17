class CategoriesFields {
  static const String tableName = 'categories';
  static const String categoryId = "idCategory";
  static const String categoryName = "strCategory";
  static const String categoryThumb = "strCategoryThumb";
  static const String categoryDescription = "strCategoryDescription";
  static const idType = 'INTEGER PRIMARY KEY';

  static const List<String> values = [categoryId, categoryName, categoryThumb];
}
