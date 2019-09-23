import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/book_hot_review.dart';
import 'package:flutter_book_master/bean/book_list_recommond.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/router/AppRouter.dart';
import 'package:flutter_book_master/widget/loading_widget.dart';
import 'package:flutter_book_master/widget/no_data_widget.dart';
import 'package:flutter_book_master/widget/rating_bar.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:math' as math;

class LongCommentTabView extends StatefulWidget {
  final String bookId;

  LongCommentTabView(this.bookId);

  @override
  _LongCommentTabViewState createState() => _LongCommentTabViewState();
}

class _LongCommentTabViewState extends State<LongCommentTabView>
    with SingleTickerProviderStateMixin {
  final List<String> list = ['评论', '推荐书单'];

  TabController controller;
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;

  @override
  void initState() {
    controller = TabController(length: list.length, vsync: this);
    selectColor = Colors.black;
    unselectedColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 15, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 15, color: selectColor);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 6.0,
          width: 45.0,
          margin: const EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 214, 215, 218),
              borderRadius: BorderRadius.all(const Radius.circular(5.0))),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15.0),
          child: TabBar(
            tabs: list
                .map((item) => Padding(
                      padding:
                          const EdgeInsets.only(bottom: Constant.TAB_BOTTOM),
                      child: Text(item),
                    ))
                .toList(),
            isScrollable: true,
            indicatorColor: selectColor,
            labelColor: selectColor,
            labelStyle: selectStyle,
            unselectedLabelColor: unselectedColor,
            unselectedLabelStyle: unselectedStyle,
            indicatorSize: TabBarIndicatorSize.label,
            controller: controller,
          ),
          alignment: Alignment.centerLeft,
        ),
        Expanded(
            child: TabBarView(
          children: <Widget>[
            HotReviewList(widget.bookId),
            RecommondBookList(widget.bookId),
          ],
          controller: controller,
        ))
      ],
    );
  }
}

class HotReviewList extends StatefulWidget {
  final String id;

  HotReviewList(this.id);

  @override
  State<StatefulWidget> createState() => HotReviewListState();
}

class HotReviewListState extends State<HotReviewList> {
  bool hotReviewIsloading = true;
  List<ReviewBean> hotReviews = [];

  @override
  initState() {
    super.initState();
    _getHotReview();
  }

  _getHotReview() {
    BookApiRepository.getInstance().getBookHotReviews(widget.id).then((data) {
      hotReviewIsloading = false;
      if (data != null && data.isNotEmpty) {
        setState(() {
          hotReviews.addAll(data);
        });
      }
    });
  }

  padding() {
    return EdgeInsets.only(
        left: Constant.MARGIN_LEFT, right: Constant.MARGIN_RIGHT);
  }

  ///短评，默认显示4个
  _sliverComments() {
    if (hotReviewIsloading) {
      return LoadingPage();
    }
    if (hotReviews == null || hotReviews.isEmpty) {
      return NoDataPage();
    } else {
      int allCount = math.min(4, hotReviews.length);
      allCount = allCount + 2; //多出来的2个表示头和脚
      return ListView.builder(
        itemBuilder: ((BuildContext context, int index) {
          if (index == 0) {
            ///头布局
            return Container(
              margin: EdgeInsets.only(
                  top: 30.0,
                  left: Constant.MARGIN_LEFT,
                  right: Constant.MARGIN_RIGHT),
              child: Row(
                children: <Widget>[
                  Text(
                    '热评',
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ],
              ),
            );
          } else if (index == allCount - 1) {
            ///显示脚布局
            return Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(
                  bottom: 20.0,
                  left: Constant.MARGIN_LEFT,
                  right: Constant.MARGIN_RIGHT),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0))),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      '查看全部评价',
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right,
                      size: 20.0, color: Color(0x88fffffff))
                ],
              ),
            );
          } else {
            ReviewBean bean = hotReviews[index - 1];
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: Container(
                margin: padding(),

                ///内容item
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, top: 10.0, bottom: 5.0),
                          child: CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                                Constant.IMG_BASE_URL + bean.author.avatar),
                            backgroundColor: Colors.black,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              bean.author.nickname,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Colors.black),
                            ),
                            RatingBar(
                              bean.rating,
                              size: 11.0,
                              fontSize: 0.0,
                            )
                          ],
                        )
                      ],
                    ),
                    Text(
                      bean.title,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                    Text(
                      bean.content,
                      softWrap: true,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13.0, color: Colors.black),
                    ),
                    Row(
                      //赞的数量
                      children: <Widget>[
                        Image.asset(
                          Constant.ASSETS_IMG + 'ic_vote_normal_large.png',
                          width: 20.0,
                          height: 20.0,
                        ),
                        Text(
                          '${bean.likeCount}',
                          style: TextStyle(color: Colors.black54),
                        )
                      ],
                    )
                  ],
                ),
                padding: EdgeInsets.all(12.0),
              ),
              onTap: () {},
            );
          }
        }),
        itemCount: hotReviews.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _sliverComments();
  }
}

class RecommondBookList extends StatefulWidget {
  final String bookId;

  RecommondBookList(this.bookId);

  @override
  State<StatefulWidget> createState() => RecommondBookListState();
}

class RecommondBookListState extends State<RecommondBookList> {
  List<BookListBean> recommondBookList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    BookApiRepository.getInstance()
        .getBookListRecommond(widget.bookId, 20)
        .then((data) {
      setState(() {
        isLoading = false;
        if (data != null && data.isNotEmpty) recommondBookList.addAll(data);
      });
    });
  }

  Widget getItem(BookListBean bean) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 0.8, color: Colors.grey[100]))),
        child: Row(
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 7.0, right: 5.0),
                child: FadeInImage.memoryNetwork(
                    width: 70.0,
                    height: 100.0,
                    placeholder: kTransparentImage,
                    image: Constant.IMG_BASE_URL + bean.cover)),
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
                              bean.title,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              bean.desc,
                              textAlign: TextAlign.left,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 11.0, color: Colors.black87),
                              maxLines: 4,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 0.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.person,
                                size: 12.0,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                bean.author,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10.0),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                            ],
                          ))
                    ],
                  )),
            )
          ],
        ),
      ),
      onTap: () {
        Map<String, List<String>> parma = {
          'id': [bean.id]
        };
        AppProvider.getRouter(context).navigateTo(
            context, AppRouter.generatePath(parma, BOOK_LIST_PAGE),
            transition: TransitionType.fadeIn);
      },
    );
  }

  _buildListView(List<BookListBean> data) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: getItem(data[index]),
              padding: const EdgeInsets.only(
                  left: Constant.MARGIN_LEFT, right: Constant.MARGIN_RIGHT),
            ),
          ],
        );
      },
      physics: const ClampingScrollPhysics(),
      itemCount: recommondBookList.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return LoadingPage();
    if (recommondBookList.isEmpty) return NoDataPage();
    return _buildListView(recommondBookList);
  }
}
