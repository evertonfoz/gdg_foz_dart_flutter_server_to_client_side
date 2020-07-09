// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterPageStore on _RegisterPageStore, Store {
  Computed<bool> _$isAValidEmailComputed;

  @override
  bool get isAValidEmail =>
      (_$isAValidEmailComputed ??= Computed<bool>(() => super.isAValidEmail,
              name: '_RegisterPageStore.isAValidEmail'))
          .value;
  Computed<bool> _$isAValidPasswordComputed;

  @override
  bool get isAValidPassword => (_$isAValidPasswordComputed ??= Computed<bool>(
          () => super.isAValidPassword,
          name: '_RegisterPageStore.isAValidPassword'))
      .value;
  Computed<bool> _$isAValidConfirmPasswordComputed;

  @override
  bool get isAValidConfirmPassword => (_$isAValidConfirmPasswordComputed ??=
          Computed<bool>(() => super.isAValidConfirmPassword,
              name: '_RegisterPageStore.isAValidConfirmPassword'))
      .value;
  Computed<bool> _$isAValidFormComputed;

  @override
  bool get isAValidForm =>
      (_$isAValidFormComputed ??= Computed<bool>(() => super.isAValidForm,
              name: '_RegisterPageStore.isAValidForm'))
          .value;

  final _$emailAtom = Atom(name: '_RegisterPageStore.email');

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

  final _$passwordAtom = Atom(name: '_RegisterPageStore.password');

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

  final _$confirmPasswordAtom =
      Atom(name: '_RegisterPageStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$isProcessingAtom = Atom(name: '_RegisterPageStore.isProcessing');

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

  final _$_RegisterPageStoreActionController =
      ActionController(name: '_RegisterPageStore');

  @override
  dynamic updateEmail({String newValue}) {
    final _$actionInfo = _$_RegisterPageStoreActionController.startAction(
        name: '_RegisterPageStore.updateEmail');
    try {
      return super.updateEmail(newValue: newValue);
    } finally {
      _$_RegisterPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updatePassword({String newValue}) {
    final _$actionInfo = _$_RegisterPageStoreActionController.startAction(
        name: '_RegisterPageStore.updatePassword');
    try {
      return super.updatePassword(newValue: newValue);
    } finally {
      _$_RegisterPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateConfirmPassword({String newValue}) {
    final _$actionInfo = _$_RegisterPageStoreActionController.startAction(
        name: '_RegisterPageStore.updateConfirmPassword');
    try {
      return super.updateConfirmPassword(newValue: newValue);
    } finally {
      _$_RegisterPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateIsProcessing({bool newValue}) {
    final _$actionInfo = _$_RegisterPageStoreActionController.startAction(
        name: '_RegisterPageStore.updateIsProcessing');
    try {
      return super.updateIsProcessing(newValue: newValue);
    } finally {
      _$_RegisterPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
confirmPassword: ${confirmPassword},
isProcessing: ${isProcessing},
isAValidEmail: ${isAValidEmail},
isAValidPassword: ${isAValidPassword},
isAValidConfirmPassword: ${isAValidConfirmPassword},
isAValidForm: ${isAValidForm}
    ''';
  }
}
