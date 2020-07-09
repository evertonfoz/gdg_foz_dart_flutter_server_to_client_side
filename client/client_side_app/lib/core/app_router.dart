import 'package:flutter/material.dart';
import 'package:gdgfoz/core/constants.dart';
import 'package:gdgfoz/presentation/pages/authentication/login_page.dart';
import 'package:gdgfoz/presentation/pages/authentication/register_page.dart';
import 'package:gdgfoz/presentation/pages/categories/category_crud_page.dart';
import 'package:gdgfoz/presentation/pages/categories/category_list_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case kCategoryListRoute:
        return MaterialPageRoute(builder: (_) => CategoryListPage());
      case kLoginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case kRegisterRoute:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case kCRUDRoute:
        return MaterialPageRoute(
          builder: (_) => CategoryCRUDPage(
            categoryID: settings.arguments,
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
