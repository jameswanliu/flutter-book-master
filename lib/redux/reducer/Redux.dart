import 'package:flutter_book_master/redux/state/AppState.dart';
import 'home.dart' as home;
import 'Category.dart' as categoryState;

AppState redux(AppState state, action) => AppState(
    homeSate: home.homeRedux(state.homeSate, action),
    categoryState: categoryState.categoryReudx(state.categoryState, action));
