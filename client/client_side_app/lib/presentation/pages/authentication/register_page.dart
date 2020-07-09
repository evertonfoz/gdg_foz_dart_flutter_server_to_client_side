import 'dart:async';

import 'package:dialog_information_to_specific_platform/flat_buttons/actions_flatbutton_to_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gdgfoz/core/error/gdg_http_exception.dart';
import 'package:gdgfoz/data/datasources/implementations/user_authentication_remote_datasource_impl.dart';
import 'package:gdgfoz/data/models/user_model.dart';
import 'package:gdgfoz/presentation/pages/authentication/mobx/register/register_page_store.dart';
import 'package:gdgfoz/presentation/widgets/error_message_widget.dart';
import 'package:gdgfoz/presentation/widgets/functions_to_generate_widgets/gdg_show_dialog.dart';
import 'package:http_interceptor/http_interceptor.dart';

class RegisterPage extends StatelessWidget {
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmPasswordNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _registerPageStore = RegisterPageStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[500],
        title: Text('Área de registro'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Observer(builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: !_registerPageStore.isProcessing,
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        focusNode: _emailNode,
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          hintText: 'Informe o email',
                        ),
                        onChanged: (value) =>
                            _registerPageStore.updateEmail(newValue: value),
                      ),
                      Observer(builder: (_) {
                        return Visibility(
                          visible: !_registerPageStore.isAValidEmail,
                          child: ErrorMessageWidget(
                              message: 'Um email correto é obrigatório'),
                        );
                      }),
                      TextField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        focusNode: _passwordNode,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.security,
                          ),
                          hintText: 'Informe a senha',
                        ),
                        onChanged: (value) =>
                            _registerPageStore.updatePassword(newValue: value),
                      ),
                      Observer(builder: (_) {
                        return Visibility(
                          visible: !_registerPageStore.isAValidPassword,
                          child: ErrorMessageWidget(
                              message: 'A senha é obrigatória'),
                        );
                      }),
                      TextField(
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        focusNode: _confirmPasswordNode,
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.security,
                          ),
                          hintText: 'Confirme a senha',
                        ),
                        onChanged: (value) => _registerPageStore
                            .updateConfirmPassword(newValue: value),
                      ),
                      Observer(builder: (_) {
                        return Visibility(
                          visible: !_registerPageStore.isAValidConfirmPassword,
                          child: ErrorMessageWidget(
                              message:
                                  'A senha e sua confirmação devem ser iguais'),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Observer(builder: (_) {
                              return RaisedButton(
                                child: Text('Registrar'),
                                onPressed: _onPressedParaBotaoRegistrar(
                                    context: context),
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _registerPageStore.isProcessing,
                  child: Center(
                    child: Column(
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Processando...'),
                      ],
                    ),
                  ),
                )
              ],
            );
          })),
    );
  }

  _onPressedParaBotaoRegistrar({BuildContext context}) {
    if (_registerPageStore.isAValidForm) {
      return () async {
        UserAuthenticationRemoteDataSourceImpl _authenticationService =
            UserAuthenticationRemoteDataSourceImpl();
        try {
          _registerPageStore.updateIsProcessing(newValue: true);
          await _authenticationService
              .register(
                  userModel: UserModel(
                      username: _registerPageStore.email,
                      password: _registerPageStore.password))
              .whenComplete(
                  () => _registerPageStore.updateIsProcessing(newValue: false));

          await _showDialogToSuccess(context: context);
          Navigator.of(context).pop();
        } on GdgHttpException catch (e) {
          _showDialogToFailure(context: context, message: e.message);
        } on HttpInterceptorException catch (e) {
          String exceptionMessage = e.toString();
          if (e.toString().toLowerCase().contains('timeoutexception '))
            exceptionMessage =
                'Houve uma demora na resposta do servidor. Verifique sua conexão e tente novamente';

          _showDialogToFailure(context: context, message: exceptionMessage);
        }
      };
    }
    return null;
  }

  Future _showDialogToFailure(
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

  Future _showDialogToSuccess({BuildContext context}) {
    return gdgDialog(
        context: context,
        iconTitle: Icon(
          Icons.check,
          color: Colors.green[900],
        ),
        title: 'Sucesso',
        subTitle: 'Usuário registrado com sucesso',
        buttons: [
          ActionsFlatButtonToAlertDialog(
            messageButton: 'OK',
          ),
        ]);
  }
}
