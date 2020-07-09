import 'package:flutter/material.dart';
import 'package:gdgfoz/core/app_router.dart';
import 'package:gdgfoz/presentation/pages/authentication/login_page.dart';
//import 'package:http/http.dart' as http;

void main() {
//  var rest = CategoryModelRemoteDataSourceImpl();
//  rest.getAllCategories().then((value) {
//    value.forEach((element) {
//      print(element);
//    });
//  });

//  const clientID = "com.gdgfoz";
//  const body = "username=bob&password=password&grant_type=password";
//
//  final String clientCredentials =
//      const Base64Encoder().convert("$clientID:".codeUnits);
//
//  http
//      .post("$kUrl/auth/token",
//          headers: {
//            "Content-Type": "application/x-www-form-urlencoded",
//            "Authorization": "Basic $clientCredentials"
//          },
//          body: body)
//      .then((http.Response response) {
//    print('responde.body ${response.body}');
//  });

  runApp(GdgFozApp());
}

class GdgFozApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GDG Foz',
      onGenerateRoute: AppRouter.generateRoute,
      home: LoginPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
