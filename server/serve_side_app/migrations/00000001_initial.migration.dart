import 'dart:async';
import 'package:aqueduct/aqueduct.dart';
import 'package:uuid/uuid.dart';

class Migration1 extends Migration {
  @override
  Future upgrade() async {
    database.createTable(
      SchemaTable("_CategoryModel", [
        SchemaColumn("categoryID", ManagedPropertyType.string,
            isPrimaryKey: true,
            autoincrement: false,
            isIndexed: false,
            isNullable: false,
            isUnique: false),
        SchemaColumn("name", ManagedPropertyType.string,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: true,
            isNullable: false,
            isUnique: true),
        SchemaColumn("description", ManagedPropertyType.document,
            isPrimaryKey: false,
            autoincrement: false,
            isIndexed: false,
            isNullable: false,
            isUnique: false),
      ]),
    );
  }

  @override
  Future downgrade() async {}

  @override
  Future seed() async {
    final rows = [
      { 'categoryID': '1e4722e4-8b79-4f4c-8567-310794233a3f', 'name': 'Sanduíches' },
      { 'categoryID': '26439fc4-4149-4169-8209-0dd5f4f216e7', 'name': 'Bebidas' },
      { 'categoryID': 'd100d074-4e30-4c81-8f56-3799f4ae24bc', 'name': 'Porções' },
    ];

    for(final row in rows) {
      await database.store.execute("INSERT INTO _CategoryModel(categoryID, name, description) VALUES(@categoryID, @name, @description)",
      substitutionValues: {
        "categoryID" : row["categoryID"],
        "name" : row["name"],
        "description" : row["description"],
      });
    }
  }
}
