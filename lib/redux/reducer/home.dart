import 'package:flutter_book_master/redux/action/ActionType.dart';
import 'package:flutter_book_master/redux/state/HomeState.dart';
import 'package:flutter_book_master/bean/male_prise_book.dart' show RankBean;
import 'package:flutter_book_master/redux/action/home.dart'
    show
        FemaleEndBookList,
        FemaleHotBookList,
        FemaleNewBookList,
        FemalePriaseBookList,
        FemaleRank,
        FemaleRankAction,
        FemaleRankGoodBookAction,
        FemaleRankTopBookAction,
        FemaleReputationBookList,
        GenderType,
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

HomeSate homeRedux(HomeSate state, ActionType action) {
  if (action is UpdateBanner) {
    return state.copyWith(bannerList: action.payload, isLoading: true);
  }

  if (action is FemaleRankAction) {
    return state.copyWith(females: action.payload);
  }

  if (action is MaleRankAction) {
    return state.copyWith(males: action.payload);
  }

  if (action is MaleRankTopBookAction) {
    return state.copyWith(maleRankTopBooks: action.payload);
  }

  if (action is FemaleRankTopBookAction) {
    return state.copyWith(femaleRankTopBooks: action.payload);
  }

  if (action is MaleRankGoodBookAction) {
    return state.copyWith(maleRankGoodBooks: action.payload);
  }
  if (action is FemaleRankGoodBookAction) {
    return state.copyWith(femaleRankGoodBooks: action.payload);
  }

  if (action is MaleHotBookList) {
    return state.copyWith(maleHotBookList: action.payload);
  }

  if (action is MaleNewBookList) {
    return state.copyWith(maleNewBookList: action.payload);
  }

  if (action is MaleEndBookList) {
    return state.copyWith(maleOverBookList: action.payload);
  }

  if (action is MaleReputationBookList) {
    return state.copyWith(maleReputationBookList: action.payload);
  }

  if (action is MalePriaseBookList) {
    return state.copyWith(malePriaseBookList: action.payload);
  }

  if (action is FemalePriaseBookList) {
    return state.copyWith(femalePriaseBookList: action.payload);
  }

  ///
  if (action is FemaleNewBookList) {
    return state.copyWith(femaleNewBookList: action.payload);
  }
  if (action is FemaleEndBookList) {
    return state.copyWith(femaleOverBookList: action.payload);
  }
  if (action is FemaleReputationBookList) {
    return state.copyWith(femaleReputationBookList: action.payload);
  }
  if (action is FemaleHotBookList) {
    return state.copyWith(femaleHotBookList: action.payload);
  }

  if (action is MaleRank) {
    return state.copyWith(maleRankIds: action.payload);
  }
  if (action is FemaleRank) {
    return state.copyWith(femaleRankIds: action.payload);
  }
  if (action is GenderType) {
    return state.copyWith(gender: action.payload);
  }
  return state;
}
