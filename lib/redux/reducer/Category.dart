import 'package:flutter_book_master/redux/action/ActionType.dart';
import 'package:flutter_book_master/redux/state/CategoryState.dart';
import 'package:flutter_book_master/redux/action/category.dart'
    show CategoryList;

CategoryState categoryReudx(CategoryState state, ActionType action) {
  if (action is CategoryList) {
    return state.copyWith(categoryBean: action.action);
  }
  return state;
}
