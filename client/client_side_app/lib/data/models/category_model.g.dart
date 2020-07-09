// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) {
  return CategoryModel(
    categoryID: json['categoryID'] as String,
    name: json['name'] as String,
    imageBase64: json['imageBase64'] as String,
  );
}

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'categoryID': instance.categoryID,
      'name': instance.name,
      'imageBase64': instance.imageBase64,
    };
