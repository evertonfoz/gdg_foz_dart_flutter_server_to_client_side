import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'category_model.g.dart';

// flutter packages pub run build_runner build

@JsonSerializable()
class CategoryModel {
  final String categoryID;
  final String name;
  final String imageBase64;

  CategoryModel({this.categoryID, @required this.name, this.imageBase64});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() {
    return 'CategoryID: $categoryID, Name: $name';
  }
}
