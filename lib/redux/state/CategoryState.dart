import 'package:flutter_book_master/bean/CategoryBean.dart';

class CategoryState {
  CategoryBean categoryBean;

  bool isLoading;

  CategoryState({this.categoryBean, this.isLoading});

  CategoryState copyWith({CategoryBean categoryBean, bool isLoading}) {
    return CategoryState(
        categoryBean: categoryBean ?? this.categoryBean, isLoading: isLoading);
  }

  CategoryState.initState() {
    categoryBean = null;
  }
}
