import 'dart:convert';

import 'package:dialog_information_to_specific_platform/flat_buttons/actions_flatbutton_to_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gdgfoz/core/error/gdg_http_exception.dart';
import 'package:gdgfoz/data/datasources/implementations/category_remote_datasource_impl.dart';
import 'package:gdgfoz/data/models/category_model.dart';
import 'package:gdgfoz/presentation/pages/categories/mobx/category_crud_store.dart';
import 'package:gdgfoz/presentation/widgets/error_message_widget.dart';
import 'package:gdgfoz/presentation/widgets/functions_to_generate_widgets/gdg_show_dialog.dart';
import 'package:gdgfoz/presentation/widgets/functions_to_generate_widgets/gdg_snackbar_widget.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:image_picker/image_picker.dart';

class CategoryCRUDWidget extends StatelessWidget {
  final CategoryModel category;

  CategoryCRUDWidget({this.category});

  final _categoryCrudPageStore = CategoryCRUDPageStore();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlImageController = TextEditingController(
      text:
          'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png');

  BuildContext buildContext;

  /// Form Widgets Generators
  _categoryTextField() {
    return TextField(
      controller: _nameController,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.description,
        ),
        hintText: 'Informe a descrição',
      ),
      onChanged: (value) => _categoryCrudPageStore.updateName(newName: value),
    );
  }

  _messageErrorToCategoryTextField() {
    return Observer(builder: (_) {
      return Visibility(
        visible: !_categoryCrudPageStore.isAValidName,
        child: ErrorMessageWidget(
          message: 'a descrição é obrigatória',
        ),
      );
    });
  }

  _imageToFrame() {
    return Observer(builder: (_) {
      if (_categoryCrudPageStore.imageBase64 == null)
        return CircleAvatar(
          radius: 85,
          backgroundImage: AssetImage('assets/images/noPhotoAvailable.jpg'),
        );
      return CircleAvatar(
        radius: 85,
        backgroundImage: MemoryImage(
            base64Decode(_categoryCrudPageStore.imageBase64.split(',').last)),
      );
    });
  }

  _frameToPhoto() {
    return Container(
      height: 200,
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 45,
            child: InkWell(
              onLongPress: _getImage,
              child: _imageToFrame(),
            ),
          ),
        ),
      ),
    );
  }

  _urlToImageTextField() {
    return TextField(
      controller: _urlImageController,
      decoration: InputDecoration(
        prefixIcon: InkWell(
          child: Icon(
            Icons.image,
          ),
        ),
        suffixIcon: InkWell(
            onTap: () async => await _downloadImage(context: buildContext),
            child: Icon(Icons.file_download)),
        hintText: 'Informe a URL para a imagem',
      ),
      onChanged: (value) =>
          _categoryCrudPageStore.updateUrlToDownloadImage(newUrlImage: value),
    );
  }

  _messageErrorToUrlToImageTextField() {
    return Observer(builder: (_) {
      return Visibility(
        visible: _categoryCrudPageStore.imageBase64 == null,
        child: ErrorMessageWidget(
          message: 'A imagem é obrigatória, do dispositivo ou web',
        ),
      );
    });
  }

  Widget _raisedButton() {
    return Builder(builder: (context) {
      return Observer(builder: (_) {
//        print(_categoryCrudPageStore.imageBase64);
        return RaisedButton(
          color: Colors.blueAccent,
          textColor: Colors.white,
          child: Text('Gravar'),
          onPressed: !_categoryCrudPageStore.isAValidForm
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  try {
                    var insertedCategory =
                        await _saveCategory(context: context);
                    _resetForm();
                    _snackBar(
                        context: context, insertedCategory: insertedCategory);
                  } on GdgHttpException catch (e) {
                    _showDialogToFailure(context: context, message: e.message);
                  } on HttpInterceptorException catch (e) {
                    String exceptionMessage = e.toString();
                    if (e
                        .toString()
                        .toLowerCase()
                        .contains('timeoutexception '))
                      exceptionMessage =
                          'Houve uma demora na resposta do servidor. Verifique sua conexão e tente novamente';

                    _showDialogToFailure(
                        context: context, message: exceptionMessage);
                  } finally {
                    _categoryCrudPageStore.updateIsProcessing(newValue: false);
                  }
                },
        );
      });
    });
  }

  _generateForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _categoryTextField(),
          _messageErrorToCategoryTextField(),
          SizedBox(height: 10),
          _frameToPhoto(),
          _urlToImageTextField(),
          _messageErrorToUrlToImageTextField(),
          SizedBox(height: 15),
          _raisedButton(),
        ],
      ),
    );
  }

  _processingMessage() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 20,
          ),
          Text('Aguarde...'),
        ],
      ),
    );
  }

  /// Get image to form
  Future _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _categoryCrudPageStore.updateImage(path: pickedFile.path);
  }

  Future _downloadImage({BuildContext context}) async {
    FocusScope.of(context).unfocus();
    _categoryCrudPageStore.updateIsProcessing(newValue: true);
    CategoryModelRemoteDataSourceImpl service =
        CategoryModelRemoteDataSourceImpl();

    try {
      var downloadImage = await service.downloadImage(
          url: _categoryCrudPageStore.urlToDownloadImage);
      _categoryCrudPageStore.updateFile(file: downloadImage);
    } on GdgHttpException catch (e) {
      _showDialogToFailure(context: context, message: e.message);
    } on HttpInterceptorException catch (e) {
      String exceptionMessage = e.toString();
      if (e.toString().toLowerCase().contains('timeoutexception '))
        exceptionMessage =
            'Houve uma demora na resposta do servidor. Verifique sua conexão e tente novamente';

      _showDialogToFailure(context: context, message: exceptionMessage);
    } finally {
      _categoryCrudPageStore.updateIsProcessing(newValue: false);
    }
  }

  /// Save and reset data form
  Future<CategoryModel> _saveCategory({BuildContext context}) async {
    CategoryModelRemoteDataSourceImpl service =
        CategoryModelRemoteDataSourceImpl();

    if (this.category == null)
      return await service.add(
          categoryModel: CategoryModel(
              name: _categoryCrudPageStore.name,
              imageBase64: _categoryCrudPageStore.imageBase64));
    return await service.update(
      categoryModel: CategoryModel(
          categoryID: category.categoryID,
          name: _categoryCrudPageStore.name,
          imageBase64: _categoryCrudPageStore.imageBase64),
    );
  }

  void _resetForm() {
    if (category == null) {
      _categoryCrudPageStore.updateName(newName: '');
      _categoryCrudPageStore.updateImage(path: null);
      _nameController.clear();
    }
  }

  void _snackBar({BuildContext context, CategoryModel insertedCategory}) {
    String message = category == null ? 'registrada' : 'atualizada';
    GDGSnackBarWidget.generateSnackBar(
        context: context,
        message: 'Categoria ${insertedCategory.name.toUpperCase()} $message.',
        backgroundColor: Colors.green,
        popNavigation: category != null);
  }

  /// build method
  @override
  Widget build(BuildContext context) {
    if (_categoryCrudPageStore.name.trim().length == 0) {
      _nameController.text = this.category != null ? this.category.name : '';
      _categoryCrudPageStore.updateName(newName: _nameController.text);
    } else
      _nameController.text = _categoryCrudPageStore.name;

    _categoryCrudPageStore.updateUrlToDownloadImage(
        newUrlImage: _urlImageController.text);

//    print(this.category);
    if (this.category != null) {
      _categoryCrudPageStore.updateImageBase64(
          newImageBase64: this.category.imageBase64);
    }

    buildContext = context;

    return Observer(
      builder: (_) {
        if (!_categoryCrudPageStore.isProcessing) {
          return _generateForm();
        }
        return _processingMessage();
      },
    );
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
