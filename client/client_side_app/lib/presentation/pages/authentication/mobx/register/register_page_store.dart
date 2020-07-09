import 'package:mobx/mobx.dart';

part 'register_page_store.g.dart';

/// flutter packages pub run build_runner build
/// flutter packages pub run build_runner build --delete-conflicting-outputs
/// flutter packages pub run build_runner watch

class RegisterPageStore = _RegisterPageStore with _$RegisterPageStore;

abstract class _RegisterPageStore with Store {
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';

  @observable
  bool isProcessing = false;

  @computed
  bool get isAValidEmail {
    if (email.trim().length == 0) return false;

    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (regex.hasMatch(email));
  }

  @computed
  bool get isAValidPassword => password.trim().length > 0;

  @computed
  bool get isAValidConfirmPassword =>
      isAValidPassword && password == confirmPassword;

  @computed
  bool get isAValidForm =>
      (isAValidEmail && isAValidPassword && isAValidConfirmPassword);

  @action
  updateEmail({String newValue}) {
    email = newValue;
  }

  @action
  updatePassword({String newValue}) {
    password = newValue;
  }

  @action
  updateConfirmPassword({String newValue}) {
    confirmPassword = newValue;
  }

  @action
  updateIsProcessing({bool newValue}) {
    isProcessing = newValue;
  }
}
