// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_crud_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoryCRUDPageStore on _CategoryCRUDPageStore, Store {
  Computed<String> _$nameComputed;

  @override
  String get name => (_$nameComputed ??= Computed<String>(() => super.name,
          name: '_CategoryCRUDPageStore.name'))
      .value;
  Computed<File> _$fileComputed;

  @override
  File get file => (_$fileComputed ??=
          Computed<File>(() => super.file, name: '_CategoryCRUDPageStore.file'))
      .value;
  Computed<String> _$imageBase64Computed;

  @override
  String get imageBase64 =>
      (_$imageBase64Computed ??= Computed<String>(() => super.imageBase64,
              name: '_CategoryCRUDPageStore.imageBase64'))
          .value;
  Computed<String> _$urlToDownloadImageComputed;

  @override
  String get urlToDownloadImage => (_$urlToDownloadImageComputed ??=
          Computed<String>(() => super.urlToDownloadImage,
              name: '_CategoryCRUDPageStore.urlToDownloadImage'))
      .value;
  Computed<bool> _$isAValidNameComputed;

  @override
  bool get isAValidName =>
      (_$isAValidNameComputed ??= Computed<bool>(() => super.isAValidName,
              name: '_CategoryCRUDPageStore.isAValidName'))
          .value;
  Computed<bool> _$isAValidFormComputed;

  @override
  bool get isAValidForm =>
      (_$isAValidFormComputed ??= Computed<bool>(() => super.isAValidForm,
              name: '_CategoryCRUDPageStore.isAValidForm'))
          .value;
  Computed<bool> _$isProcessingComputed;

  @override
  bool get isProcessing =>
      (_$isProcessingComputed ??= Computed<bool>(() => super.isProcessing,
              name: '_CategoryCRUDPageStore.isProcessing'))
          .value;

  final _$_nameAtom = Atom(name: '_CategoryCRUDPageStore._name');

  @override
  String get _name {
    _$_nameAtom.reportRead();
    return super._name;
  }

  @override
  set _name(String value) {
    _$_nameAtom.reportWrite(value, super._name, () {
      super._name = value;
    });
  }

  final _$_imageAtom = Atom(name: '_CategoryCRUDPageStore._image');

  @override
  File get _image {
    _$_imageAtom.reportRead();
    return super._image;
  }

  @override
  set _image(File value) {
    _$_imageAtom.reportWrite(value, super._image, () {
      super._image = value;
    });
  }

  final _$_imageBase64Atom = Atom(name: '_CategoryCRUDPageStore._imageBase64');

  @override
  String get _imageBase64 {
    _$_imageBase64Atom.reportRead();
    return super._imageBase64;
  }

  @override
  set _imageBase64(String value) {
    _$_imageBase64Atom.reportWrite(value, super._imageBase64, () {
      super._imageBase64 = value;
    });
  }

  final _$_urlToDownloadImageAtom =
      Atom(name: '_CategoryCRUDPageStore._urlToDownloadImage');

  @override
  String get _urlToDownloadImage {
    _$_urlToDownloadImageAtom.reportRead();
    return super._urlToDownloadImage;
  }

  @override
  set _urlToDownloadImage(String value) {
    _$_urlToDownloadImageAtom.reportWrite(value, super._urlToDownloadImage, () {
      super._urlToDownloadImage = value;
    });
  }

  final _$_isProcessingAtom =
      Atom(name: '_CategoryCRUDPageStore._isProcessing');

  @override
  bool get _isProcessing {
    _$_isProcessingAtom.reportRead();
    return super._isProcessing;
  }

  @override
  set _isProcessing(bool value) {
    _$_isProcessingAtom.reportWrite(value, super._isProcessing, () {
      super._isProcessing = value;
    });
  }

  final _$_CategoryCRUDPageStoreActionController =
      ActionController(name: '_CategoryCRUDPageStore');

  @override
  dynamic updateName({String newName}) {
    final _$actionInfo = _$_CategoryCRUDPageStoreActionController.startAction(
        name: '_CategoryCRUDPageStore.updateName');
    try {
      return super.updateName(newName: newName);
    } finally {
      _$_CategoryCRUDPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateImage({String path}) {
    final _$actionInfo = _$_CategoryCRUDPageStoreActionController.startAction(
        name: '_CategoryCRUDPageStore.updateImage');
    try {
      return super.updateImage(path: path);
    } finally {
      _$_CategoryCRUDPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateFile({File file}) {
    final _$actionInfo = _$_CategoryCRUDPageStoreActionController.startAction(
        name: '_CategoryCRUDPageStore.updateFile');
    try {
      return super.updateFile(file: file);
    } finally {
      _$_CategoryCRUDPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateUrlToDownloadImage({String newUrlImage}) {
    final _$actionInfo = _$_CategoryCRUDPageStoreActionController.startAction(
        name: '_CategoryCRUDPageStore.updateUrlToDownloadImage');
    try {
      return super.updateUrlToDownloadImage(newUrlImage: newUrlImage);
    } finally {
      _$_CategoryCRUDPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateImageBase64({String newImageBase64}) {
    final _$actionInfo = _$_CategoryCRUDPageStoreActionController.startAction(
        name: '_CategoryCRUDPageStore.updateImageBase64');
    try {
      return super.updateImageBase64(newImageBase64: newImageBase64);
    } finally {
      _$_CategoryCRUDPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateIsProcessing({bool newValue}) {
    final _$actionInfo = _$_CategoryCRUDPageStoreActionController.startAction(
        name: '_CategoryCRUDPageStore.updateIsProcessing');
    try {
      return super.updateIsProcessing(newValue: newValue);
    } finally {
      _$_CategoryCRUDPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
file: ${file},
imageBase64: ${imageBase64},
urlToDownloadImage: ${urlToDownloadImage},
isAValidName: ${isAValidName},
isAValidForm: ${isAValidForm},
isProcessing: ${isProcessing}
    ''';
  }
}
