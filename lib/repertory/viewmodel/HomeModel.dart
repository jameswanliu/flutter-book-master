import 'package:flutter_book_master/bean/BannerResponse.dart';
import 'package:flutter_book_master/bean/BookBean.dart';
import 'package:flutter_book_master/bean/RankRespone.dart';
import 'package:flutter_book_master/redux/state/AppState.dart';
import 'package:redux/redux.dart';
import 'package:flutter_book_master/bean/male_prise_book.dart' show RankBean;
import 'ViewModel.dart';

class HomeViewModel extends ViewModel {
  HomeViewModel(Store<AppState> store) : super(store: store);

  bool get isLoading => store.state.homeSate.isLoading;

  Map<String, String> get maleRankIds => store.state.homeSate.maleRankIds;

  Map<String, String> get femaleRankIds => store.state.homeSate.femaleRankIds;

  List<Data> get banners => store.state.homeSate.banners;

  int get groupIndex => store.state.homeSate.groupIndex;

  List<Female> get females => store.state.homeSate.females;

  List<BookBean> get maleHotBookList => store.state.homeSate.maleHotBookList;

  List<BookBean> get maleOverBookList => store.state.homeSate.maleOverBookList;

  List<BookBean> get maleNewBookList => store.state.homeSate.maleNewBookList;

  List<BookBean> get maleReputationBookList =>
      store.state.homeSate.maleNewBookList;

  List<BookBean> get femaleHotBookList =>
      store.state.homeSate.femaleHotBookList;

  List<BookBean> get femaleOverBookList =>
      store.state.homeSate.femaleOverBookList;

  List<BookBean> get femaleReputationBookList =>
      store.state.homeSate.femaleReputationBookList;

  List<BookBean> get femaleNewBookList =>
      store.state.homeSate.femaleNewBookList;

  RankBean get malePriaseBookList => store.state.homeSate.malePriaseBookList;

  RankBean get femalePriaseBookList =>
      store.state.homeSate.femalePriaseBookList;

  List<Male> get males => store.state.homeSate.males;

  Map<String, dynamic> get maleRankTopBooks =>
      store.state.homeSate.maleRankTopBooks;

  Map<String, dynamic> get femaleRankTopBooks =>
      store.state.homeSate.femaleRankTopBooks;

  Map<String, dynamic> get maleRankGoodBooks =>
      store.state.homeSate.maleRankGoodBooks;

  Map<String, dynamic> get femaleRankGoodBooks =>
      store.state.homeSate.femaleRankGoodBooks;
  String get gender =>store.state.homeSate.gender;
}
