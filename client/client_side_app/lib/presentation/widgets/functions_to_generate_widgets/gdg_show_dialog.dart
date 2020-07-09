import 'package:dialog_information_to_specific_platform/dialog_information_to_specific_platform.dart';
import 'package:dialog_information_to_specific_platform/flat_buttons/actions_flatbutton_to_alert_dialog.dart';
import 'package:flutter/material.dart';

Future gdgDialog(
    {BuildContext context,
    Icon iconTitle,
    String title,
    String subTitle,
    List<ActionsFlatButtonToAlertDialog> buttons}) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    child: InformationAlertDialog(
      iconTitle: iconTitle,
      title: title,
      message: subTitle,
      buttons: buttons,
    ),
  );
}
