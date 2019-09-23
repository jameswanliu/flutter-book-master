import 'package:flutter_book_master/bean/BannerResponse.dart';
import 'package:flutter_book_master/bean/BookBean.dart';
import 'package:flutter_book_master/bean/RankRespone.dart';
import 'package:flutter_book_master/bean/male_prise_book.dart' show RankBean;

class HomeSate {
  List<Data> banners;
  bool isLoading;
  List<Female> females; //排行榜
  List<Male> males;
  String gender = '';
  int groupIndex = 0; // 0为男频 1为女频
  Map<String, dynamic> maleRankTopBooks = {};
  Map<String, dynamic> femaleRankTopBooks = {};
  Map<String, dynamic> maleRankGoodBooks = {};
  Map<String, dynamic> femaleRankGoodBooks = {};

  List<BookBean> maleHotBookList = []; //男生最爱看的小说

  List<BookBean> maleOverBookList = []; //男生完本经典

  List<BookBean> maleNewBookList = []; //男生新书

  List<BookBean> maleReputationBookList = []; //口碑佳作

  List<BookBean> femaleHotBookList = []; //女生最爱看的小说

  List<BookBean> femaleOverBookList = []; //女生完本经典

  List<BookBean> femaleNewBookList = []; //女生新书

  List<BookBean> femaleReputationBookList = []; //女生口碑佳作

  RankBean malePriaseBookList; //男生好评书籍

  String maleOverId; //完结榜单id

  String maleHotId; //热门榜单id

  String maleGoodId; //好评榜单id

  String maleNewId; //新书榜单id

  String maleCollectionId; //收藏榜单id

  String maleRecommendId; //推荐榜单id

  Map<String, String> maleRankIds = {};

  Map<String, String> femaleRankIds = {};

  String femaleOverId; //完结榜单id

  String femaleHotId; //热门榜单id

  String femaleGoodId; //好评榜单id

  String femaleNewId; //新书榜单id

  String femaleCollectionId; //收藏榜单id

  String femaleRecommendId; //推荐榜单id

  RankBean femalePriaseBookList; //女生好评书籍

  HomeSate(
      {this.banners,
      this.isLoading,
      this.females,
      this.groupIndex,
      this.maleRankGoodBooks,
      this.femaleRankGoodBooks,
      this.maleHotBookList,
      this.maleHotId,
      this.maleOverId,
      this.maleNewId,
      this.maleGoodId,
      this.maleCollectionId,
      this.maleRecommendId,
      this.femaleHotId,
      this.femaleOverId,
      this.gender,
      this.femaleNewId,
      this.femaleGoodId,
      this.femaleCollectionId,
      this.femaleRecommendId,
      this.maleNewBookList,
      this.maleRankIds,
      this.femaleRankIds,
      this.femaleHotBookList,
      this.femaleNewBookList,
      this.femaleOverBookList,
      this.femaleReputationBookList,
      this.malePriaseBookList,
      this.femalePriaseBookList,
      this.maleOverBookList,
      this.maleReputationBookList,
      this.males,
      this.femaleRankTopBooks,
      this.maleRankTopBooks});

  HomeSate copyWith(
      {List<Data> bannerList,
      List<Male> males,
      int groupIndex,
      Map<String, dynamic> femaleRankTopBooks,
      Map<String, dynamic> maleRankTopBooks,
      Map<String, dynamic> maleRankGoodBooks,
      List<BookBean> maleHotBookList,
      List<BookBean> maleNewBookList,
      Map<String, String> maleRankIds,
      String gender,
      Map<String, String> femaleRankIds,
      RankBean malePriaseBookList,
      RankBean femalePriaseBookList,
      List<BookBean> femaleHotBookList,
      String maleOverId, //完结榜单id
      String maleHotId, //热门榜单id
      String maleGoodId, //好评榜单id
      String maleNewId, //新书榜单id
      String maleCollectionId, //收藏榜单id
      String maleRecommendId, //推荐榜单id

      String femaleOverId, //完结榜单id
      String femaleHotId, //热门榜单id
      String femaleGoodId, //好评榜单id
      String femaleNewId, //新书榜单id
      String femaleCollectionId, //收藏榜单id
      String femaleRecommendId, //推荐榜单id

      List<BookBean> femaleOverBookList,
      List<BookBean> femaleNewBookList,
      List<BookBean> femaleReputationBookList,
      List<BookBean> maleOverBookList,
      List<BookBean> maleReputationBookList,
      Map<String, dynamic> femaleRankGoodBooks,
      List<Female> females,
      bool isLoading}) {
    if (maleRankIds != null && maleRankIds.isNotEmpty) {
      this.maleRankIds.addAll(maleRankIds);
    }

    if (maleOverBookList != null && maleOverBookList.isNotEmpty) {
      this.maleOverBookList.addAll(maleOverBookList);
    }

    if (maleNewBookList != null && maleNewBookList.isNotEmpty) {
      this.maleNewBookList.addAll(maleNewBookList);
    }

    if (maleReputationBookList != null && maleReputationBookList.isNotEmpty) {
      this.maleReputationBookList.addAll(maleReputationBookList);
    }

    if (femaleOverBookList != null && femaleOverBookList.isNotEmpty) {
      this.femaleOverBookList.addAll(femaleOverBookList);
    }

    if (femaleNewBookList != null && femaleNewBookList.isNotEmpty) {
      this.femaleNewBookList.addAll(femaleNewBookList);
    }

    if (femaleReputationBookList != null &&
        femaleReputationBookList.isNotEmpty) {
      this.femaleReputationBookList.addAll(femaleReputationBookList);
    }

    if (femaleHotBookList != null && femaleHotBookList.isNotEmpty) {
      this.femaleHotBookList.addAll(femaleHotBookList);
    }

    return HomeSate(
        femaleRankTopBooks: femaleRankTopBooks ?? this.femaleRankTopBooks,
        banners: bannerList ?? this.banners,
        groupIndex: groupIndex ?? this.groupIndex,
        maleRankIds: maleRankIds ?? this.maleRankIds,
        femaleRankIds: femaleRankIds ?? this.femaleRankIds,
        maleHotBookList: this.maleHotBookList,
        maleOverBookList: this.maleOverBookList,
        maleNewBookList: this.maleNewBookList,
        gender: this.gender,
        maleNewId: maleNewId ?? this.maleNewId,
        maleGoodId: maleGoodId ?? this.maleGoodId,
        maleRecommendId: maleRecommendId ?? this.maleRecommendId,
        maleHotId: maleHotId ?? this.maleHotId,
        maleCollectionId: maleCollectionId ?? this.maleCollectionId,
        maleOverId: maleOverId ?? this.maleOverId,
        femaleNewId: femaleNewId ?? this.femaleNewId,
        femaleGoodId: femaleGoodId ?? this.femaleGoodId,
        femaleRecommendId: femaleRecommendId ?? this.femaleRecommendId,
        femaleHotId: femaleHotId ?? this.femaleHotId,
        femaleCollectionId: femaleCollectionId ?? this.femaleCollectionId,
        femaleOverId: femaleOverId ?? this.femaleOverId,
        femaleHotBookList: this.femaleHotBookList,
        femaleNewBookList: this.femaleNewBookList,
        femaleOverBookList: this.femaleOverBookList,
        femaleReputationBookList: this.femaleReputationBookList,
        malePriaseBookList: malePriaseBookList ?? this.malePriaseBookList,
        femalePriaseBookList: femalePriaseBookList ?? this.femalePriaseBookList,
        maleReputationBookList: this.maleReputationBookList,
        maleRankGoodBooks: maleRankGoodBooks ?? this.maleRankGoodBooks,
        femaleRankGoodBooks: femaleRankGoodBooks ?? this.femaleRankGoodBooks,
        maleRankTopBooks: maleRankTopBooks ?? this.maleRankTopBooks,
        females: females ?? this.females,
        males: males ?? this.males);
  }

  HomeSate.initState() {
    banners = [];
  }
}
