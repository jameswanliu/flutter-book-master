import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_book_master/page/IndexPage.dart';
import 'package:flutter_book_master/page/SortPage.dart';
import 'package:flutter_book_master/page/book_detail_page.dart';
import 'package:flutter_book_master/page/book_list_detail_page.dart';
import 'package:flutter_book_master/page/catory_sort_list.dart';
import 'package:flutter_book_master/page/rank_books_list.dart';

///路由
class AppRouter {
  static initRouter(Router router) {
    if (router != null) {
      router.define(INDEXPAGE_PATH, handler: rootHandler);
      router.define(CATEGORYBOOKLIST_PATH, handler: categoryBookListHander);
      router.define(BOOK_DETAIL_PAGE, handler: bookDetailHander);
      router.define(BOOK_LIST_PAGE, handler: bookListHander);
      router.define(RANK_LIST_PAGE, handler: rankListHandler);
      router.define(SORT_PAGE, handler: sortHandler);
    } else {
      throw Exception('router is null');
    }
  }

  static String generatePath(Map<String, dynamic> parma, String path) {
    Uri uri = Uri(path: path, queryParameters: parma);
    return uri.toString();
  }
}

const CATEGORYBOOKLIST_PATH = 'CATEGORYBOOKLIST_PATH';
const INDEXPAGE_PATH = '/';
const BOOK_DETAIL_PAGE = 'BOOK_DETAIL_PAGE';
const BOOK_LIST_PAGE = 'BOOK_LIST_PAGE'; //书单详情
const RANK_LIST_PAGE = 'BOOK_LIST_PAGE'; //排行榜列表
const SORT_PAGE = 'SORT_PAGE';//分类

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return IndexPage();
});

var categoryBookListHander = Handler(handlerFunc: (context, params) {
  return CategoryBookList(
      params['title'][0], params['male'][0], params['major'][0]);
});
var bookDetailHander = Handler(handlerFunc: (context, params) {
  return BookDetailPage(params['id'][0], params['title'][0]);
});

///书单详情
var bookListHander = Handler(handlerFunc: (context, params) {
  return BookListDetail(params['id'][0]);
});

///排行榜列表
var rankListHandler = Handler(handlerFunc: (context, params) {
  return RankBookList(params['title'][0], params['id'][0]);
});

var sortHandler = Handler(handlerFunc: (context, params) {
  return SortPage(0);
});
