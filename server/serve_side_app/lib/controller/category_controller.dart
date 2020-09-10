import 'package:serve_side_app/serve_side_app.dart';
import 'package:serve_side_app/model/category_model.dart';
import 'package:uuid/uuid.dart';

class CategoryController extends ResourceController {
  final ManagedContext managedContext;

  CategoryController({this.managedContext});

 // final List _categories = [
 //   {'nome': 'Sanduíches'},
 //   {'nome': 'Porções'},
 //   {'nome': 'Bebidas'}
 // ];

  @Operation.get()
 // Future<Response> getAll() async {
  Future<Response> getAll({@Bind.query('q') String prefix}) async {
    final query = Query<CategoryModel>(managedContext);

    if (prefix!=null) {
      query.where((c) => c.name).beginsWith(prefix, caseSensitive: false);
    }

    query
    .sortBy((c) => c.name, QuerySortOrder.ascending);
//    ..fetchLimit = 10;

//    query
//        ..sortBy((c) => c.name, QuerySortOrder.ascending)
//    ..fetchLimit = 10;


//    query
//      ..pageBy((c) => c.name, QuerySortOrder.ascending, boundingValue: 'Bebidas')
//      ..fetchLimit = 2;

    final categoryList = await query.fetch();

    return Response.ok(categoryList);
   return Response.ok(null);
   // return Response.ok(_categories);
  }

  @Operation.get('id')
//  Future<Response> getById(@Bind.path('id') int id) async {
  Future<Response> getById(@Bind.path('id') String id) async {
//    int id = int.parse(request.path.variables['id']);
    final query = Query<CategoryModel>(managedContext)
      ..where((c) => c.categoryID).equalTo(id);

    final categoryFound = await query.fetchOne();

    if (categoryFound != null)
      return Response.ok(categoryFound);
    return Response.notFound();
//    return Response.ok(_categories[id]);
  }
//
  @Operation.post()
  Future<Response> add(@Bind.body(ignore: ['categoryID']) CategoryModel newCategory) async {
    final uuid = Uuid();
    newCategory.categoryID = uuid.v1();

    final query = Query<CategoryModel>(managedContext)
      ..values = newCategory;

    final insertedCategory = await query.insert();

    return Response.ok(insertedCategory);
  }

  @Operation.put('id')
  Future<Response> update(@Bind.path('id') String id,
      @Bind.body(ignore: ['categoryID']) CategoryModel categoryToUpdate) async {

    final query = Query<CategoryModel>(managedContext)
      ..values = categoryToUpdate
    ..where((c) => c.categoryID).equalTo(id);

    final updatedCategory = await query.updateOne();

    return Response.ok(updatedCategory);
  }

  @Operation.delete('id')
  Future<Response> delete(@Bind.path('id') String id) async {
    final query = Query<CategoryModel>(managedContext)
      ..where((c) => c.categoryID).equalTo(id);

    final deletedCount = await query.delete();

//    final resultMessage = {'message': '$deletedCategory deleted(s)'};
//    return Response.ok(resultMessage);
    return Response.ok(deletedCount);
  }
}
