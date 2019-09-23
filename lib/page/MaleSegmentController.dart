import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_book_master/bean/RankRespone.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_book_master/redux/state/AppState.dart';
import 'package:flutter_book_master/repertory/viewmodel/HomeModel.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/repertory/BookApiRepository.dart';

//男频女频控制器
class MaleSegmentController extends StatefulWidget {
  MaleSegmentController();

  @override
  State<StatefulWidget> createState() => MaleSegmentControllerState();
}

class MaleSegmentControllerState extends State<MaleSegmentController> {
  Map<int, Widget> _children = {0: Text('男频'), 1: Text('女频')};
  int _groupValue = 0;

  List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    BookApiRepository.getInstance().getRankGender();
    widgets = [RankSortMaleGrid(), RankSortFeMaleGrid()];
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
        builder: (context, vm) {
          return CupertinoPageScaffold(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 120,
                  child: CupertinoSegmentedControl(
                      children: _children,
                      groupValue: _groupValue,
                      selectedColor: Colors.black87,
                      borderColor: Colors.black87,
                      onValueChanged: onSegmentControllerChanger),
                ),
                widgets[_groupValue],
                vm.males == null || vm.females == null
                    ? Container()
                    : RankBookList(
                        _groupValue == 0 ? vm.males[1].id : vm.females[1].id),
              ],
            ),
          );
        },
        converter: (store) => HomeViewModel(store));
  }

  onSegmentControllerChanger(index) {
    if (index == _groupValue) return;
    setState(() {
      _groupValue = index;
    });
  }
}

class RankSortMaleGrid extends StatefulWidget {
  RankSortMaleGrid();

  @override
  State<StatefulWidget> createState() => RankSortMaleGridState();
}

class RankSortFeMaleGrid extends StatefulWidget {
  RankSortFeMaleGrid();

  @override
  State<StatefulWidget> createState() => RankSortFeMaleGridState();
}

class RankSortFeMaleGridState extends State<RankSortFeMaleGrid> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(builder: (context, vm) {
      return vm.females == null || vm.females.isEmpty
          ? Container()
          : SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return InkWell(
                  onTap: rankSortGridItemOnClick(vm.females[index]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: Constant.IMG_BASE_URL + vm.females[index].cover,
                        width: 35.0,
                        height: 35.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        vm.females[index].shortTitle,
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                );
              }, childCount: vm.females.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: vm.females.length));
    }, converter: (store) {
      return HomeViewModel(store);
    });
  }

  //点击按钮
  rankSortGridItemOnClick(Female male) {}
}

class RankSortMaleGridState extends State<RankSortMaleGrid> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(builder: (context, vm) {
      return vm.males == null || vm.males.isEmpty
          ? Container()
          : SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return InkWell(
                  onTap: rankSortGridItemOnClick(vm.males[index]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: Constant.IMG_BASE_URL + vm.males[index].cover,
                        width: 35.0,
                        height: 35.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        vm.males[index].shortTitle,
                        style: TextStyle(fontSize: 10.0),
                      )
                    ],
                  ),
                );
              }, childCount: vm.males.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: vm.males.length));
    }, converter: (store) {
      return HomeViewModel(store);
    });
  }

  //点击按钮
  rankSortGridItemOnClick(Male male) {}
}

class RankBookList extends StatefulWidget {
  final String id;

  RankBookList(this.id);

  @override
  State<StatefulWidget> createState() => RankBookListState();
}

class RankBookListState extends State<RankBookList> {
  @override
  void initState() {
    super.initState();
    print('id = ' + widget.id);
    BookApiRepository.getInstance().getMaleRankTop(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
        builder: (context, vm) {
          return vm.maleRankTopBooks == null
              ? Container()
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: InkWell(
                        onTap: maleRankTopBooksItemOnclick(vm.maleRankTopBooks),
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
                                    image: Constant.IMG_BASE_URL +
                                        vm.maleRankTopBooks['ranking']['books']
                                            [index]['cover']),
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
                                                  vm.maleRankTopBooks['ranking']
                                                      ['books'][index]['title'],
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Text(
                                                  vm.maleRankTopBooks['ranking']
                                                          ['books'][index]
                                                      ['shortIntro'],
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
                                                    vm.maleRankTopBooks[
                                                            'ranking']['books']
                                                        [index]['author'],
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10.0),
                                                  ),
                                                  SizedBox(
                                                    width: 20.0,
                                                  ),
                                                  Text(
                                                    '人气 :${vm.maleRankTopBooks['ranking']['books'][index]['latelyFollower']}',
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
                  },
                  itemCount: vm.maleRankTopBooks == null
                      ? 0
                      : (vm.maleRankTopBooks['ranking']['books'] as List)
                          .length,
                );
        },
        converter: (store) => HomeViewModel(store));
  }

  maleRankTopBooksItemOnclick(Map<String, dynamic> malesMap) {}
}
