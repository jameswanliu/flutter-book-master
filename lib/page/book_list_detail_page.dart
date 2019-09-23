import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/book_list_detail_resp.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/router/AppRouter.dart';
import 'package:flutter_book_master/widget/center_title_widget.dart';
import 'package:flutter_book_master/widget/loading_widget.dart';
import 'package:flutter_book_master/widget/no_data_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:transparent_image/transparent_image.dart';

///书单详情

class BookListDetail extends StatefulWidget {
  final String id;

  BookListDetail(this.id);

  @override
  State<StatefulWidget> createState() => BookListDetailState();
}

class BookListDetailState extends State<BookListDetail> {
  BookListDetailResp _bookListResp;
  bool _isLoading = true;

  Widget _buildBody() {
    return ListView.builder(
        itemCount: _bookListResp.bookList.books.length,
        itemBuilder: (_, index) {
          if (index == 0) {
            return _buildHeader(_bookListResp.bookList);
          } else {
            return _buildListItem(_bookListResp.bookList.books[index].book);
          }
        });
  }

  _buildListItem(Book book) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.8, color: Colors.grey[100]))),
      child: InkWell(
        onTap: () {
          Map<String, List<String>> parma = {
            'id': [book.ids],
            'title': [book.title]
          };
          AppProvider.getRouter(context).navigateTo(
              context, AppRouter.generatePath(parma, BOOK_DETAIL_PAGE),
              transition: TransitionType.fadeIn);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FadeInImage.memoryNetwork(
                //加载书本图片
                width: 70.0,
                height: 100.0,
                placeholder: kTransparentImage,
                image: Constant.IMG_BASE_URL + book.cover),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    top: 1.0,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              book.title,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black),
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              book.author,
                              style: TextStyle(
                                  color: Colors.black12, fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 5.0,
                        child: Text(
                          '${book.latelyFollower}\t人追\t|\t${book.wordCount}\t字',
                          style: TextStyle(color: Colors.grey, fontSize: 10.0),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  _buildHeader(BookList bookList) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: 15.0, top: 20.0, right: 15.0, bottom: 20.0),
            child: Text(
              bookList.title,
              style: TextStyle(fontSize: 20.0, color: Colors.black87),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              bookList.desc,
              style: TextStyle(fontSize: 12.0, color: Colors.black26),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              CircleAvatar(
                radius: 18.0,
                backgroundImage: NetworkImage(
                    Constant.IMG_BASE_URL + bookList.author.avatar),
                backgroundColor: Colors.black,
              ),
              SizedBox(
                width: 4.0,
              ),
              Text(
                bookList.author.nickname,
                style: TextStyle(fontSize: 14.0, color: Colors.amber),
              ),
            ],
          )
        ],
      ),
    );
  }

  _getData() {
    BookApiRepository.getInstance().getBookListResp(widget.id).then((data) {
      setState(() {
        _isLoading = false;
        _bookListResp = data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return LoadingPage();
    }
    if (_bookListResp == null) {
      return NoDataPage();
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: CenterTitleWidget('书单详情'),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '收藏',
                style: TextStyle(fontSize: 13.0, color: Colors.white),
              ),
              SizedBox(
                width: 12.0,
              )
            ],
          )
        ],
      ),
      body: _buildBody(),
    );
  }
}
