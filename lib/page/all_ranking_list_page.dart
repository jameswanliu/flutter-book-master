import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/BookBean.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/widget/no_data_widget.dart';
import 'package:flutter_book_master/widget/subject_mark_image_widget.dart';

///榜单
// ignore: must_be_immutable
class RankingListPage extends StatefulWidget {
  Map<String, String> rankids = {};

  RankingListPage(this.rankids);

  @override
  State<StatefulWidget> createState() => RankingListPageState();
}

class RankingListPageState extends State<RankingListPage>
    with AutomaticKeepAliveClientMixin {
  List<BookBean> bookList = [];
  String overId; //完结榜单id

  String hotId; //热门榜单id

  String goodId; //好评榜单id

  String newId; //新书榜单id

  String collectionId; //收藏榜单id

  String recommendId; //推荐榜单id

  int _count = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initRankId();
    _qureyData();
  }

  void _initRankId() {
    hotId = widget.rankids['热搜榜'];
    newId = widget.rankids['潜力榜'];
    overId = widget.rankids['完结榜'];
    goodId = widget.rankids['好评榜'];
    collectionId = widget.rankids['留存榜'];
    recommendId = widget.rankids['最热榜'];
  }

  _qureyData() {
    ///热门榜单
    BookApiRepository.getInstance().getRankingList(hotId).then((data) {
      if (data != null) {
        setState(() {
          BookBean header = BookBean(isHeader: true, headerName: '热门榜单');
          BookBean footer = BookBean(isFooter: true);
          bookList.add(header);
          if (data.ranking.books.length > 3) {
            bookList.addAll(data.ranking.books.getRange(0, 3));
          } else {
            bookList.addAll(data.ranking.books);
          }
          bookList.add(footer);
          _upDateCount();
        });
      }
    });

    ///新书榜单
    BookApiRepository.getInstance().getRankingList(newId).then((data) {
      if (data != null) {
        setState(() {
          BookBean header = BookBean(isHeader: true, headerName: '新书榜单');
          BookBean footer = BookBean(isFooter: true);
          bookList.add(header);
          if (data.ranking.books.length > 3) {
            bookList.addAll(data.ranking.books.getRange(0, 3));
          } else {
            bookList.addAll(data.ranking.books);
          }
          bookList.add(footer);
          _upDateCount();
        });
      }
    });

    ///评分榜单
    BookApiRepository.getInstance().getRankingList(goodId).then((data) {
      if (data != null) {
        setState(() {
          BookBean header = BookBean(isHeader: true, headerName: '评分榜单');
          BookBean footer = BookBean(isFooter: true);
          bookList.add(header);
          if (data.ranking.books.length > 3) {
            bookList.addAll(data.ranking.books.getRange(0, 3));
          } else {
            bookList.addAll(data.ranking.books);
          }
          bookList.add(footer);
          _upDateCount();
        });
      }
    });

    ///完结榜单
    BookApiRepository.getInstance().getRankingList(overId).then((data) {
      if (data != null) {
        setState(() {
          BookBean header = BookBean(isHeader: true, headerName: '完结榜单');
          BookBean footer = BookBean(isFooter: true);
          bookList.add(header);
          if (data.ranking.books.length > 3) {
            bookList.addAll(data.ranking.books.getRange(0, 3));
          } else {
            bookList.addAll(data.ranking.books);
          }
          bookList.add(footer);
          _upDateCount();
        });
      }
    });

    ///收藏榜单
    BookApiRepository.getInstance().getRankingList(collectionId).then((data) {
      if (data != null) {
        setState(() {
          BookBean header = BookBean(isHeader: true, headerName: '收藏榜单');
          BookBean footer = BookBean(isFooter: true);
          bookList.add(header);
          if (data.ranking.books.length > 3) {
            bookList.addAll(data.ranking.books.getRange(0, 3));
          } else {
            bookList.addAll(data.ranking.books);
          }

          bookList.add(footer);
          _upDateCount();
        });
      }
    });

    ///推荐榜单
    BookApiRepository.getInstance().getRankingList(recommendId).then((data) {
      if (data != null) {
        setState(() {
          BookBean header = BookBean(isHeader: true, headerName: '推荐榜单');
          BookBean footer = BookBean(isFooter: true);
          bookList.add(header);
          if (data.ranking.books.length > 3) {
            bookList.addAll(data.ranking.books.getRange(0, 3));
          } else {
            bookList.addAll(data.ranking.books);
          }
          bookList.add(footer);
          _upDateCount();
        });
      }
    });
  }

  _upDateCount() {
    _count++;
    if (_count == 6) {
      isLoading = false;
    }
  }

  _buildHeader(BookBean bean) {
    return Container(
        alignment: Alignment.centerLeft,
        height: 30.0,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 12.0,
            ),
            Icon(
              Icons.bookmark,
              color: Colors.orange,
              size: 12.0,
            ),
            SizedBox(
              width: 3.0,
            ),
            Text(
              bean.headerName,
              style: TextStyle(color: Colors.black87, fontSize: 13.0),
            )
          ],
        ));
  }

  _buildFooter() {
    return GestureDetector(
      onTap: () {},
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey[50], width: 8.0))),
          height: 50.0,
          child: Text(
            '更多',
            style: TextStyle(fontSize: 12.0, color: Colors.black54),
          )),
    );
  }

  ///构建item
  _buildItem(BookBean bean) {
    return Padding(
        padding:
            EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
        child: Row(
          children: <Widget>[
            SubjectMarkImageWidget(
              Constant.IMG_BASE_URL + bean.cover,
              width: 70.0,
              height: 100.0,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          bean.title,
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.black),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          '${bean.majorCate}\t|\t${bean.author}',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black87),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          bean.shortIntro,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )))
          ],
        ));
  }

  _buildList() {
    return Container(
        color: Colors.white,
        child: ListView.builder(
          itemBuilder: (_, index) {
            BookBean bean = bookList[index];
            if (bean != null) {
              if (bean.isHeader != null && bean.isHeader)
                return _buildHeader(bean);
              if (bean.isFooter != null && bean.isFooter) return _buildFooter();
              return _buildItem(bean);
            }
          },
          itemCount: bookList.length,
        ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (isLoading)
      return Container(child: Center(child: CupertinoActivityIndicator()));
    if (bookList.isEmpty) return NoDataPage();
    return _buildList();
  }

  @override
  bool get wantKeepAlive => true;
}
