import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/BottomItemBean.dart';
import 'package:flutter_book_master/page/SortPage.dart';
import 'PersonalPage.dart';
import 'CommunityPage.dart';
import 'BookShelvesPage.dart';
import 'BookStorePage.dart';
import 'package:flutter_book_master/core/AppProvider.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  PageController _pageController;

  final items = [
    BottomItem(
        title: '书架',
        icon: Image.asset(
          'assets/images/ic_tab_subject_normal.png',
          width: 26,
          height: 26,
        ),
        activeIcon: Image.asset(
          'assets/images/ic_tab_subject_active.png',
          width: 26,
          height: 26,
        )),
    BottomItem(
        title: '书城',
        icon: Image.asset(
          'assets/images/ic_tab_home_normal.png',
          width: 26,
          height: 26,
        ),
        activeIcon: Image.asset(
          'assets/images/ic_tab_home_active.png',
          width: 26,
          height: 26,
        )),
    BottomItem(
        title: '排行榜',
        icon: Image.asset(
          'assets/images/ic_tab_shiji_normal.png',
          width: 26,
          height: 26,
        ),
        activeIcon: Image.asset(
          'assets/images/ic_tab_shiji_active.png',
          width: 26,
          height: 26,
        )),
    BottomItem(
        title: '我的',
        icon: Image.asset(
          'assets/images/ic_tab_profile_normal.png',
          width: 26,
          height: 26,
        ),
        activeIcon: Image.asset(
          'assets/images/ic_tab_profile_active.png',
          width: 26,
          height: 26,
        ))
  ];

  final widgets = [
    BookShelvesPage(),
    BookStoresPage(),
    CommunityPage(),
    PersonalPage()
  ];

  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController =
        new PageController(initialPage: _currentPage, keepPage: true);
  }

  _pageChange(index) {
    setState(() {
      if (_currentPage == index) return;
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppProvider.of(context).application.screenUtil.init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentPage,
          onTap: (index) {
            _pageController.jumpToPage(index);
            _pageChange(index);
          },
          type: BottomNavigationBarType.fixed,
          items: items
              .map((item) => BottomNavigationBarItem(
                  icon: item.icon,
                  title: Text(item.title),
                  activeIcon: item.activeIcon))
              .toList()),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: widgets,
        controller: _pageController,
      ),
    );
  }
}
