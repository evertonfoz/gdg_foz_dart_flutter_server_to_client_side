import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user_model.g.dart';

/// flutter packages pub run build_runner build

@JsonSerializable()
class UserModel {
  final String username;
  final String password;
  String token;

  UserModel({@required this.username, @required this.password, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserName: $username';
  }
}
