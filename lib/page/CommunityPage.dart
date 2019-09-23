import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/book_list_resp.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/widget/home_app_bar.dart' as myAppBar;
import 'package:flutter_book_master/bean/choice_chip_bean.dart';
import 'package:flutter_book_master/widget/no_data_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CommunityPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CommunityPageState();
}

class CommunityPageState extends State<CommunityPage> {
  List<String> _tabs = ['男生', '最热', '周榜'];

  List<ChoiceChipBean> _genders = [];

  List<ChoiceChipBean> _choiceSorts = [];

  List<ChoiceChipBean> _times = [];

  List<BookListsBean> bookList = [];
  bool isLoading = true;
  int start = 0;
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  _loadMore() {
    start = bookList.length;
    _queryData();
  }

  _queryData() {
//    BookApiRepository.getInstance()
//        .getBookList('male', start, 20, widget.params['duration'],
//        widget.params['sort'], tag)
//        .then((data) {
//      if (data != null && data.isNotEmpty) {
//        setState(() {
//          isLoading = false;
//          bookList.addAll(data);
//        });
//      }
//    });
  }

  @override
  void initState() {
    super.initState();
    _initSortData();
    _initTimesData();
    _initGendersData();
  }

  _initSortData() {
    List<String> _sorts = ['最热', '推荐', '完结', '收藏', '新书', '评分'];
    _sorts.map((title) {
      _choiceSorts.add(ChoiceChipBean(title, "", false));
    }).toList();
    _choiceSorts[0].select = true;
  }

  _initGendersData() {
    List<String> _sorts = ['男生', '女生'];
    _sorts.map((title) {
      _genders.add(ChoiceChipBean(title, "", false));
    }).toList();
    _genders[0].select = true;
  }

  _initTimesData() {
    List<String> _sorts = ['周榜', '月榜', '总榜'];
    _sorts.map((title) {
      _times.add(ChoiceChipBean(title, "", false));
    }).toList();
    _times[0].select = true;
  }

  _buildHeader() {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _genders.map((bean) {
              return ChoiceChip(
                label: Text(bean.name),
                selected: bean.select,
                onSelected: (select) {
                  _choiceSorts.forEach((b) {
                    b.select = false;
                  });
                  bean.select = select;
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _choiceSorts.map((bean) {
              return ChoiceChip(
                label: Text(bean.name),
                selected: bean.select,
                onSelected: (select) {
                  _choiceSorts.forEach((b) {
                    b.select = false;
                  });
                  bean.select = select;
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _times.map((bean) {
              return ChoiceChip(
                label: Text(bean.name),
                selected: bean.select,
                onSelected: (select) {
                  _choiceSorts.forEach((b) {
                    b.select = false;
                  });
                  bean.select = select;
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }

  ///构建item
  _buildItem(BookListsBean bean) {}

  _buildListView() {
    if (isLoading) {
      return Container(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }
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

  _bulidBody() {
    return Column(
      children: <Widget>[
        _buildHeader(),
        SliverToBoxAdapter(
          child: _buildListView(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();

//      NestedScrollView(
//        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//          return <Widget>[
//            SliverOverlapAbsorber(
//              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//              child: myAppBar.SliverAppBar(
//                pinned: true,
//                expandedHeight: 120.0,
//                primary: true,
//                titleSpacing: 0.0,
//                centerTitle: true,
//                title: Text('排行榜'),
//                actions: <Widget>[
//                  GestureDetector(
//                    child: Icon(Icons.search),
//                    onTap: () {},
//                  )
//                ],
//                bottomTextString: _tabs,
//                bottom: myAppBar.AppBar(
//                  centerTitle: true,
//                  title: Row(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: _tabs.map((title) {
//                        return Chip(
//                          label: Text(
//                            title,
//                            style: TextStyle(color: Colors.green),
//                          ),
//                          backgroundColor: Colors.white,
//                        );
//                      }).toList()),
//                ),
//              ),
//            )
//          ];
//        },
//        body: null);
  }
}
