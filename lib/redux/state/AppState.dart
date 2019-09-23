
import 'package:flutter/material.dart';
import 'package:flutter_book_master/redux/state/CategoryState.dart';
import 'package:flutter_book_master/redux/state/HomeState.dart';
class AppState {
  HomeSate homeSate;
  CategoryState categoryState;
  AppState({this.homeSate,this.categoryState});


}
