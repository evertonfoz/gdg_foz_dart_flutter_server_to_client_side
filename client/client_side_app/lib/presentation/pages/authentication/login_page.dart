import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gdgfoz/core/constants.dart';
import 'package:gdgfoz/core/error/gdg_http_exception.dart';
import 'package:gdgfoz/data/datasources/implementations/user_authentication_remote_datasource_impl.dart';
import 'package:gdgfoz/data/models/user_model.dart';
import 'package:gdgfoz/presentation/pages/authentication/mobx/login/login_page_store.dart';
import 'package:gdgfoz/presentation/widgets/error_message_widget.dart';
import 'package:gdgfoz/presentation/widgets/progress_indicator_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoginPage extends StatelessWidget {
  final FocusNode _emailNode = FocusNode();
  final FocusNode _senhaNode = FocusNode();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _loginPageStore = LoginPageStore();

  _emailInput({@required BuildContext context}) {
    return Column(
      children: [
        TextField(
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          controller: _emailController,
          onSubmitted: (_) => FocusScope.of(context).nextFocus(),
          focusNode: _emailNode,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email,
            ),
            hintText: 'Informe o email',
          ),
          // Atualizar onChanged do TextField de email
          onChanged: (value) => _loginPageStore.updateEmail(newValue: value),
        ),
        Observer(builder: (_) {
          return Visibility(
            visible: !_loginPageStore.isAValidEmail,
            child:
                ErrorMessageWidget(message: 'Um email correto é obrigatório'),
          );
        }),
      ],
    );
  }

  _passwordInput({@required BuildContext context}) {
    return Column(
      children: [
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
          onChanged: (value) => _loginPageStore.updatePassword(newValue: value),
        ),
        Observer(builder: (_) {
          return Visibility(
            visible: !_loginPageStore.isAValidPassword,
            child: ErrorMessageWidget(message: 'A senha é obrigatória'),
          );
        }),
      ],
    );
  }

  _buttonsForm({@required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FlatButton(
          child: Text('Registre-se'),
          color: Colors.green[500],
          onPressed: () => Navigator.of(context).pushNamed(kRegisterRoute),
        ),
        Observer(builder: (_) {
          return RaisedButton(
            color: Colors.indigo,
            textColor: Colors.white,
            child: Text('Acessar'),
            onPressed: _onPressedParaBotaoAcessar(
              context: context,
              userModel: UserModel(
                  username: _loginPageStore.email,
                  password: _loginPageStore.password),
            ),
          );
        }),
      ],
    );
  }

  _loginForm({@required BuildContext context}) {
    return Visibility(
      visible: !_loginPageStore.isProcessing,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            _emailInput(context: context),
            _passwordInput(context: context),
            SizedBox(height: 15),
            _buttonsForm(context: context),
          ],
        ),
      ),
    );
  }

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
              _loginForm(context: context),
              Visibility(
                visible: _loginPageStore.isProcessing,
                child: ProgressIndicatorWidget(text: 'Processando...'),
              ),
            ],
          );
        },
      ),
    );
  }

  _onPressedParaBotaoAcessar(
      {@required BuildContext context, @required UserModel userModel}) {
    if (_loginPageStore.isAValidForm) {
      return () async {
        try {
          UserAuthenticationRemoteDataSourceImpl _authenticationService =
              UserAuthenticationRemoteDataSourceImpl();

          _loginPageStore.updateIsProcessing(newValue: true);

          userModel.token = await _authenticationService
              .getToken(userModel: userModel)
              .whenComplete(
                  () => _loginPageStore.updateIsProcessing(newValue: false));

          GetIt.I.registerSingleton<UserModel>(userModel);
          Navigator.pushNamed(context, kCategoryListRoute);
        } on GdgHttpException catch (e) {
          await GdgHttpException.showDialogToFailure(
              context: context, message: e.message);
        } on HttpInterceptorException catch (e) {
          await GdgHttpException.showDialogToFailure(
              context: context,
              message: GdgHttpException.httpInterceptorExceptionMessage(
                  message: e.toString()));
        }
      };
    }
    return null;
  }
}
