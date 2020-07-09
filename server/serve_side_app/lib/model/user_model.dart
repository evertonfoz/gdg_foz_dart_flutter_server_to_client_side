import 'package:aqueduct/managed_auth.dart';
import 'package:serve_side_app/serve_side_app.dart';

class UserModel extends ManagedObject<_UserModel>
    implements _UserModel, ManagedAuthResourceOwner<_UserModel> {
  @Serialize(input: true, output: false)
  String password;
}

class _UserModel extends ResourceOwnerTableDefinition {
//  @primaryKey
//  int id;
//
//  @Column(unique: true, indexed: true)
//  String username;
//
//  @Column(omitByDefault: true)
//  String hashedPassword;
//
//  @Column(omitByDefault: true)
//  String salt;
//
//  ManagedSet<ManagedAuthToken> tokens;
}