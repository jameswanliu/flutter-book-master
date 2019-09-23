import 'dart:math';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/BookBean.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/redux/state/AppState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_book_master/repertory/viewmodel/HomeModel.dart';
import 'package:flutter_book_master/repertory/viewmodel/ViewModel.dart';
import 'package:flutter_book_master/router/AppRouter.dart';
import 'package:flutter_book_master/widget/LibFiltGroupBar.dart';
import 'package:flutter_book_master/bean/male_prise_book.dart' show RankBean;
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/widget/imageview_widget.dart';
import 'package:flutter_book_master/widget/sliverItemHeader.dart';
import 'package:flutter_book_master/widget/subject_mark_image_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:transparent_image/transparent_image.dart';
import 'BookNormalListPage.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';

import 'package:flutter_book_master/widget/new_book_widget.dart';

///男生女生
class MaleBookPage extends StatefulWidget {
  final String title;

  final String male;

  final String hot = 'hot'; //热门

  final String priaseId; //99%的男生看了都说好 5a6844f8fc84c2b8efaa8bc5

  final String over = 'over'; //完本

  final String news = 'new'; //新书

  final String reputation = 'reputation'; //口碑

  final String majorFantasy; //'奇幻';

  final String majorXuanhuan; //'玄幻';

  final String majorKnightErrant; // '武侠';

  final String majorGame; // '游戏';

  MaleBookPage(
      {Key key,
      this.majorFantasy,
      this.majorXuanhuan,
      this.majorKnightErrant,
      this.majorGame,
      this.title,
      this.male,
      this.priaseId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => MaleBookPageState();
}

class MaleBookPageState extends State<MaleBookPage>
    with AutomaticKeepAliveClientMixin {
  String titleTip;

  @override
  void initState() {
    super.initState();
    titleTip = widget.male == 'male' ? '男生' : '女生';
    print("FavouritesBookPage--" + titleTip);
    _qureyPriaseBookList(widget.priaseId);
    _queryBookList(widget.hot); //热门精选
    _queryBookList(widget.over); //完本经典
    _queryBookList(widget.news); //新书
    _queryBookList(widget.reputation); //口碑佳作
  }

  ///男生女生好评书籍
  _qureyPriaseBookList(String id) async {
    await BookApiRepository.getInstance()
        .getPriaseBookList(widget.male == 'male' ? 0 : 1, id);
  }

  _queryBookList(String type) async {
    await BookApiRepository.getInstance().getBookListByCategory(
        widget.male, type, widget.majorXuanhuan, "", 0, 20); //玄幻
    await BookApiRepository.getInstance().getBookListByCategory(
        widget.male, type, widget.majorFantasy, "", 0, 20); //奇幻
    await BookApiRepository.getInstance().getBookListByCategory(
        widget.male, type, widget.majorKnightErrant, "", 0, 20); //武侠
    await BookApiRepository.getInstance().getBookListByCategory(
        widget.male, type, widget.majorGame, "", 0, 20); //游戏
  }

  ///男生女生最爱看的小说列表
  getRankGoodList(List<BookBean> data) {
    List<BookBean> maleList = [];
    if (data != null && data.isNotEmpty) {
      maleList.addAll(data);
      maleList.shuffle(Random(data.length));
    }
    return maleList.length < 8
        ? SliverToBoxAdapter(
            child: Container(
            height: 180.0,
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ))
        : SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return rankHotItem(maleList[index]);
            }, childCount: 8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 8.0 / 13.0),
          );
  }

  ///99%widget
  _bulidPriaseBookList(RankBean data) {
    if (data == null || data.books.isEmpty)
      return SliverToBoxAdapter(
          child: Container(
        color: Colors.white,
        height: 100.0,
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      ));

    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        height: 120.0,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var book = data.books[index];
            return Container(
                constraints: BoxConstraints.tightFor(
                    width: ScreenUtil.getInstance().setWidth(750),
                    height: 111.0),
                child: InkWell(
                  onTap: () {
                    Map<String, List<String>> parma = {
                      'id': [book.id],
                      'title': [book.title]
                    };
                    AppProvider.getRouter(context).navigateTo(context,
                        AppRouter.generatePath(parma, BOOK_DETAIL_PAGE),
                        transition: TransitionType.fadeIn);
                  },
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SubjectMarkImageWidget(
                            Constant.IMG_BASE_URL + book.cover,
                            height: 100.0,
                            width: 70.0,
                          ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            book.title,
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black),
                                            maxLines: 1,
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            book.shortIntro,
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                color: Colors.black87),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                              book.author,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10.0),
                                            ),
                                          ],
                                        ))
                                  ],
                                )),
                          )
                        ],
                      )),
                ));
          },
          itemCount: data.books.length,
        ),
      ),
    );
  }

  ///列表item
  rankHotItem(BookBean bookBean) {
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Map<String, List<String>> parma = {
            'id': [bookBean.id],
            'title': [bookBean.title]
          };
          AppProvider.getRouter(context).navigateTo(
              context, AppRouter.generatePath(parma, BOOK_DETAIL_PAGE),
              transition: TransitionType.fadeIn);
        },
        child: Padding(
            padding:
                EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SubjectMarkImageWidget(
                  Constant.IMG_BASE_URL + bookBean.cover,
                  width: 70.0,
                  height: 100.0,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  bookBean.title,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 12.0, color: Colors.black),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  bookBean.author,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: Colors.grey, fontSize: 10.0),
                ),
              ],
            )),
      ),
    );
  }

  ///获取新书图片的url地址
  _getNewBooksUrls(List<BookBean> newBooks) {
    List<String> urls = [];

    if (newBooks.length > 3) {
      newBooks.shuffle(Random(newBooks.length));
    }

    if (newBooks == null || newBooks.length < 3) return [];
    for (int i = 0; i < 3; i++) {
      if (newBooks[i].cover.isNotEmpty) {
        urls.add(Constant.IMG_BASE_URL + newBooks[i].cover);
      }
    }
    return urls;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<AppState, HomeViewModel>(
      converter: (store) => HomeViewModel(store),
      builder: (context, vm) => SafeArea(
          bottom: false,
          top: false,
          child: Container(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                    child: SliverItemHeader('99%的$titleTip看了都说好')),
                _bulidPriaseBookList(widget.male == 'male'
                    ? vm.malePriaseBookList
                    : vm.femalePriaseBookList),
                SliverToBoxAdapter(
                  child: Divider(
                    color: Colors.transparent,
                    height: 8.0,
                  ),
                ),
                SliverToBoxAdapter(child: SliverItemHeader('$titleTip最爱看的书')),
                getRankGoodList(widget.male == 'male'
                    ? vm.maleHotBookList
                    : vm.femaleHotBookList),
                SliverToBoxAdapter(
                  child: Divider(
                    color: Colors.transparent,
                    height: 8.0,
                  ),
                ),
                SliverToBoxAdapter(child: SliverItemHeader('$titleTip完本经典')),
                getRankGoodList(widget.male == 'male'
                    ? vm.maleOverBookList
                    : vm.femaleOverBookList),
                SliverToBoxAdapter(
                  child: Divider(
                    color: Colors.transparent,
                    height: 8.0,
                  ),
                ),
                SliverToBoxAdapter(child: SliverItemHeader('$titleTip口碑佳作')),
                getRankGoodList(widget.male == 'male'
                    ? vm.maleReputationBookList
                    : vm.femaleReputationBookList),
                SliverToBoxAdapter(
                  child: vm.maleNewBookList.length < 8
                      ? Container(
                          height: 80.0,
                          child: Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TodayNewBookWidget(
                              _getNewBooksUrls(widget.male == 'male'
                                  ? vm.maleNewBookList
                                  : vm.femaleNewBookList),
                              backgroundColor: widget.male == 'female'
                                  ? Colors.pinkAccent
                                  : null),
                        ),
                )
              ],
            ),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

void actionChipCallback(String title) {
  print(title);
}
