import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ListImageView extends StatelessWidget {
  final String url;

  ListImageView(this.url);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.transparent,
        elevation: 2.0,
        child: AspectRatio(
          aspectRatio: 7 / 10,
          child: FadeInImage.memoryNetwork(
              //加载书本图片
              width: 70.0,
              fit: BoxFit.cover,
              height: 100.0,
              placeholder: kTransparentImage,
              image: url),
        ));
  }
}
