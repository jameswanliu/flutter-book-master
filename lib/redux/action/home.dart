import 'package:flutter_book_master/bean/BannerResponse.dart';
import 'package:flutter_book_master/bean/BookBean.dart';
import 'package:flutter_book_master/bean/male_prise_book.dart' show RankBean;
import 'package:flutter_book_master/bean/CategoryBean.dart';
import 'package:flutter_book_master/bean/RankRespone.dart';
import 'package:flutter_book_master/redux/action/ActionType.dart';

class UpdateBanner extends ActionType {
  List<Data> payload;

  UpdateBanner(this.payload) : super(action: payload);
}

class FemaleRankAction extends ActionType {
  //排行榜
  List<Female> payload;

  FemaleRankAction(this.payload) : super(action: payload);
}

class MaleRankAction extends ActionType {
  List<Male> payload;

  MaleRankAction(this.payload) : super(action: payload);
}

class MaleRankTopBookAction extends ActionType {
  Map<String, dynamic> payload;

  MaleRankTopBookAction(this.payload) : super(action: payload);
}

class FemaleRankTopBookAction extends ActionType {
  Map<String, dynamic> payload;

  FemaleRankTopBookAction(this.payload) : super(action: payload);
}

///男频好评书籍
class MaleRankGoodBookAction extends ActionType {
  Map<String, dynamic> payload;

  MaleRankGoodBookAction(this.payload) : super(action: payload);
}

///好评书籍女频
class FemaleRankGoodBookAction extends ActionType {
  Map<String, dynamic> payload;

  FemaleRankGoodBookAction(this.payload) : super(action: payload);
}

class UpdateGroupIndex extends ActionType {
  int payload;

  UpdateGroupIndex(this.payload) : super(action: payload);
}

///男生首页热门书籍（玄幻，奇幻，武侠，游戏）
class MaleHotBookList extends ActionType {
  List<BookBean> payload;

  MaleHotBookList(this.payload) : super(action: payload);
}

///口碑佳作
class MaleReputationBookList extends ActionType {
  List<BookBean> payload;

  MaleReputationBookList(this.payload) : super(action: payload);
}

///新书
class MaleNewBookList extends ActionType {
  List<BookBean> payload;

  MaleNewBookList(this.payload) : super(action: payload);
}

///完结经典
class MaleEndBookList extends ActionType {
  List<BookBean> payload;

  MaleEndBookList(this.payload) : super(action: payload);
}

///女生首页热门书籍（玄幻，奇幻，武侠，游戏）
class FemaleHotBookList extends ActionType {
  List<BookBean> payload;

  FemaleHotBookList(this.payload) : super(action: payload);
}

///女生口碑佳作
class FemaleReputationBookList extends ActionType {
  List<BookBean> payload;

  FemaleReputationBookList(this.payload) : super(action: payload);
}

///女生新书
class FemaleNewBookList extends ActionType {
  List<BookBean> payload;

  FemaleNewBookList(this.payload) : super(action: payload);
}

///女生完结经典
class FemaleEndBookList extends ActionType {
  List<BookBean> payload;

  FemaleEndBookList(this.payload) : super(action: payload);
}

///男生好评
class MalePriaseBookList extends ActionType {
  RankBean payload;

  MalePriaseBookList(this.payload) : super(action: payload);
}

///女生好评
class FemalePriaseBookList extends ActionType {
  RankBean payload;

  FemalePriaseBookList(this.payload) : super(action: payload);
}

class MaleRank extends ActionType {
  Map<String, String> payload;

  MaleRank(this.payload) : super(action: payload);
}

class FemaleRank extends ActionType {
  Map<String, String> payload;

  FemaleRank(this.payload) : super(action: payload);
}

class GenderType extends ActionType {
  String payload;
  GenderType(this.payload) : super(action: payload);
}
