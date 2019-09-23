import 'package:flutter/material.dart';
import 'package:flutter_book_master/application/BookApplication.dart';
import 'package:flutter_book_master/core/AppProvider.dart';
import 'package:flutter_book_master/page/IndexPage.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_book_master/repertory/viewmodel/ViewModel.dart';

class AppComponent extends StatefulWidget {
  final BookApplication _bookApplication;

  AppComponent(this._bookApplication);

  @override
  State<StatefulWidget> createState() => AppComponentSate(_bookApplication);
}

class AppComponentSate extends State<AppComponent> {
  BookApplication _bookApplication;

  AppComponentSate(this._bookApplication);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _bookApplication.onTerminate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreContainer.global;
    final app = MaterialApp(
      title: 'book',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _bookApplication.router.generator,
    );
    final appProvider = AppProvider(child: app,application: _bookApplication);
    return StoreProvider(store: store, child: appProvider);
  }
}
