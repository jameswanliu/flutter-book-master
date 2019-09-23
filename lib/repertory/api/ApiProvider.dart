import 'dart:convert';
import 'dart:convert' as Convert;
import 'package:dio/dio.dart';
import 'package:flutter_book_master/bean/BannerResponse.dart';
import 'package:flutter_book_master/bean/CategoryBean.dart';
import 'package:flutter_book_master/bean/book_detail_page.dart';
import 'package:flutter_book_master/bean/book_hot_review.dart';
import 'package:flutter_book_master/bean/book_list_recommond.dart';
import 'package:flutter_book_master/bean/book_list_detail_resp.dart';
import 'package:flutter_book_master/bean/book_list_resp.dart';
import 'package:flutter_book_master/bean/book_shelves_resp.dart';
import 'package:flutter_book_master/bean/ranking_list.dart';
import 'package:flutter_book_master/net/Constant.dart';
import 'package:flutter_book_master/net/exception/HttpException.dart';
import 'package:flutter_book_master/bean/RankRespone.dart';
import 'package:flutter_book_master/bean/BookBean.dart';
import 'package:flutter_book_master/bean/male_prise_book.dart'
    show RankBean, PiraseBean;

class ApiProvider {
  static const String GET_RANK_GENDER = '/ranking/gender';
  static const String GET_RANK = '/ranking/';
  static const String GET_BANNER = '/spread';
  static const String GET_HOT_REVIEW_PATH = '/post/review/best-by-book?book=';
  static const String GET_BOOK_DETAIL = '/book/';
  static const String GET_SORT_PATH = '/cats/lv2/statistics';
  static const String GET_BOOK_BY_CATEGORIES = '/book/by-categories?';
  static const String GET_BOOK_LIST_RECOMMOND_PATH = '/book-list';
  static const String RECOMMEND = '/recommend?';
  static const String GET_REVIEW_PATH = '/post/review/by-book?';
  static const String GET_BOOK_RECOMMEND = "/book/recommend";//我的书架推荐的书架

  Dio _dio;

  ApiProvider() {
    BaseOptions _options = BaseOptions(
        baseUrl: Constant.BASE_HOST,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000);
    _dio = Dio(_options);

    _dio.interceptors.add(InterceptorsWrapper(onRequest: (_options) {
      String url = _options.path;

      if (url.contains("/spread")) {
        _options.baseUrl = Constant.BANNER_HOST;
      } else {
        _options.baseUrl = Constant.BASE_HOST;
      }

      if (url.contains("book/") ||
          url.contains("book-list/") ||
          url.contains("toc/") ||
          url.contains("post/") ||
          url.contains("user/")) {
        Map<String, String> headers = {
          'User-Agent':
              'ZhuiShuShenQi/3.40[preload=false;locale=zh_CN;clientidbase=android-nvidia]',
          'X-User-Agent':
              'ZhuiShuShenQi/3.40[preload=false;locale=zh_CN;clientidbase=android-nvidia]'
//          ,'X-Device-Id':''
          ,
          'Host': 'api.zhuishushenqi.com',
          'Connection': 'Keep-Alive',
          'If-None-Match': 'W\"2a04-4nguJ+XAaA1yAeFHyxVImg\"',
          'If-Modified-Since': 'Tue, 02 Aug 2016 03:20:06 UTC'
        };
        _options.headers = headers;
      }

      return _options;
    }, onResponse: (Response response) {
      print("http 返回内容:" + response.data.toString());
      return response;
    }, onError: (DioError error) {
      print(error.error.toString());
    }));
  }

  void throwIfNoSuccess(Response response) {
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw HttpException(response);
    }
  }

  Future<Entity> getRankGender() async {
    Response response = await _dio.get(GET_RANK_GENDER);
    throwIfNoSuccess(response);
    return Entity.fromJson(jsonDecode(response.toString()));
  }

  //获取排行榜内容
  Future<String> getRankBook(String id) async {
    Response response = await _dio.get(GET_RANK + id);
    throwIfNoSuccess(response);
    return response.toString();
  }

  Future<List<Data>> getBanner() async {
    Response response = await _dio.get(GET_BANNER);
    print("banner 返回内容:" + response.toString());
    throwIfNoSuccess(response);
    return BannerResponse.fromJson(jsonDecode(response.toString())).data;
  }

  Future<CategoryBean> getCategoryList() async {
    Response response = await _dio.get(GET_SORT_PATH);
    print("category :" + response.toString());
    throwIfNoSuccess(response);
    return CategoryBean.fromJson(Convert.jsonDecode(response.toString()));
  }


  ///我的书架 推荐的书籍
  Future<List<BookShelveBean>> getRecommondBookList(String gender) async {
    Response response = await _dio.get(GET_BOOK_RECOMMEND);
    throwIfNoSuccess(response);
    return BookShelveResp.fromJson(Convert.jsonDecode(response.toString())).books;
  }


  Future<List<BookBean>> getBookByCategory(String gender, String type,
      String major, String minor, int start, int limit) async {
    Map<String, Object> queryParameters = {
      "gender": gender,
      "type": type,
      "major": major,
      "minor": minor,
      "start": start,
      "limit": limit
    };
    Response response = await _dio.get(GET_BOOK_BY_CATEGORIES,
        queryParameters: queryParameters);
    throwIfNoSuccess(response);
    return BeanListBean.fromJson(Convert.jsonDecode(response.toString())).books;
  }

  ///好评
  Future<RankBean> getPriaseBookList(String id) async {
    Response response = await _dio.get(GET_RANK + id);
    throwIfNoSuccess(response);
    return PiraseBean.fromJson(Convert.jsonDecode(response.toString())).ranking;
  }

  ///书籍详情
  Future<BookDetail> getBookDetail(String id) async {
    Response response = await _dio.get(GET_BOOK_DETAIL + id);
    throwIfNoSuccess(response);
    return BookDetail.fromJson(Convert.jsonDecode(response.toString()));
  }

  ///书籍详情热门评论
  Future<List<ReviewBean>> getBookHotReviews(String id) async {
    Response response = await _dio.get(GET_HOT_REVIEW_PATH + id);
    throwIfNoSuccess(response);
    return BookHotReview.fromJson(Convert.jsonDecode(response.toString()))
        .reviews;
  }

  ///获取书籍详情里面的推荐书单
  Future<List<BookListBean>> getBookListRecommond(String id, int limit) async {
    Response response = await _dio.get(
        GET_BOOK_LIST_RECOMMOND_PATH + "/" + id + RECOMMEND,
        queryParameters: {'limit': limit});
    throwIfNoSuccess(response);
    return BookListRecommondBean.fromJson(
            Convert.jsonDecode(response.toString()))
        .booklists;
  }

  ///获取书籍详情里面的评论
  Future<List<ReviewBean>> getBookReviewList(
      String bookId, String sort, int start, int limit) async {
    Response response = await _dio.get(GET_REVIEW_PATH,
        queryParameters: {'limit': limit, 'start': start, 'sort': sort});
    throwIfNoSuccess(response);
    return BookHotReview.fromJson(Convert.jsonDecode(response.toString()))
        .reviews;
  }

  ///书单详情
  Future<BookListDetailResp> getBookListResp(String id) async {
    Response response = await _dio.get(GET_BOOK_LIST_RECOMMOND_PATH + "/" + id);
    throwIfNoSuccess(response);
    return BookListDetailResp.fromJson(Convert.jsonDecode(response.toString()));
  }

  ///获取各类榜单书籍列表
  Future<RankingResp> getRankingList(String id) async {
    Response response = await _dio.get(GET_RANK + id);
    throwIfNoSuccess(response);
    return RankingResp.fromJson(Convert.jsonDecode(response.toString()));
  }


  ///书单列表
  Future<List<BookListsBean>> getBookList(String gender, int start, int limit,
      String duration, String sort, String tag) async {
    Map<String, Object> queryParameters = {
      'gender': gender,
      'sort': sort,
      'duration': duration,
      'tag': tag,
      'start': start,
      'limit': limit
    };

    Response response = await _dio.get(GET_BOOK_LIST_RECOMMOND_PATH + '?',
        queryParameters: queryParameters);
    throwIfNoSuccess(response);
    return BookListResp.fromJson(Convert.jsonDecode(response.toString())).bookLists;
  }
}
