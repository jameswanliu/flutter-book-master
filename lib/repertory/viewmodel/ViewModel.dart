import 'package:flutter_book_master/redux/state/AppState.dart';
import 'package:flutter_book_master/redux/state/HomeState.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_book_master/redux/state/CategoryState.dart';
import 'package:flutter_book_master/redux/reducer/Redux.dart';
import 'package:redux/redux.dart';

abstract class ViewModel {
  Store<AppState> store;

  ViewModel({this.store});
}

class StoreContainer {
  static final Store<AppState> global = initStore();
}

Store initStore() => Store<AppState>(redux,
    initialState: AppState(
        homeSate: HomeSate.initState(),
        categoryState: CategoryState.initState()));
