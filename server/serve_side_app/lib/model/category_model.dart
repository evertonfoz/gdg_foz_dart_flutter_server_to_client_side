import 'package:serve_side_app/serve_side_app.dart';

class CategoryModel extends ManagedObject<_CategoryModel>
    implements _CategoryModel {}

class _CategoryModel {
  @Column(primaryKey: true, autoincrement: false)
  String categoryID;

  @Column(unique: true, indexed: true)
  String name;

  @Column(nullable: true)
  String imageBase64;
}