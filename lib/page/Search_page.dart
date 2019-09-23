import 'package:flutter/material.dart';
import 'package:flutter_book_master/widget/search_text_field_widget.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  buildBody() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: buildTitleTip(),
        )
      ],
    );
  }
  
  
//  bulidFlow(){
//
//    return Flow(delegate: FlowDelegate)
//  }

  buildTitleTip() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            '大家都在搜',
            style: TextStyle(fontSize: 13.0, color: Colors.grey),
          )),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.refresh,
                  color: Colors.grey,
                  size: 12.0,
                ),
                Text(
                  '换一批',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: SearchTextFieldWidget(),
      ),
      body: buildBody(),
    );
  }
}
