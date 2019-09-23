import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/BannerResponse.dart';
import 'package:flutter_book_master/bean/RankRespone.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/redux/state/AppState.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/repertory/viewmodel/HomeModel.dart';
import 'package:flutter_book_master/router/AppRouter.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:math' as math;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transparent_image/transparent_image.dart';

class ConcentrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ConcentrationPageState();
}

class ConcentrationPageState extends State<ConcentrationPage> {
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    BookApiRepository.getInstance().getBanner();
    BookApiRepository.getInstance().getRankGender();
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
      return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 5),
          itemBuilder: (_, index) {
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
          });

//      return SliverGrid(
//          delegate: SliverChildBuilderDelegate((context, index) {
//            var male;
//            var female;
//            if (males.length > 0) {
//              male = males[index];
//            }
//            if (females.length > 0) {
//              female = females[index];
//            }
//            return Stack(
//              alignment: Alignment.center,
//              children: <Widget>[
//                Offstage(
//                    offstage: !(tabIndex == 1 &&
//                        females != null &&
//                        females.length != 0),
//                    child: InkWell(
//                      onTap: () {
//                        _navigatorToRankList(female.title, female.id);
//                      },
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          FadeInImage.memoryNetwork(
//                            placeholder: kTransparentImage,
//                            image: Constant.IMG_BASE_URL + male.cover,
//                            width: 35.0,
//                            height: 35.0,
//                            fit: BoxFit.cover,
//                          ),
//                          SizedBox(height: 5.0),
//                          Text(
//                            male.shortTitle,
//                            style: TextStyle(fontSize: 10.0),
//                          )
//                        ],
//                      ),
//                    )),
//                Offstage(
//                    offstage:
//                        !(tabIndex == 0 && males != null && males.length != 0),
//                    child: InkWell(
//                      onTap: () {
//                        _navigatorToRankList(male.title, male.id);
//                      },
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          FadeInImage.memoryNetwork(
//                            placeholder: kTransparentImage,
//                            image: Constant.IMG_BASE_URL + female.cover,
//                            width: 35.0,
//                            height: 35.0,
//                            fit: BoxFit.cover,
//                          ),
//                          SizedBox(height: 10.0),
//                          Text(
//                            female.shortTitle,
//                            style: TextStyle(fontSize: 10.0),
//                          )
//                        ],
//                      ),
//                    )),
//              ],
//            );
//          }, childCount: math.min(males.length, 5)),
//          gridDelegate:
//              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5));
    }
  }

  _bulidBody() {
    return StoreConnector<AppState, HomeViewModel>(
      converter: (store) => HomeViewModel(store),
      builder: (_, vm) {
        return SafeArea(
            bottom: false,
            top: false,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  BannerView(vm.banners),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _bulidBody();
  }
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
    return Container(
      height: AppProvider.of(context).application.screenUtil.setHeight(360),
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
