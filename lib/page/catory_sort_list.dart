import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/BookBean.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/router/AppRouter.dart';
import 'package:flutter_book_master/widget/center_title_widget.dart';
import 'package:flutter_book_master/widget/loading_widget.dart';
import 'package:flutter_book_master/widget/no_data_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:transparent_image/transparent_image.dart';

///点击某个分类进来的页面

class CategoryBookList extends StatefulWidget {
  final String title;

  final male;

  final major;

  final List<String> tiltes = ['新书', '热门', '口碑', '完结'];
  final List<String> types = ['new', 'hot', 'reputation', 'over'];

  CategoryBookList(this.title, this.male, this.major);

  @override
  State<StatefulWidget> createState() => CategoryBookListState();
}

class CategoryBookListState extends State<CategoryBookList>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController _controller;
  String minor = "";
  var selectStyle = TextStyle(fontSize: 12.0, color: Colors.black87);
  var unselectedStyle = TextStyle(fontSize: 12.0, color: Colors.black54);

  Widget _bulidTitleIndicator(TabController tabController) {
    return Container(
      height: 30.0,
      color: Colors.white,
      child: TabBar(
          indicatorColor: Colors.black87,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: selectStyle,
          controller: tabController,
          unselectedLabelStyle: unselectedStyle,
          tabs: widget.tiltes.map((title) {
            return Padding(
              padding: EdgeInsets.only(bottom: 2.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 12.0, color: Colors.black87),
              ),
            );
          }).toList()),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: widget.tiltes.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: CenterTitleWidget(widget.title),
      ),
      body: Stack(children: <Widget>[
        _bulidTitleIndicator(_controller),
        Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            children: widget.types.map((title) {
              return BookListView(title, widget.male, widget.major);
            }).toList(),
            controller: _controller,
          ),
        )
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BookListView extends StatefulWidget {
  final String type;
  final male;
  final major;

  BookListView(this.type, this.male, this.major);

  @override
  State<StatefulWidget> createState() => BookListViewState();
}

class BookListViewState extends State<BookListView>
    with AutomaticKeepAliveClientMixin {
  List<BookBean> list = [];
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();
  int start = 0;
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    _getData();
  }

  _loadMore() {
    start = list.length;
    _getData();
  }

  _getData() {
    BookApiRepository.getInstance()
        .getCategoryBookList(
            widget.male, widget.type, widget.major, "", start, 20)
        .then((data) {
      setState(() {
        if (data.isNotEmpty) list.addAll(data);
        isLoading = false;
      });
    });
  }

  _buildListView() {
    if (isLoading) {
      return LoadingPage();
    } else {
      return list.isEmpty
          ? NoDataPage()
          : EasyRefresh(
              refreshFooter: ClassicsFooter(
                key: _footerKey,
                loadText: '上拉加载',
                loadingText: '正在加载中...',
                loadReadyText: '释放加载',
                loadedText: '加载完成',
                noMoreText: '加载完成',
                bgColor: Colors.grey[50],
                textColor: Colors.black54,
              ),
              loadMore: () async {
                _loadMore();
              },
              child: ListView.builder(
                  itemCount: list.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    BookBean bean = list[index];
                    return Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: InkWell(
                        onTap: () {
                          Map<String, List<String>> parma = {
                            'id': [bean.id],
                            'title': [bean.title]
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
                                FadeInImage.memoryNetwork(
                                    //加载书本图片
                                    width: 70.0,
                                    height: 100.0,
                                    placeholder: kTransparentImage,
                                    image: Constant.IMG_BASE_URL + bean.cover),
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
                                                  bean.title,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Text(
                                                  bean.shortIntro,
                                                  textAlign: TextAlign.left,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                    bean.author,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10.0),
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Text(
                                                    '人气 :${bean.latelyFollower}',
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10.0),
                                                  )
                                                ],
                                              ))
                                        ],
                                      )),
                                )
                              ],
                            )),
                      ),
                    );
                  }),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildListView();
  }

  @override
  bool get wantKeepAlive => true;
}
