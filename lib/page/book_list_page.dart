import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_book_master/bean/BookBean.dart';
import 'package:flutter_book_master/bean/book_list_resp.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/router/AppRouter.dart';
import 'package:flutter_book_master/widget/no_data_widget.dart';
import 'package:flutter_book_master/widget/sliverItemHeader.dart';
import 'package:flutter_book_master/widget/subject_mark_image_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///书单列表
class BookListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BookListPageState();
}

class BookListPageState extends State<BookListPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<String> titles = ['最新发布', '本周最热', '最多收藏', '小编推荐'];
  List<BookListsBean> hotBookList = []; //本周最热
  List<BookListsBean> newBookList = []; //最新发布
  List<BookListsBean> collectBookList = []; //最多收藏
  List<BookListsBean> recommondBookList = []; //小编推荐

  int _currentIndex = 0;

  bool isLoading = true;

  int _queryCount = 0;

  List<Map<String, String>> lists = [
    {'duration': 'all', 'sort': 'created'}, //最新发布
    {'duration': 'last-seven-days', 'sort': 'collectorCount'}, //本周最热
    {'duration': 'all', 'sort': 'collectorCount'}, //最多收藏
    {'duration': 'all', 'sort': 'recommend'} //小编推荐
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: titles.length, vsync: this);
    _queryData(lists[1]['duration'], lists[1]['sort'], 6, '', 0);
    _queryData(lists[0]['duration'], lists[0]['sort'], 6, '', 1);
    _queryData(lists[2]['duration'], lists[2]['sort'], 6, '', 2);
    _queryData(lists[3]['duration'], lists[3]['sort'], 20, '', 3);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _queryData(String duration, String sort, int limit, String tag, int index) {
    BookApiRepository.getInstance()
        .getBookList('male', 0, limit, duration, sort, tag)
        .then((data) {
      setState(() {
        _upDateState(index, data);
      });
    });
  }

  _upDateState(index, data) {
    _queryCount++;
    if (_queryCount == 4) {
      isLoading = false;
    }

    switch (index) {
      case 0:
        hotBookList.addAll(data);
        break;
      case 1:
        newBookList.addAll(data);
        break;
      case 2:
        collectBookList.addAll(data);
        break;
      case 3:
        recommondBookList.addAll(data);
        break;
    }
  }

  _buildList() {
    if (isLoading)
      return Container(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: SliverItemHeader(
              '收藏书单',
              leftSizeBoxSize: 0.0,
              rightSizeBoxSize: 0.0,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
                return _buildRecommondBookListItem(collectBookList[index]);
              }, childCount: collectBookList.length)),
          SliverToBoxAdapter(
              child: Divider(
            color: Colors.transparent,
            height: 10.0,
          )),
          SliverToBoxAdapter(
            child: SliverItemHeader(
              '本周最热书单',
              leftSizeBoxSize: 0.0,
              rightSizeBoxSize: 0.0,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
            return _buildRecommondBookListItem(hotBookList[index]);
          }, childCount: hotBookList.length)),
          SliverToBoxAdapter(
            child: SliverItemHeader(
              '最新书单',
              leftSizeBoxSize: 0.0,
              rightSizeBoxSize: 0.0,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
            return _buildBookListItem(newBookList[index]);
          }, childCount: newBookList.length)),
          SliverToBoxAdapter(
            child: SliverItemHeader(
              '收藏书单',
              leftSizeBoxSize: 0.0,
              rightSizeBoxSize: 0.0,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
            return _buildRecommondBookListItem(collectBookList[index]);
          }, childCount: collectBookList.length)),
          SliverToBoxAdapter(
            child: SliverItemHeader(
              '小编推荐',
              leftSizeBoxSize: 0.0,
              rightSizeBoxSize: 0.0,
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((_, index) {
            return _buildRecommondBookListItem(recommondBookList[index]);
          }, childCount: recommondBookList.length)),
        ],
      ),
    );
  }

  ///书单item
  _buildBookListItem(BookListsBean bean) {
    return GestureDetector(
        onTap: () {
          Map<String, List<String>> parma = {
            'id': [bean.id]
          };
          AppProvider.getRouter(context).navigateTo(
              context, AppRouter.generatePath(parma, BOOK_LIST_PAGE),
              transition: TransitionType.fadeIn);
        },
        child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.white, width: 12.0))),
            constraints: BoxConstraints.tightFor(
              height: 120.0,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                bean.desc,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black38),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                '共${bean.bookCount}本书',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          )))
                ],
              ),
            )));
  }

  ///小编推荐item
  _buildRecommondBookListItem(BookListsBean bean) {
    if (bean.covers.length < 3) {
      return _buildBookListItem(bean);
    }
    return GestureDetector(
        onTap: () {
          Map<String, List<String>> parma = {
            'id': [bean.id]
          };
          AppProvider.getRouter(context).navigateTo(
              context, AppRouter.generatePath(parma, BOOK_LIST_PAGE),
              transition: TransitionType.fadeIn);
        },
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.white, width: 15.0))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                bean.title,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
              SizedBox(
                height: 5.0,
              ),
              GridView.extent(
                  shrinkWrap: true,
                  maxCrossAxisExtent: 150.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 15.0,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 70 / 100,
                  children: bean.covers.map((url) {
                    return Image.network(
                      Constant.IMG_BASE_URL + url,
                      fit: BoxFit.fill,
                    );
                  }).toList()),
              SizedBox(
                height: 8.0,
              ),
              Text(
                bean.desc,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13.0, color: Colors.black38),
              ),
              SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildList();
  }

  @override
  bool get wantKeepAlive => true;
}

class BookList extends StatefulWidget {
  Map<String, String> params = {};

  BookList(this.params);

  @override
  State<StatefulWidget> createState() => BookListState();
}

class BookListState extends State<BookList> with AutomaticKeepAliveClientMixin {
  List<BookListsBean> bookList = [];
  bool isLoading = true;
  int start = 0;
  String tag = '';
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
    _queryData();
  }

  _queryData() {
    BookApiRepository.getInstance()
        .getBookList('male', start, 20, widget.params['duration'],
            widget.params['sort'], tag)
        .then((data) {
      if (data != null && data.isNotEmpty) {
        setState(() {
          isLoading = false;
          bookList.addAll(data);
        });
      }
    });
  }

  _loadMore() {
    start = bookList.length;
    _queryData();
  }

  ///构建item
  _buildItem(BookListsBean bean) {}

  _bulidBody() {
    if (isLoading)
      return Container(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    if (bookList.isEmpty) return NoDataPage();

    return EasyRefresh(
        refreshFooter: ClassicsFooter(
          key: _footerKey,
          loadText: '上拉加载',
          loadingText: '正在加载中...',
          loadReadyText: '释放加载',
          loadedText: '加载完成',
          noMoreText: '加载完成',
          bgColor: Colors.white,
          textColor: Colors.black54,
        ),
        loadMore: () async {
          _loadMore();
        },
        child: Container(
            child: ListView.builder(
          itemBuilder: (_, index) {
            return _buildItem(bookList[index]);
          },
          itemCount: bookList.length,
        )));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _bulidBody();
  }

  @override
  bool get wantKeepAlive => true;
}
