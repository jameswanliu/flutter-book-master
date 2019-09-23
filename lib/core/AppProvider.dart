import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_book_master/application/BookApplication.dart';

class AppProvider<S> extends InheritedWidget {
  final BookApplication application;

  AppProvider({Key key, Widget child, this.application})
      : super(key: key, child: child);

  static AppProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider);
  }

  static BookApplication getBookApplication(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
        .application;
  }

  static Router getRouter(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppProvider) as AppProvider)
        .application
        .router;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
