import 'package:aqueduct/aqueduct.dart';
import 'package:serve_side_app/model/user_model.dart';

class RegisterController extends ResourceController {
  RegisterController({this.managedContext, this.authServer});

  final ManagedContext managedContext;
  final AuthServer authServer;

  @Operation.post()
  Future<Response> createUser(@Bind.body(ignore: ['token']) UserModel userModel) async {
    print(userModel.toString());

    if (userModel.username == null || userModel.password == null) {
      return Response.badRequest(
          body: {"error": "username and password required."});
    }

    userModel
      ..salt = AuthUtility.generateRandomSalt()
      ..hashedPassword = authServer.hashPassword(userModel.password, userModel.salt);

    return Response.ok(await Query(managedContext, values: userModel).insert());
  }
}