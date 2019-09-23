import 'package:flutter/material.dart';

class LibFiltGroupBar extends StatefulWidget {
  final Function function;

  final List<String> childern;

  LibFiltGroupBar({Key key, this.function, this.childern}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LibFiltGroupBarState();
}

class LibFiltGroupBarState extends State<LibFiltGroupBar> {
  int _select = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 30.0,
        child: Row(
          //Expanded 必须在Row ，Colum，Flex 中使用
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: widget.childern.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final textStyle = _select == index
                          ? TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue)
                          : TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black38);
                      return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10.0),
                            child: Text(
                              widget.childern[index],
                              style: textStyle,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_select == index) return;
                              setState(() {
                                _select = index;
                                widget.function(widget.childern[index]);
                              });
                            });
                          });
                    }))
          ],
        ));
  }
}
