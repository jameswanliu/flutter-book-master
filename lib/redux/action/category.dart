
import 'package:flutter_book_master/bean/CategoryBean.dart';
import 'package:flutter_book_master/redux/action/ActionType.dart';

class CategoryList extends ActionType {
  CategoryBean payload;
  CategoryList(this.payload) : super(action: payload);
}
