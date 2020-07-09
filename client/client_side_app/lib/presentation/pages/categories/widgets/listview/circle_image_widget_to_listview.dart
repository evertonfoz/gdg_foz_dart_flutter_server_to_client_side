import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class CircleImageWidgetToListView extends StatelessWidget {
  final String imageBase64;

  const CircleImageWidgetToListView({this.imageBase64});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.blue[900],
        ),
        image: DecorationImage(
            image: _generateImageToCircleAvatar(imageBase64: imageBase64),
            fit: BoxFit.fill),
      ),
    );
  }

  _generateImageToCircleAvatar({String imageBase64}) {
    if (imageBase64 != null)
      return FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        image: MemoryImage(base64Decode(imageBase64.split(',').last)),
        fit: BoxFit.cover,
      ).image;
    else
      return AssetImage('assets/images/noPhotoAvailable.jpg');
  }
}
