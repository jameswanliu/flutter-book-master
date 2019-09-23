import 'package:flutter/material.dart';
import 'package:flutter_book_master/widget/image/cached_network_image.dart';

//import 'package:connectivity/connectivity.dart';

typedef BoolCallback = void Function(bool markAdded);

//test http://img1.doubanio.com/view/photo/s_ratio_poster/public/p457760035.webp
///点击图片变成订阅状态的缓存图片控件
class SubjectMarkImageWidget extends StatefulWidget {
  final imgNetUrl;
  final BoolCallback markAdd;
  var height = 70.0;
  var width = 100.0;

  ///360 x 513

  SubjectMarkImageWidget(this.imgNetUrl,
      {Key key, this.markAdd, this.width, this.height})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SubjectMarkImageState(imgNetUrl, markAdd, width, height);
  }
}

class _SubjectMarkImageState extends State<SubjectMarkImageWidget> {
  var markAdded = false;
  String imgLocalPath, imgNetUrl;
  final BoolCallback markAdd;
  var markAddedIcon, defaultMarkIcon;
  var loadImg;
  var imgWH = 28.0;
  var height;
  var width;

  _SubjectMarkImageState(this.imgNetUrl, this.markAdd, this.width, this.height);

  @override
  void initState() {
    super.initState();
    markAddedIcon = Image(
      image: AssetImage('assets/images/ic_subject_mark_added.png'),
      width: imgWH,
      height: imgWH,
    );
    defaultMarkIcon = ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(1.0), bottomRight: Radius.circular(1.0)),
      child: Image(
        image: AssetImage('assets/images/ic_subject_rating_mark_wish.png'),
        width: imgWH,
        height: imgWH,
      ),
    );
    var defaultImg =
    Image.asset('assets/images/ic_default_img_subject_movie.9.png');

    loadImg = ClipRRect(
      child: CachedNetworkImage(
        imageUrl: imgNetUrl,
        width: width,
        height: height,
        fit: BoxFit.fill,
        placeholder: _bulidPlaceholder(),
        fadeInDuration: const Duration(milliseconds: 80),
        fadeOutDuration: const Duration(milliseconds: 80),
      ),
      borderRadius: BorderRadius.all(Radius.circular(1.0)),
    );
  }


  _bulidPlaceholder() {
    return Container(
      width: 70.0,
      height: 100.0,
      color: Colors.grey[300],
      child: Center(
        child:
        Icon(Icons.bookmark,color: Colors.grey, size: 22.0,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        loadImg,
        GestureDetector(
          child: markAdded ? markAddedIcon : defaultMarkIcon,
          onTap: () {
            if (markAdd != null) {
              markAdd(markAdded);
            }
            setState(() {
              markAdded = !markAdded;
            });
          },
        ),
      ],
    );
  }
}
