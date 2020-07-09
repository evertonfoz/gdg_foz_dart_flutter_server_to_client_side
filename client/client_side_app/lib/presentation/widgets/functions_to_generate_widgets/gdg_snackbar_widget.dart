import 'package:flutter/material.dart';

class GDGSnackBarWidget {
  GDGSnackBarWidget._();

  static generateSnackBar(
      {BuildContext context,
      String message,
      Color backgroundColor,
      bool popNavigation = false}) {
    Scaffold.of(context)
        .showSnackBar(
          SnackBar(
            content: Text('$message'),
            duration: Duration(seconds: 2),
            backgroundColor: backgroundColor,
          ),
        )
        .closed
        .then((value) {
      if (popNavigation) Navigator.of(context).pop();
    });
  }
}
