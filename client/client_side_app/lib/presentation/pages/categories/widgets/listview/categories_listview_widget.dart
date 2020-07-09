import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gdgfoz/data/models/category_model.dart';
import 'package:gdgfoz/presentation/pages/categories/widgets/listview/dismissible_to_card_widget.dart';

class CategoriesListViewWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function onLongPressCallback;

  CategoriesListViewWidget({
    @required this.categories,
    @required this.onLongPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return DismissibleToCardWidget(
              categoryModel: categories[index],
              onLongPressCallback: onLongPressCallback,
            );
          }),
    );
  }
}
