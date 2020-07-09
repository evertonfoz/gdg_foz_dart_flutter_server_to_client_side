// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginPageStore on _LoginPageStore, Store {
  Computed<bool> _$isAValidEmailComputed;

  @override
  bool get isAValidEmail =>
      (_$isAValidEmailComputed ??= Computed<bool>(() => super.isAValidEmail,
              name: '_LoginPageStore.isAValidEmail'))
          .value;
  Computed<bool> _$isAValidPasswordComputed;

  @override
  bool get isAValidPassword => (_$isAValidPasswordComputed ??= Computed<bool>(
          () => super.isAValidPassword,
          name: '_LoginPageStore.isAValidPassword'))
      .value;
  Computed<bool> _$isAValidFormComputed;

  @override
  bool get isAValidForm =>
      (_$isAValidFormComputed ??= Computed<bool>(() => super.isAValidForm,
              name: '_LoginPageStore.isAValidForm'))
          .value;

  final _$emailAtom = Atom(name: '_LoginPageStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginPageStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$isProcessingAtom = Atom(name: '_LoginPageStore.isProcessing');

  @override
  bool get isProcessing {
    _$isProcessingAtom.reportRead();
    return super.isProcessing;
  }

  @override
  set isProcessing(bool value) {
    _$isProcessingAtom.reportWrite(value, super.isProcessing, () {
      super.isProcessing = value;
    });
  }

  final _$_LoginPageStoreActionController =
      ActionController(name: '_LoginPageStore');

  @override
  dynamic updateEmail({String newValue}) {
    final _$actionInfo = _$_LoginPageStoreActionController.startAction(
        name: '_LoginPageStore.updateEmail');
    try {
      return super.updateEmail(newValue: newValue);
    } finally {
      _$_LoginPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updatePassword({String newValue}) {
    final _$actionInfo = _$_LoginPageStoreActionController.startAction(
        name: '_LoginPageStore.updatePassword');
    try {
      return super.updatePassword(newValue: newValue);
    } finally {
      _$_LoginPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateIsProcessing({bool newValue}) {
    final _$actionInfo = _$_LoginPageStoreActionController.startAction(
        name: '_LoginPageStore.updateIsProcessing');
    try {
      return super.updateIsProcessing(newValue: newValue);
    } finally {
      _$_LoginPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
isProcessing: ${isProcessing},
isAValidEmail: ${isAValidEmail},
isAValidPassword: ${isAValidPassword},
isAValidForm: ${isAValidForm}
    ''';
  }
}
