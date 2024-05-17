import 'package:foodie/app/data/models/categories/categoriesResponse.dart';
import 'package:foodie/app/services/categories_field.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static const int _version = 3;
  static const String _dbName = "categories";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async {
      await db.execute("""
      CREATE TABLE ${CategoriesFields.tableName}(
      ${CategoriesFields.categoryId} ${CategoriesFields.idType},
      ${CategoriesFields.categoryName} TEXT,
      ${CategoriesFields.categoryThumb} TEXT,
      ${CategoriesFields.categoryDescription} TEXT
      )
      """);
    }, version: _version);
  }

  static Future<int> addMealsCategories(Categories categories) async {
    final db = await _getDB();
    return await db.insert(CategoriesFields.tableName, categories.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> addCategoriesList(List<Categories> categoriesList) async {
    final db = await _getDB();
    Batch batch = db.batch();

    for (var category in categoriesList) {
      batch.insert(CategoriesFields.tableName, category.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  static Future<List<Categories>?> getAllCategories() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps =
        await db.query(CategoriesFields.tableName);

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => Categories.fromJson(maps[index]));
  }
}
