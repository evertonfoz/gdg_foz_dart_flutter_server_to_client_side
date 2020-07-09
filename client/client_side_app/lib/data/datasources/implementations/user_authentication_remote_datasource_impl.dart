import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gdgfoz/core/error/gdg_http_exception.dart';
import 'package:gdgfoz/data/datasources/interfaces/i_user_authentication_remote_datasource.dart';
import 'package:gdgfoz/data/datasources/services_client.dart';
import 'package:gdgfoz/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserAuthenticationRemoteDataSourceImpl
    implements IUserAuthenticationRemoteDataSource {
  final String categoriesBaseUrl = '$kBaseUrl/categories';
  final clientID = "com.gdgfoz";

  @override
  Future<String> getToken({UserModel userModel}) async {
    final body =
        "username=${userModel.username}&password=${userModel.password}&grant_type=password";

    final String clientCredentials =
        const Base64Encoder().convert("$clientID:".codeUnits);

    http.Response response = await servicesClient.post("$kBaseUrl/auth/token",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Basic $clientCredentials"
        },
        body: body);

    if (response.statusCode == 200) return _getToken(bodyResult: response.body);

    int errorCode = response.statusCode;
    if (response.statusCode == 400 &&
        response.body.toString().toLowerCase().contains('invalid_grant'))
      errorCode = 403;

    throw GdgHttpException(GdgHttpException.getErrorMessage(errorCode));
  }

  Future<String> register({UserModel userModel}) async {
    http.Response response = await servicesClient.post(
      "$kBaseUrl/register",
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userModel.toJson()),
    );

    if (response.statusCode == 200) return _getToken(bodyResult: response.body);

    throw GdgHttpException(
        GdgHttpException.getErrorMessage(response.statusCode));
  }

  String _getToken({@required bodyResult}) {
    var jsonBodyResult = json.decode(bodyResult);
    return jsonBodyResult["access_token"];
  }
}
