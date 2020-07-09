import 'dart:convert';
import 'dart:io';

import 'package:file/memory.dart';
import 'package:flutter/foundation.dart';
import 'package:gdgfoz/core/error/gdg_http_exception.dart';
import 'package:gdgfoz/data/datasources/interfaces/i_category_remote_datasource.dart';
import 'package:gdgfoz/data/datasources/services_client.dart';
import 'package:gdgfoz/data/models/category_model.dart';
import 'package:gdgfoz/data/models/user_model.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

class CategoryModelRemoteDataSourceImpl implements ICategoryRemoteDataSource {
  final String categoriesBaseUrl = '$kBaseUrl/categories';
  final UserModel tokenToAuthentication = GetIt.I.get<UserModel>();

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await servicesClient.get(
      '$categoriesBaseUrl',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenToAuthentication.token}'
      },
    );

    if (response.statusCode == 200)
      return _convertMapResultToList(bodyResult: response.body);

    throw GdgHttpException(
        GdgHttpException.getErrorMessage(response.statusCode));
  }

  @override
  Future<CategoryModel> add({CategoryModel categoryModel}) async {
    final response = await servicesClient.post('$categoriesBaseUrl',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${tokenToAuthentication.token}'
        },
        body: jsonEncode(categoryModel.toJson()));

    if (response.statusCode == 200)
      return CategoryModel.fromJson(jsonDecode(response.body));

    throw GdgHttpException(
        GdgHttpException.getErrorMessage(response.statusCode));
  }

  @override
  Future<CategoryModel> getByID({String id}) async {
    final response = await servicesClient.get(
      '$categoriesBaseUrl/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenToAuthentication.token}'
      },
    );

    if (response.statusCode == 200)
      return CategoryModel.fromJson(jsonDecode(response.body));

    throw GdgHttpException(
        GdgHttpException.getErrorMessage(response.statusCode));
  }

  @override
  Future<CategoryModel> update({CategoryModel categoryModel}) async {
    final response = await servicesClient.put(
        '$categoriesBaseUrl/${categoryModel.categoryID}',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${tokenToAuthentication.token}'
        },
        body: jsonEncode(categoryModel.toJson()));

    if (response.statusCode == 200)
      return CategoryModel.fromJson(jsonDecode(response.body));

    throw GdgHttpException(
        GdgHttpException.getErrorMessage(response.statusCode));
  }

  @override
  Future<int> deleteByID({String id}) async {
    final response = await servicesClient.delete(
      '$categoriesBaseUrl/$id',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${tokenToAuthentication.token}'
      },
    );

    if (response.statusCode == 200) return jsonDecode(response.body);

    throw GdgHttpException(
        GdgHttpException.getErrorMessage(response.statusCode));
  }

  @override
  Future<File> downloadImage({String url}) async {
    HttpClient httpClient = HttpClient();

    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();

    if (response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      var memoryFile = MemoryFileSystem().file('downloadedImage');
      memoryFile.writeAsBytesSync(bytes);
      return memoryFile;
    }
    throw GdgHttpException(
        GdgHttpException.getErrorMessage(response.statusCode));
  }

  List<CategoryModel> _convertMapResultToList({@required bodyResult}) {
    return (json.decode(bodyResult) as List<dynamic>)
        .map((e) => CategoryModel.fromJson(e))
        .toList();
  }
}
