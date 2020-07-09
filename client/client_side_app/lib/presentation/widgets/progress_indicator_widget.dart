import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final String text;

  const ProgressIndicatorWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text(text),
        ],
      ),
    );
  }
}
