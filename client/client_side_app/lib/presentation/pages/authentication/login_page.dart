import 'package:dialog_information_to_specific_platform/flat_buttons/actions_flatbutton_to_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gdgfoz/core/constants.dart';
import 'package:gdgfoz/core/error/gdg_http_exception.dart';
import 'package:gdgfoz/data/datasources/implementations/user_authentication_remote_datasource_impl.dart';
import 'package:gdgfoz/data/models/user_model.dart';
import 'package:gdgfoz/presentation/pages/authentication/mobx/login/login_page_store.dart';
import 'package:gdgfoz/presentation/widgets/error_message_widget.dart';
import 'package:gdgfoz/presentation/widgets/functions_to_generate_widgets/gdg_show_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoginPage extends StatelessWidget {
  final FocusNode _emailNode = FocusNode();
  final FocusNode _senhaNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _loginPageStore = LoginPageStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acessar área restrita'),
      ),
      body: Observer(
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !_loginPageStore.isProcessing,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: _emailController,
                            onSubmitted: (_) =>
                                FocusScope.of(context).nextFocus(),
                            focusNode: _emailNode,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                              hintText: 'Informe o email',
                            ),
                            // Atualizar onChanged do TextField de email
                            onChanged: (value) =>
                                _loginPageStore.updateEmail(newValue: value),
                          ),
                          Observer(builder: (_) {
                            return Visibility(
                              visible: !_loginPageStore.isAValidEmail,
                              child: ErrorMessageWidget(
                                  message: 'Um email correto é obrigatório'),
                            );
                          }),
                          TextField(
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            focusNode: _senhaNode,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.security,
                              ),
                              hintText: 'Informe a senha',
                            ),
                            onChanged: (value) =>
                                _loginPageStore.updatePassword(newValue: value),
                          ),
                          Observer(builder: (_) {
                            return Visibility(
                              visible: !_loginPageStore.isAValidPassword,
                              child: ErrorMessageWidget(
                                  message: 'A senha é obrigatória'),
                            );
                          }),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                FlatButton(
                                  child: Text('Registre-se'),
                                  color: Colors.green[500],
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(kRegisterRoute),
                                ),
                                Observer(builder: (_) {
                                  return RaisedButton(
                                    color: Colors.indigo,
                                    textColor: Colors.white,
                                    child: Text('Acessar'),
                                    onPressed: _onPressedParaBotaoAcessar(
                                        context: context),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _loginPageStore.isProcessing,
                child: Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Processando...'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _onPressedParaBotaoAcessar({BuildContext context}) {
    if (_loginPageStore.isAValidForm) {
      return () async {
        UserAuthenticationRemoteDataSourceImpl _authenticationService =
            UserAuthenticationRemoteDataSourceImpl();
        try {
          _loginPageStore.updateIsProcessing(newValue: true);
          UserModel userModel = UserModel(
              username: _loginPageStore.email,
              password: _loginPageStore.password);
          String token = await _authenticationService
              .getToken(userModel: userModel)
              .whenComplete(() {
            return _loginPageStore.updateIsProcessing(newValue: false);
          });

          userModel.token = token;
          GetIt.I.registerSingleton<UserModel>(userModel);

          Navigator.pushNamed(context, kCategoryListRoute);
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
}
