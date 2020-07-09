import 'dart:convert';
import 'dart:io';

import 'package:mobx/mobx.dart';

part 'category_crud_store.g.dart';

/// flutter packages pub run build_runner build
/// flutter packages pub run build_runner build --delete-conflicting-outputs
/// flutter packages pub run build_runner watch

class CategoryCRUDPageStore = _CategoryCRUDPageStore
    with _$CategoryCRUDPageStore;

abstract class _CategoryCRUDPageStore with Store {
  @observable
  String _name = '';

  @observable
  File _image;

  @observable
  String _imageBase64;

  @observable
  String _urlToDownloadImage;

  @observable
  bool _isProcessing = false;

  @computed
  String get name => _name;

  @computed
  File get file => _image;

  @computed
  String get imageBase64 => _imageBase64;

  @computed
  String get urlToDownloadImage => _urlToDownloadImage;

  @computed
  bool get isAValidName => _name.trim().length > 0;

  @computed
  bool get isAValidForm =>
      isAValidName && (_imageBase64 != null || _urlToDownloadImage != null);

  @computed
  bool get isProcessing => _isProcessing;

  @action
  updateName({String newName}) {
    _name = newName;
  }

  @action
  updateImage({String path}) {
    if (path != null) {
      _image = File(path);
      updateImageBase64(newImageBase64: base64Encode(_image.readAsBytesSync()));
    } else {
      _image = null;
      updateImageBase64(newImageBase64: null);
    }
  }

  @action
  updateFile({File file}) {
    _image = file;
    updateImageBase64(newImageBase64: base64Encode(_image.readAsBytesSync()));
  }

  @action
  updateUrlToDownloadImage({String newUrlImage}) {
    _urlToDownloadImage = newUrlImage;
  }

  @action
  updateImageBase64({String newImageBase64}) {
    _imageBase64 = newImageBase64;
  }

  @action
  updateIsProcessing({bool newValue}) {
    _isProcessing = newValue;
  }
}
