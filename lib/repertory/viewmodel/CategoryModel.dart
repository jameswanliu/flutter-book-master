import 'package:flutter_book_master/bean/CategoryBean.dart';
import 'package:flutter_book_master/redux/state/AppState.dart';
import 'package:flutter_book_master/repertory/viewmodel/ViewModel.dart';
import 'package:redux/redux.dart';

class CategoryModel extends ViewModel {
  CategoryModel(Store<AppState> store) : super(store: store);

  bool get isLoading => store.state.categoryState.isLoading;
  CategoryBean get categoryBean => store.state.categoryState.categoryBean;
}
