import 'package:flutter/material.dart';

///分类榜单列表
class RankingList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RankingListState();
}

class RankingListState extends State<RankingList>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> indexSort = ['周榜', '月榜', '总榜'];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: indexSort.length, vsync: this);
  }

  _buildBody() {
    var selectStyle = TextStyle(fontSize: 13, color: Colors.black87);
    var unselectedStyle = TextStyle(fontSize: 13, color: Colors.black54);
    return Stack(
      children: <Widget>[
        Container(
          height: 25.0,
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
                  style: TextStyle(fontSize: 13.0, color: Colors.black87),
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: TabBarView(
              controller: _tabController,
              physics: BouncingScrollPhysics(),
              children: [],
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class RankPage extends StatefulWidget {

  String id;
  RankPage(this.id);

  @override
  State<StatefulWidget> createState() => RankPageState();
}

class RankPageState extends State<RankPage> {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
