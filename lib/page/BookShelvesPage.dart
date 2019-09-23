import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/book_shelves_resp.dart';
import 'package:flutter_book_master/event/GenderSelectEvent.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/utils/Constant.dart';
import 'package:flutter_book_master/utils/Preference.dart';
import 'package:flutter_book_master/widget/loading_widget.dart';
import 'package:flutter_book_master/widget/no_data_widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:transparent_image/transparent_image.dart';

class BookShelvesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BookShelvesPageState();
}

class BookShelvesPageState extends State<BookShelvesPage>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = true;
  GlobalKey<RefreshHeaderState> _footerKey = GlobalKey<RefreshHeaderState>();
  List<BookShelveBean> list = [];
  StreamSubscription _loginSubscription;

  @override
  void initState() {
    super.initState();
    _queryData();
    _receiverEvent();
  }

  @override
  void dispose() {
    _loginSubscription.cancel();
    super.dispose();
  }

  ///接收性别选择事件
  _receiverEvent() {
    EventBus eventBus = EventBus();
    _loginSubscription = eventBus.on<GenderSelectEvent>().listen((event) {
      if (event.gender.isNotEmpty) {
        print("gender===> " + event.gender);
        _getData(event.gender);
      }
    });
  }

  _queryData() {
    Preference.getInstance().getString(PRE_GENDER_KEY).then((gender) {
      if (gender != null && gender.isNotEmpty) {
        _getData(gender);
      }
    });
  }

  _getData(gender) {
    BookApiRepository.getInstance().getRecommondBookList(gender).then((data) {
      setState(() {
        if (data != null) list.addAll(data);
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
              refreshHeader: ClassicsHeader(
                key: _footerKey,
                refreshedText: '下拉刷新',
                refreshingText: '正在刷新中...',
                refreshReadyText: '释放加载',
                bgColor: Colors.grey[50],
                textColor: Colors.black54,
              ),
              child: ListView.builder(
                  itemCount: list.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    BookShelveBean bean = list[index];
                    return Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 1.0),
                      child: InkWell(
                        onTap: () {},
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
                                        top: 4.0,
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
                                                  height: 8.0,
                                                ),
                                                Text(
                                                  '最新:\t${bean.lastChapter}',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black38),
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.access_time,
                                                      size: 12.0,
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Text(
                                                      DateTime.parse(
                                                              bean.updated)
                                                          .toString().substring(0,10),
                                                      style: TextStyle(
                                                          fontSize: 11.0,
                                                          color: Colors.grey),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          '我的书架',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.search,
              size: 22.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 18.0,
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.add,
              size: 22.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: _buildListView(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
