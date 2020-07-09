import 'package:dialog_information_to_specific_platform/flat_buttons/actions_flatbutton_to_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gdgfoz/core/error/gdg_http_exception.dart';
import 'package:gdgfoz/data/datasources/implementations/category_remote_datasource_impl.dart';
import 'package:gdgfoz/data/models/category_model.dart';
import 'package:gdgfoz/presentation/pages/categories/widgets/listview/card_widget_to_listtile_of_listview.dart';
import 'package:gdgfoz/presentation/widgets/functions_to_generate_widgets/gdg_show_dialog.dart';
import 'package:gdgfoz/presentation/widgets/functions_to_generate_widgets/gdg_snackbar_widget.dart';
import 'package:http_interceptor/http_interceptor.dart';

class DismissibleToCardWidget extends StatelessWidget {
  final CategoryModel categoryModel;
  final Function onLongPressCallback;

  const DismissibleToCardWidget({this.categoryModel, this.onLongPressCallback});

  Future _showDialogToConfirmDelete({BuildContext context}) {
    return gdgDialog(
        context: context,
        iconTitle: Icon(
          Icons.question_answer,
          color: Colors.blue[900],
        ),
        title: 'Remover Categoria',
        subTitle:
            'Confirma a remoção da categoria ${categoryModel.name.toUpperCase()}',
        buttons: [
          ActionsFlatButtonToAlertDialog(
            messageButton: 'Cancelar',
          ),
          ActionsFlatButtonToAlertDialog(
            messageButton: 'Confirmar',
          ),
        ]);
  }

  Future _removeCategory({BuildContext context}) async {
    CategoryModelRemoteDataSourceImpl service =
        CategoryModelRemoteDataSourceImpl();
    try {
      await service.deleteByID(id: categoryModel.categoryID);
      GDGSnackBarWidget.generateSnackBar(
          context: context,
          message: 'Categoria ${categoryModel.name.toUpperCase()} removida.',
          backgroundColor: Colors.red);
    } on GdgHttpException catch (e) {
      await GdgHttpException.showDialogToFailure(
          context: context, message: e.message);
    } on HttpInterceptorException catch (e) {
      await GdgHttpException.showDialogToFailure(
          context: context,
          message: GdgHttpException.httpInterceptorExceptionMessage(
              message: e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(categoryModel.categoryID),
      confirmDismiss: (direction) async {
        return await _showDialogToConfirmDelete(context: context) ==
            'Confirmar';
      },
      onDismissed: (direction) async {
        await _removeCategory(context: context);
        onLongPressCallback();
      },
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 36,
        ),
      ),
      child: CardWidgetToListTileToListView(
        categoryModel: categoryModel,
        onLongPressCallback: onLongPressCallback,
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
