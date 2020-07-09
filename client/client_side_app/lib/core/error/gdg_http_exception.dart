import 'package:dialog_information_to_specific_platform/flat_buttons/actions_flatbutton_to_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gdgfoz/presentation/widgets/functions_to_generate_widgets/gdg_show_dialog.dart';

class GdgHttpException implements Exception {
  final String message;

  GdgHttpException(this.message);

  static final Map<int, String> statusCodeResponses = {
    400:
        'Ocorreu um erro na comunicação com o servidor. Verifique sua conexão com a internet e tente novamente.',
    401: 'Falha na autorização. Verifique usuário e senha e tente novamente.',
    403: 'Falha na autenticação, verifique usuário e senha e tente novamente.',
    404: 'O recurso requisitado não existe. Verifique os valores informados.',
    409:
        'Há conflito nos dados informados. Possivelmente o email já esteja registrado.'
  };

  static String getErrorMessage(int statusCode) {
    if (statusCodeResponses.containsKey(statusCode)) {
      return statusCodeResponses[statusCode];
    }
    return 'Erro desconhecido.';
  }

  static Future showDialogToFailure(
      {BuildContext context, String message = 'Erro desconhecido'}) {
    return gdgDialog(
        context: context,
        iconTitle: Icon(
          Icons.error,
          color: Colors.red[900],
        ),
        title: 'Erro',
        subTitle: message,
        buttons: [
          ActionsFlatButtonToAlertDialog(
            messageButton: 'OK',
          ),
        ]);
  }

  static String httpInterceptorExceptionMessage({@required message}) {
    String exceptionMessage = message;
    if (message.toLowerCase().contains('timeoutexception '))
      exceptionMessage =
          'Houve uma demora na resposta do servidor. Verifique sua conexão e tente novamente';
    return exceptionMessage;
  }
}
