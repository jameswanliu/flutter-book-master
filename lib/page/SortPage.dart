import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/CategoryBean.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/redux/state/AppState.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';
import 'package:flutter_book_master/repertory/viewmodel/CategoryModel.dart';
import 'package:flutter_book_master/router/AppRouter.dart';
import 'package:flutter_book_master/widget/image/ThreeLaminatedImage.dart';
import 'package:flutter_redux/flutter_redux.dart';

//分类
class SortPage extends StatefulWidget {
  final List<String> sort = ['男生', '女生'];
  final index;

  SortPage(this.index);

  @override
  State<StatefulWidget> createState() => SortPageState();
}

class SortPageState extends State<SortPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var _controller;

  @override
  void initState() {
    super.initState();
    BookApiRepository.getInstance().getCategoryList();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var selectStyle = TextStyle(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
    var unselectedStyle = TextStyle(fontSize: 20, color: Colors.white);
    return StoreConnector<AppState, CategoryModel>(
      converter: (store) => CategoryModel(store),
      builder: (context, vm) {
        return vm.categoryBean == null
            ? Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              )
            : Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0.0,
                  title: TabBar(
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: selectStyle,
                      unselectedLabelStyle: unselectedStyle,
                      controller: _controller,
                      isScrollable: true,
                      tabs: widget.sort.map((title) {
                        return Tab(
                          child: Text(
                            title,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        );
                      }).toList()),
                ),
                body: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    MaleSortGridList(vm.categoryBean.male, 'male'),
                    MaleSortGridList(vm.categoryBean.female, 'female')
                  ],
                  controller: _controller,
                ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

///男生或者女生分类列表
class MaleSortGridList extends StatefulWidget {
  final male;
  final List<MaleBean> maleSortList;

  MaleSortGridList(this.maleSortList, this.male);

  @override
  State<StatefulWidget> createState() => MaleSortGridListState();
}

class MaleSortGridListState extends State<MaleSortGridList>
    with AutomaticKeepAliveClientMixin {
  _onItemClick(BuildContext context, String title, String male, String major) {
    Map<String, List<String>> parma = {
      'title': [title],
      'male': [male],
      'major': [major]
    };
    AppProvider.getRouter(context).navigateTo(
        context, AppRouter.generatePath(parma, CATEGORYBOOKLIST_PATH),
        transition: TransitionType.fadeIn);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: widget.maleSortList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.0, crossAxisSpacing: 1.0, crossAxisCount: 3),
        itemBuilder: (context, index) {
          return widget.maleSortList[index] != null
              ? InkWell(
                  onTap: () {
                    _onItemClick(context, widget.maleSortList[index].name,
                        widget.male, widget.maleSortList[index].name);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ThreeLaminatedImage(
                                    widget.maleSortList[index].bookCover, 40.0),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  widget.maleSortList[index].name,
                                  style: TextStyle(
                                      fontSize: 11.0, color: Colors.black87),
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  '${widget.maleSortList[index].bookCount}本',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 9.0),
                                )
                              ]))
                    ],
                  ),
                )
              : Container(
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
