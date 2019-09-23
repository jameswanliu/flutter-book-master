import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_book_master/bean/BannerResponse.dart';
import 'package:flutter_book_master/bean/RankRespone.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/redux/state/AppState.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/repertory/viewmodel/HomeModel.dart'
    show HomeViewModel;
import 'package:flutter_book_master/router/AppRouter.dart';
import 'package:flutter_book_master/widget/imageview_widget.dart';
import 'package:flutter_book_master/widget/sliverItemHeader.dart';
import 'package:flutter_book_master/widget/subject_mark_image_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transparent_image/transparent_image.dart';

class FavouritesBookPage extends StatefulWidget {
  final String title;
  final List<String> tabTitle = ['男频', '女频'];

  FavouritesBookPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FavouritesBookPageState();
}

class FavouritesBookPageState extends State<FavouritesBookPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController controller;
  int tabIndex = 0;
  var comingSoonChildAspectRatio;
  var itemW;

  @override
  void initState() {
    super.initState();
    print("FavouritesBookPage--");
    comingSoonChildAspectRatio = (70.0 / 100.0);
    controller = TabController(length: 2, vsync: this);
    BookApiRepository.getInstance().getBanner();
  }

  getSliverItem(vm, index) {
    return BannerView(vm.banners);
  }

  getTabBar() {
    var selectStyle = TextStyle(
        fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);
    var unselectedStyle = TextStyle(fontSize: 20.0, color: Colors.black45);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        TabBar(
          isScrollable: true,
          onTap: (index) {
            setState(() {
              tabIndex = index;
            });
          },
          indicatorColor: Colors.black87,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: selectStyle,
          controller: controller,
          unselectedLabelStyle: unselectedStyle,
          tabs: widget.tabTitle.map((title) {
            return Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16.0, color: Colors.black87),
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  _navigateTo(String id, String title) {
    Map<String, List<String>> parma = {
      'id': [id],
      'title': [title]
    };
    AppProvider.getRouter(context).navigateTo(
        context, AppRouter.generatePath(parma, BOOK_DETAIL_PAGE),
        transition: TransitionType.fadeIn);
  }

  //点击按钮
  rankSortGridItemOnClick(Female male) {}

  ///列表item
  rankTopItem(Map<String, dynamic> data, index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: () {
          _navigateTo(data['ranking']['books'][index]['_id'],
              data['ranking']['books'][index]['title']);
        },
        child: Padding(
            padding:
                EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0, bottom: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SubjectMarkImageWidget(
                  Constant.IMG_BASE_URL +
                      data['ranking']['books'][index]['cover'],
                  width: 77.0,
                  height: 110.0,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  data['ranking']['books'][index]['title'],
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.fade,
                  style: TextStyle(fontSize: 12.0, color: Colors.black),
                  maxLines: 1,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  data['ranking']['books'][index]['author'],
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

  double _getRadio() {
    return comingSoonChildAspectRatio;
  }

  ///首页列表
  getRankGoodList(vm, itemW) {
    Map<String, dynamic> malesTankGood = {};
    Map<String, dynamic> femalesTankGood = {};
    if (vm.maleRankGoodBooks != null && vm.maleRankGoodBooks.isNotEmpty) {
      malesTankGood = vm.maleRankGoodBooks;
    }

    if (vm.femaleRankGoodBooks != null && vm.femaleRankGoodBooks.isNotEmpty) {
      femalesTankGood = vm.femaleRankGoodBooks;
    }
    return malesTankGood.isEmpty || femalesTankGood.isEmpty
        ? SliverToBoxAdapter(
            child: Container(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ))
        : SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Offstage(
                      offstage: !(tabIndex == 1),
                      child: rankTopItem(femalesTankGood, index)),
                  Offstage(
                      offstage: !(tabIndex == 0),
                      child: rankTopItem(malesTankGood, index))
                ],
              );
            }, childCount: 6),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: _getRadio()),
          );
  }

  ///首页列表
  getRankTopList(vm, itemW) {
    Map<String, dynamic> malesTankTop = {};
    Map<String, dynamic> femalesTankTop = {};
    if (vm.maleRankTopBooks != null && vm.maleRankTopBooks.isNotEmpty) {
      malesTankTop = vm.maleRankTopBooks;
    }

    if (vm.femaleRankTopBooks != null && vm.femaleRankTopBooks.isNotEmpty) {
      femalesTankTop = vm.femaleRankTopBooks;
    }
    return malesTankTop.isEmpty || femalesTankTop.isEmpty
        ? SliverToBoxAdapter(
            child: Container(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          ))
        : SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Offstage(
                      offstage: !(tabIndex == 1),
                      child: rankTopItem(femalesTankTop, index)),
                  Offstage(
                      offstage: !(tabIndex == 0),
                      child: rankTopItem(malesTankTop, index))
                ],
              );
            }, childCount: 6),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: _getRadio()),
          );
  }

  ///跳转到排行榜列表
  _navigatorToRankList(String id, String title) {
    Map params = {
      'id': [id],
      'title': [id]
    };
    AppProvider.getRouter(context)
        .navigateTo(context, AppRouter.generatePath(params, RANK_LIST_PAGE));
  }

  ///女频男频分类
  getRankGrid(vm) {
    List<Male> males = List();
    if (vm.males != null) {
      males = vm.males;
    }
    List<Female> females = List();

    if (vm.females != null) {
      females = vm.females;
    }
    if (males != null && females != null) {
      return SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            var male;
            var female;
            if (males.length > 0) {
              male = males[index];
            }
            if (females.length > 0) {
              female = females[index];
            }
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Offstage(
                    offstage: !(tabIndex == 1 &&
                        females != null &&
                        females.length != 0),
                    child: InkWell(
                      onTap: () {
                        _navigatorToRankList(female.title, female.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: Constant.IMG_BASE_URL + male.cover,
                            width: 35.0,
                            height: 35.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            male.shortTitle,
                            style: TextStyle(fontSize: 10.0),
                          )
                        ],
                      ),
                    )),
                Offstage(
                    offstage:
                        !(tabIndex == 0 && males != null && males.length != 0),
                    child: InkWell(
                      onTap: () {
                        _navigatorToRankList(male.title, male.id);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: Constant.IMG_BASE_URL + female.cover,
                            width: 35.0,
                            height: 35.0,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            female.shortTitle,
                            style: TextStyle(fontSize: 10.0),
                          )
                        ],
                      ),
                    )),
              ],
            );
          }, childCount: math.min(males.length, 5)),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    itemW = 80.0;
    return StoreConnector<AppState, HomeViewModel>(
      converter: (store) => HomeViewModel(store),
      builder: (context, vm) {
        return SafeArea(
            top: false,
            bottom: false,
            child: Builder(builder: (context) {
              return Container(
                color: Colors.white,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            ((BuildContext context, int index) {
                      return getSliverItem(vm, index);
                    }), childCount: 1)),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 10.0,
                      ),
                    ),
                    getRankGrid(vm),
                    SliverToBoxAdapter(
                      child: SliverItemHeader(
                        '重磅推荐',
                        leftSizeBoxSize: 10.0,
                        rightSizeBoxSize: 10.0,
                      ),
                    ),
                    getRankTopList(vm, itemW),
                    SliverToBoxAdapter(
                      child: SliverItemHeader(
                        '好评小说',
                        leftSizeBoxSize: 10.0,
                        rightSizeBoxSize: 10.0,
                      ),
                    ),
                    getRankGoodList(vm, itemW),
                  ],
                ),
              );
            }));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BannerView extends StatelessWidget {
  final List<Data> banners;

  BannerView(this.banners);

  _navigateTo(context, String id, String title) {
    Map<String, List<String>> parma = {
      'id': [id],
      'title': [title]
    };
    AppProvider.getRouter(context).navigateTo(
        context, AppRouter.generatePath(parma, BOOK_DETAIL_PAGE),
        transition: TransitionType.inFromRight);
  }

  @override
  Widget build(BuildContext context) {
    double height =
        AppProvider.of(context).application.screenUtil.setHeight(360);
    return banners.isEmpty
        ? Container(
            height: height,
          )
        : Container(
            height: height,
            child: Swiper(
              onTap: (index) {
                _navigateTo(context, banners[index].link, banners[index].title);
              },
              itemCount: banners.length,
              itemBuilder: (context, index) => Container(
                child: Image.network(
                  banners[index].img,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
  }
}
