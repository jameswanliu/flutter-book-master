import 'package:flutter/material.dart';
import 'package:flutter_book_master/bean/BottomItemBean.dart';

class BottomNavigation extends StatelessWidget {
  final items = [
    BottomItem(title: '书架', icon: Icon(Icons.border_outer)),
    BottomItem(title: '书城', icon: Icon(Icons.bookmark)),
    BottomItem(title: '社区', icon: Icon(Icons.comment)),
    BottomItem(title: '我的', icon: Icon(Icons.person))
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: _selectPage,
        type: BottomNavigationBarType.fixed,
        items: items.map((item) {
          return BottomNavigationBarItem(
              icon: item.icon, title: Text(item.title));
        }).toList());
  }

  void _selectPage(index) {}
}
