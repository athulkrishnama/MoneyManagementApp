import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management/models/category/category_model.dart';

const Category_DB_Name = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();

  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);

  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_DB_Name);
    await _categoryDB.put(value.id, value);
    refresh();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_DB_Name);
    return _categoryDB.values.toList();
  }

  Future<void> refresh() async {
    final _allCategories = await getCategories();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    Future.forEach(_allCategories, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeCategoryList.value.add(category);
      } else {
        expenseCategoryList.value.add(category);
      }
      incomeCategoryList.notifyListeners();
      expenseCategoryList.notifyListeners();
    });
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(Category_DB_Name);
    await _categoryDB.delete(categoryID);
    refresh();
  }
}
