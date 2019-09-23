import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function submit;

  final String placehold;

  final bool isEnable;

  SearchBar({this.submit, this.placehold = '搜索书名或作者', this.isEnable});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      //ConstrainedBox 加入prefixIcon 可以定义最小高度和最大高度
      constraints: BoxConstraints(maxHeight: 28.0),
      child: TextField(
        enabled: isEnable,
        textDirection: TextDirection.ltr,
        maxLines: 1,
        decoration: InputDecoration(
            contentPadding:
                EdgeInsets.only(left: 1.0, top: 4.0, right: 1.0, bottom: 4.0),
            labelStyle: TextStyle(fontSize: 13.0, color: Colors.black12),
            hintStyle: TextStyle(fontSize: 13.0, color: Colors.grey),
            prefixIcon: Icon(
              Icons.search,
              size: 16.0,
            ),
            hintText: placehold,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(80.0))),
            filled: true,
            fillColor: Colors.white),
        onSubmitted: submit,
      ),
    );
  }
}
