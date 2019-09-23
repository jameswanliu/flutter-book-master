import 'package:flutter/material.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:transparent_image/transparent_image.dart';

///分类列表的图片widget
class ThreeLaminatedImage extends StatelessWidget {
  final urls;
  final w;

  ThreeLaminatedImage(this.urls, this.w);

  @override
  Widget build(BuildContext context) {
    double h = w * 10 / 7 * 1.2;
    double leftPadding = w * 0.8 / 2+4.0;

    return Container(
      width: w * 2 + 8.0,
      height: h,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Card(
            color: Colors.transparent,
              elevation: 6.0,
              child: AspectRatio(
                aspectRatio: 7 / 5,
                child: Row(
                  children: <Widget>[
                    FadeInImage.memoryNetwork(
                        width: w,
                        height: w * 10 / 7,
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: Constant.IMG_BASE_URL + urls[1]),
                    FadeInImage.memoryNetwork(
                        width: w,
                        fit: BoxFit.cover,
                        height: w * 10 / 7,
                        placeholder: kTransparentImage,
                        image: Constant.IMG_BASE_URL + urls[2]),
                  ],
                ),
              )),
          Positioned(
            left: leftPadding,
            child: FadeInImage.memoryNetwork(
                width: w * 1.2,
                height: h,
                fit: BoxFit.cover,
                placeholder: kTransparentImage,
                image: Constant.IMG_BASE_URL + urls[0]),
          )
        ],
      ),
    );
  }
}
