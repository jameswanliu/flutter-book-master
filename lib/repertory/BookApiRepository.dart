import 'package:flutter_book_master/bean/RankRespone.dart';
import 'package:flutter_book_master/bean/book_detail_page.dart';
import 'package:flutter_book_master/bean/book_hot_review.dart';
import 'package:flutter_book_master/bean/book_list_recommond.dart';
import 'package:flutter_book_master/bean/book_list_detail_resp.dart';
import 'package:flutter_book_master/bean/book_list_resp.dart';
import 'package:flutter_book_master/bean/book_shelves_resp.dart';
import 'package:flutter_book_master/bean/male_prise_book.dart';
import 'package:flutter_book_master/bean/ranking_list.dart';
import 'package:flutter_book_master/redux/action/ActionType.dart';
import 'package:flutter_book_master/redux/action/category.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_book_master/bean/BookBean.dart' show BookBean;

import 'package:flutter_book_master/repertory/api/ApiProvider.dart';
import 'package:flutter_book_master/repertory/viewmodel/ViewModel.dart';
import 'package:flutter_book_master/redux/action/home.dart'
    show
        CategoryList,
        FemaleEndBookList,
        FemaleHotBookList,
        FemaleNewBookList,
        FemalePriaseBookList,
        FemaleRank,
        FemaleRankAction,
        FemaleRankGoodBookAction,
        FemaleRankTopBookAction,
        FemaleReputationBookList,
        MaleEndBookList,
        MaleHotBookList,
        MaleNewBookList,
        MalePriaseBookList,
        MaleRank,
        MaleRankAction,
        MaleRankGoodBookAction,
        MaleRankTopBookAction,
        MaleReputationBookList,
        UpdateBanner;
import 'dart:convert';

class BookApiRepository {
  ApiProvider _apiProvider;

  BookApiRepository() {
    _apiProvider = ApiProvider();
  }

  static BookApiRepository _instance;

  static BookApiRepository getInstance() {
    if (_instance == null) {
      _instance = BookApiRepository();
    }
    return _instance;
  }

  getRankGender() {
    return Observable.fromFuture(_apiProvider.getRankGender()).listen((data) {
      print("---------getRankGender------------");
      _updateFemale(data);
    });
  }

  ///获取男频最受好评的书籍
  getMaleRankGood(String id) {
    return Observable.fromFuture(_apiProvider.getRankBook(id)).listen((data) {
      Map<String, dynamic> rankMaleGoodBooks = jsonDecode(data) as Map;
      print('--getMaleRankTop--' + rankMaleGoodBooks.toString());
      StoreContainer.global.dispatch(MaleRankGoodBookAction(rankMaleGoodBooks));
    });
  }

  ///获取男频排名前100的书籍
  getMaleRankTop(String id) {
    return Observable.fromFuture(_apiProvider.getRankBook(id)).listen((data) {
      Map<String, dynamic> rankMaleTopBooks = jsonDecode(data) as Map;
      print('--getMaleRankTop--' + rankMaleTopBooks.toString());
      StoreContainer.global.dispatch(MaleRankTopBookAction(rankMaleTopBooks));
    });
  }

  ///获取女频最受好评的书籍
  getFeMaleRankGood(String id) {
    return Observable.fromFuture(_apiProvider.getRankBook(id)).listen((data) {
      Map<String, dynamic> rankFemaleGoodBooks = jsonDecode(data);
      StoreContainer.global
          .dispatch(FemaleRankGoodBookAction(rankFemaleGoodBooks));
    });
  }

  ///获取女频排名前100的书籍
  getFeMaleRankTop(String id) {
    return Observable.fromFuture(_apiProvider.getRankBook(id)).listen((data) {
      Map<String, dynamic> rankFemaleTopBooks = jsonDecode(data);
      StoreContainer.global
          .dispatch(FemaleRankTopBookAction(rankFemaleTopBooks));
    });
  }

  _updateFemale(Entity entity) {
    List<Female> females = [];
    List<Female> list = entity.female;
    List<Female> collapse = [];
    Map<String, String> femaleRankIds = {};
    list.forEach((f) {
      if (f.collapse) {
        // 折叠
        collapse.add(f);
      } else {
        females.add(f);
        femaleRankIds[f.shortTitle] = f.id;
      }
    });
    if (collapse.length > 0) {}
    BookApiRepository.getInstance().getFeMaleRankTop(females[0].id);
    BookApiRepository.getInstance().getFeMaleRankGood(females[1].id);
    StoreContainer.global.dispatch(FemaleRankAction(females));
    StoreContainer.global.dispatch(FemaleRank(femaleRankIds)); //更新榜单id map
    List<Male> males = [];

    Map<String, String> maleRankIds = {};
    List<Male> maleList = entity.male;

    List<Male> maleCollapse = [];

    maleList.forEach((male) {
      if (male.collapse) {
        maleCollapse.add(male);
      } else {
        males.add(male);
        maleRankIds[male.shortTitle] = male.id;
      }

      if (maleCollapse.length > 0) {}
    });
    BookApiRepository.getInstance().getMaleRankTop(males[0].id);
    BookApiRepository.getInstance().getMaleRankGood(males[1].id);
    StoreContainer.global.dispatch(MaleRankAction(males));
    StoreContainer.global.dispatch(MaleRank(maleRankIds)); //更新榜单id map
  }

  getBanner() {
    Observable.fromFuture(_apiProvider.getBanner()).listen((data) {
      print("---------data------------");
      print(data);
      StoreContainer.global.dispatch(UpdateBanner(data));
    });
  }

  ///获取分类
  getCategoryList() {
    Observable.fromFuture(_apiProvider.getCategoryList()).listen((data) {
      print("------category-----");
      print(data);
      StoreContainer.global.dispatch(CategoryList(data));
    });
  }

  ///通过分类获取书籍列表0

  getBookListByCategory(String gender, String type, String major, String minor,
      int start, int limit) {
    Observable.fromFuture(_apiProvider.getBookByCategory(
            gender, type, major, minor, start, limit))
        .listen((data) {
      print(data);
      ActionType action;
      switch (type) {
        case 'new':
          action = gender == 'male'
              ? MaleNewBookList(data)
              : FemaleNewBookList(data);
          break;
        case 'reputation':
          action = gender == 'male'
              ? MaleReputationBookList(data)
              : FemaleReputationBookList(data);
          break;
        case 'hot': //热门 MaleHotBookList
          action = gender == 'male'
              ? MaleHotBookList(data)
              : FemaleHotBookList(data);
          break;
        case 'over': //完结
          action = gender == 'male'
              ? MaleEndBookList(data)
              : FemaleEndBookList(data);
          break;
      }
      StoreContainer.global.dispatch(action);
    });
  }

  ///type 性别 0 是男生 1是女生，id
  getPriaseBookList(int type, String id) {
    Observable.fromFuture(_apiProvider.getPriaseBookList(id)).listen((data) {
      ActionType actionType;
      switch (type) {
        case 0:
          actionType = MalePriaseBookList(data);
          break;
        case 1:
          actionType = FemalePriaseBookList(data);
          break;
      }
      StoreContainer.global.dispatch(actionType);
    });
  }

  ///获取排行榜列表
  Future<RankBean> getRankBookList(String id) async {
    return await _apiProvider.getPriaseBookList(id);
  }

  ///根据分类列表获取书籍
  Future<List<BookBean>> getCategoryBookList(String gender, String type,
      String major, String minor, int start, int limit) {
    return _apiProvider.getBookByCategory(
        gender, type, major, minor, start, limit);
  }

  ///获取书籍详情
  Future<BookDetail> getBookDetail(String id) {
    return _apiProvider.getBookDetail(id);
  }

  ///书籍详情热门评论
  Future<List<ReviewBean>> getBookHotReviews(String id) {
    return _apiProvider.getBookHotReviews(id);
  }

  ///获取书籍详情里面的推荐书单
  Future<List<BookListBean>> getBookListRecommond(String id, int limit) async {
    return _apiProvider.getBookListRecommond(id, limit);
  }

  ///获取书籍详情里面的评论
  Future<List<ReviewBean>> getBookReviewList(
      String bookId, String sort, int start, int limit) async {
    return _apiProvider.getBookReviewList(bookId, sort, start, limit);
  }

  ///书单详情
  Future<BookListDetailResp> getBookListResp(String id) async {
    return _apiProvider.getBookListResp(id);
  }

  ///获取各类榜单书籍列表
  Future<RankingResp> getRankingList(String id) async {
    return await _apiProvider.getRankingList(id);
  }

  ///书单列表
  Future<List<BookListsBean>> getBookList(String gender, int start, int limit,
      String duration, String sort, String tag) async {
    return await _apiProvider.getBookList(gender, start, limit, duration, sort, tag);
  }

  ///我的书架 推荐的书籍
  Future<List<BookShelveBean>> getRecommondBookList(String gender) async {
    return await _apiProvider.getRecommondBookList(gender);
  }

}
