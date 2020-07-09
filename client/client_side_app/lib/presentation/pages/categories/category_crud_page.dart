import 'package:dialog_information_to_specific_platform/flat_buttons/actions_flatbutton_to_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gdgfoz/core/error/gdg_http_exception.dart';
import 'package:gdgfoz/data/datasources/implementations/category_remote_datasource_impl.dart';
import 'package:gdgfoz/data/models/category_model.dart';
import 'package:gdgfoz/presentation/pages/categories/widgets/crud/category_crud_widget.dart';
import 'package:gdgfoz/presentation/widgets/functions_to_generate_widgets/gdg_show_dialog.dart';
import 'package:http_interceptor/http_interceptor.dart';

class CategoryCRUDPage extends StatefulWidget {
  final String categoryID;

  CategoryCRUDPage({this.categoryID});

  @override
  _CategoryCRUDPageState createState() => _CategoryCRUDPageState();
}

class _CategoryCRUDPageState extends State<CategoryCRUDPage> {
  Future<CategoryModel> _categoryFuture;

  @override
  void initState() {
    super.initState();
    _categoryFuture = _updateAndGetModel();
  }

  Future<CategoryModel> _updateAndGetModel() async {
    if (widget.categoryID != null) {
      bool exceptionOccurs = false;
      final CategoryModelRemoteDataSourceImpl _categoriesService =
          CategoryModelRemoteDataSourceImpl();
      try {
        return await _categoriesService.getByID(id: widget.categoryID);
      } on GdgHttpException catch (e) {
        await _showDialogToFailure(context: context, message: e.message);
        exceptionOccurs = true;
      } on HttpInterceptorException catch (e) {
        String exceptionMessage = e.toString();
        if (e.toString().toLowerCase().contains('timeoutexception '))
          exceptionMessage =
              'Houve uma demora na resposta do servidor. Verifique sua conexão e tente novamente';

        await _showDialogToFailure(context: context, message: exceptionMessage);
        exceptionOccurs = true;
      } finally {
        if (exceptionOccurs) Navigator.of(context).pop();
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryID == null
            ? 'Nova Categoria'
            : 'Alteração de Categoria'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder<CategoryModel>(
          future: _categoryFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                print(1);
                break;
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
                print(3);
                break;
              case ConnectionState.done:
                return CategoryCRUDWidget(
                  category: snapshot.data,
                );
                break;
            }
            return Container(
              color: Colors.white,
            );
          },
        ),
      ),
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
