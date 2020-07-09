import 'dart:io';

import 'package:gdgfoz/data/models/category_model.dart';

abstract class ICategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
  Future<CategoryModel> add({CategoryModel categoryModel});
  Future<CategoryModel> getByID({String id});
  Future<CategoryModel> update({CategoryModel categoryModel});
  Future<int> deleteByID({String id});
  Future<File> downloadImage({String url});
}
