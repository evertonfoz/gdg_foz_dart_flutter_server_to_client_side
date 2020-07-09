import 'package:flutter/material.dart';
import 'package:gdgfoz/core/constants.dart';
import 'package:gdgfoz/data/models/category_model.dart';
import 'package:gdgfoz/presentation/pages/categories/widgets/listview/circle_image_widget_to_listview.dart';

class CardWidgetToListTileToListView extends StatelessWidget {
  final CategoryModel categoryModel;
  final Function onLongPressCallback;

  const CardWidgetToListTileToListView(
      {this.categoryModel, this.onLongPressCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onLongPress: () async {
          await Navigator.of(context).pushNamed(
            kCRUDRoute,
            arguments: categoryModel.categoryID,
          );
          onLongPressCallback();
        },
        highlightColor: Colors.blueAccent,
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleImageWidgetToListView(
              imageBase64: categoryModel.imageBase64),
          title: Text(
            categoryModel.name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
