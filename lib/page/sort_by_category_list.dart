import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/BookBean.dart';
import 'package:flutter_book_master/widget/center_title_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter/cupertino.dart';

class SortByCategoryList extends StatefulWidget {
  ///男生 女生
  final String male;

  ///口碑 新书 完本经典 热门书籍
  final String type;

  SortByCategoryList({@required this.male, @required this.type});

  @override
  State<StatefulWidget> createState() => SortByCategoryListState();
}

class SortByCategoryListState extends State<SortByCategoryList> {
  _back() {}

  _showSort() {}

  List<BookBean> list = [];
  String title;

  var pageIndex = 0;
  GlobalKey<SortByCategoryListState> _footerKey =
      new GlobalKey<SortByCategoryListState>();

  @override
  void initState() {
    super.initState();
    title = widget.male == 'male' ? '男生${widget.type}' : '女生${widget.type}';
    _footerKey.currentState._callLoadMore();
  }

  _callLoadMore() {
    pageIndex++;
  }

  _buildBody() {
    return list.isEmpty
        ? Container(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : EasyRefresh(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {}),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: CenterTitleWidget(title),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            GestureDetector(
                onTap: _back,
                child: Icon(
                  Icons.sort,
                  color: Colors.white,
                ))
          ],
          leading: GestureDetector(
            onTap: _showSort,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          )),
      body: _buildBody(),
    );
  }
}
