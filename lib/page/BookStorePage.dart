import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/event/GenderSelectEvent.dart';
import 'package:flutter_book_master/page/FavouritesBookPage.dart';
import 'package:flutter_book_master/page/MaleBookPage.dart';
import 'package:flutter_book_master/page/all_ranking_list_page.dart';
import 'package:flutter_book_master/redux/action/home.dart';
import 'package:flutter_book_master/redux/state/AppState.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/repertory/viewmodel/HomeModel.dart';
import 'package:flutter_book_master/repertory/viewmodel/ViewModel.dart';
import 'package:flutter_book_master/router/AppRouter.dart';
import 'package:flutter_book_master/utils/Constant.dart';
import 'package:flutter_book_master/utils/Preference.dart';
import 'package:flutter_book_master/widget/search_text_field_widget.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'book_list_page.dart';

class BookStoresPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BookStoresPageState();
}

class BookStoresPageState extends State<BookStoresPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<String> indexSort = ['精选', '榜单', '书单'];
  TabController _tabController;

  String maleValue = '男生';

  String gobaleGender = '';

  void touchTextField() {}

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    BookApiRepository.getInstance().getRankGender();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _buildAction() {
    return GestureDetector(
      onTap: () {
        AppProvider.getRouter(context).navigateTo(
            context, AppRouter.generatePath(null, SORT_PAGE),
            transition: TransitionType.inFromRight);
      },
      child: Row(
        children: <Widget>[
          Text(
            '分类',
            style: TextStyle(fontSize: 13.0, color: Colors.white),
          ),
          SizedBox(
            width: 10.0,
          )
        ],
      ),
    );
  }

  _buildLeading() {
    return GestureDetector(
        onTap: () {
          _buildPopwindow();
        },
        child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  maleValue,
                  style: TextStyle(fontSize: 13.0, color: Colors.white),
                ),
                SizedBox(
                  width: 3.0,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 12.0,
                  color: Colors.white,
                )
              ],
            )));
  }

  _buildPopwindow() {
    return PopupMenuButton<String>(
        elevation: 0.0,
        offset: Offset(20.0, 35.0),
        child: _buildLeading(),
        onSelected: (value) {
          setState(() {
            if (value == maleValue) return;
            maleValue = value;
          });
        },
        onCanceled: () {},
        itemBuilder: (_) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem(
                value: '男生',
                child: Text(
                  '男生',
                  style: TextStyle(fontSize: 12.0, color: Colors.black87),
                )),
            PopupMenuItem(
                value: '女生',
                child: Text(
                  '女生',
                  style: TextStyle(fontSize: 12.0, color: Colors.black87),
                ))
          ];
        });
  }

  _buildBody(vm) {
    var selectStyle = TextStyle(fontSize: 14, color: Colors.black87);
    var unselectedStyle = TextStyle(fontSize: 14, color: Colors.black54);
    return Stack(
      children: <Widget>[
        Container(
          height: 30.0,
          color: Colors.white,
          child: TabBar(
            indicatorColor: Colors.deepOrangeAccent,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: unselectedStyle,
            labelStyle: selectStyle,
            controller: _tabController,
            // These are the widgets to put in each tab in the tab bar.
            tabs: indexSort.map((name) {
              return Padding(
                padding: EdgeInsets.only(bottom: 2.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 15.0, color: Colors.black87),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: TabBarView(
              controller: _tabController,
              physics: BouncingScrollPhysics(),
              children: [
                FavouritesBookPage(title: indexSort[0]),
                RankingListPage(vm.maleRankIds),
                BookListPage()
              ],
            )),
      ],
    );
  }

  _builderWidget() {
    return StoreConnector<AppState, HomeViewModel>(
      converter: (store) => HomeViewModel(store),
      builder: (_, vm) {
        return Scaffold(
            appBar: AppBar(
              leading: _buildPopwindow(),
              actions: [_buildAction()],
              centerTitle: true,
              elevation: 0.0,
              title: SearchTextFieldWidget(
                hintText: '输入您想看的小说书籍',
                onTab: () {
                  touchTextField();
                },
              ),
            ),
            body: _buildBody(vm));
      },
    );
  }

  void _sendGenderEvent(String gender) {
    Preference.getInstance().setString(PRE_GENDER_KEY, gender);
    EventBus eventBus = EventBus();
    eventBus.fire(GenderSelectEvent(gender));
  }

  void _getGenderFromSp() {
    Preference.getInstance().getString(PRE_GENDER_KEY).then((gender) {
      if (gender == null || gender.isEmpty) {
        showDialog(
            context: context,
            child: AlertDialog(
              title: Text(
                '请选择您的性别',
                style: TextStyle(fontSize: 14.0, color: Colors.black),
              ),
              content: Text(
                '根据您的性别为您推送精彩内容',
                style: TextStyle(fontSize: 13.0, color: Colors.black54),
              ),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _sendGenderEvent('女生');
                    },
                    child: Text(
                      '女生',
                      style: TextStyle(fontSize: 13.0, color: Colors.black87),
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _sendGenderEvent('女生');
                    },
                    child: Text(
                      '男生',
                      style: TextStyle(fontSize: 13.0, color: Colors.black87),
                    ))
              ],
            ));
      } else {
        _sendGenderEvent(gender);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _getGenderFromSp();
    return _builderWidget();
  }

  @override
  bool get wantKeepAlive => true;
}
