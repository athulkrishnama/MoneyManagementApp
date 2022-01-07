import 'package:hive/hive.dart';
import 'package:money_management/models/category/category_model.dart';

const Category_DB_Name = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
}

class CategoryDB implements CategoryDbFunctions {
  @override
  Future<void>insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_DB_Name);
    await _categoryDB.add(value);
  }

  @override
  Future<List<CategoryModel>>getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_DB_Name);
    return _categoryDB.values.toList();
  }
}
