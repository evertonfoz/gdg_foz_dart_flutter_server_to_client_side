import 'package:aqueduct/managed_auth.dart';
import 'package:serve_side_app/configuration/gdg_configuration.dart';
import 'package:serve_side_app/controller/category_controller.dart';
import 'package:serve_side_app/controller/register_controller.dart';
import 'package:serve_side_app/model/user_model.dart';

import 'serve_side_app.dart';

class ServeSideAppChannel extends ApplicationChannel {
  ManagedContext _managedContext;
  AuthServer authServer;

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();

//    final database = PostgreSQLPersistentStore.
//      fromConnectionInfo('gdg_user', '123456', 'localhost', 5432, 'gdg');

    final config = GdgConfiguration(options.configurationFilePath);
    final database = PostgreSQLPersistentStore.fromConnectionInfo(
        config.database.username,
        config.database.password,
        config.database.host,
        config.database.port,
        config.database.databaseName);

    _managedContext = ManagedContext(dataModel, database);
    final delegate = ManagedAuthDelegate<UserModel>(_managedContext);
    authServer = AuthServer(delegate);
  }

  @override
  Controller get entryPoint {
    final router = Router();

//    router
//      .route("/example")
//      .linkFunction((request) async {
//        return Response.ok({"key": "value"});
//      });

//    router
//        .route("/gdg_foz")
//        .linkFunction((request) async {
//      return Response.ok("GDG Foz")..contentType = ContentType.text;
//    });

//    router
//        .route("/categories/[:id]")
//        .link(() => CategoryController());

    router
        .route("/categories/[:id]")
        .link(() => Authorizer.bearer(authServer))
        .link(() => CategoryController(managedContext: _managedContext));

    router.route('/auth/token').link(() => AuthController(authServer));

    router.route("/register/").link(() => RegisterController(
        managedContext: _managedContext, authServer: authServer));

    return router;
  }
}
