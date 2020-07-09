import 'package:dialog_information_to_specific_platform/flat_buttons/actions_flatbutton_to_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gdgfoz/core/constants.dart';
import 'package:gdgfoz/core/error/gdg_http_exception.dart';
import 'package:gdgfoz/data/datasources/implementations/category_remote_datasource_impl.dart';
import 'package:gdgfoz/data/models/category_model.dart';
import 'package:gdgfoz/data/models/user_model.dart';
import 'package:gdgfoz/presentation/pages/categories/widgets/listview/categories_listview_widget.dart';
import 'package:gdgfoz/presentation/widgets/functions_to_generate_widgets/gdg_show_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:http_interceptor/http_interceptor.dart';

class CategoryListPage extends StatefulWidget {
  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  Future<List<CategoryModel>> _categoriesListFuture;

  @override
  void initState() {
    super.initState();
    _categoriesListFuture = _updateAndGetList();
  }

  Future<List<CategoryModel>> _updateAndGetList() async {
    final CategoryModelRemoteDataSourceImpl _categoriesService =
        CategoryModelRemoteDataSourceImpl();

    List<CategoryModel> categories;
    while (categories == null) {
      try {
        categories = await _categoriesService.getAllCategories();
        return categories;
      } on GdgHttpException catch (e) {
        _showDialogToFailure(context: context, message: e.message);
      } on HttpInterceptorException catch (e) {
        String exceptionMessage = e.toString();
        if (e.toString().toLowerCase().contains('timeoutexception '))
          exceptionMessage =
              'Houve uma demora na resposta do servidor. Verifique sua conexão e tente novamente';

        _showDialogToFailure(context: context, message: exceptionMessage);
      }
    }
  }

  Future _refreshList() async {
    setState(() {
      _categoriesListFuture = _updateAndGetList();
    });
  }

  Widget _categoriesListView() {
    return FutureBuilder<List<CategoryModel>>(
      future: _categoriesListFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            print('snapshot.connectionState');
            break;
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            print('ConnectionState.active');
            break;
          case ConnectionState.done:
            return CategoriesListViewWidget(
              categories: snapshot.data,
              onLongPressCallback: _refreshList,
            );
        }
        return Container(
          color: Colors.blue,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        GetIt.I.unregister<UserModel>();
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: _categoriesListView(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).pushNamed(kCRUDRoute);
            await _refreshList();
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
