import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class LoadingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }

}