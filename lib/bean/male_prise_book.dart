import 'dart:convert' show json;
import 'package:flutter_book_master/bean/BookBean.dart';

class PiraseBean {

  bool ok;
  RankBean ranking;

  PiraseBean.fromParams({this.ok, this.ranking});

  factory PiraseBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new PiraseBean.fromJson(json.decode(jsonStr)) : new PiraseBean.fromJson(jsonStr);

  PiraseBean.fromJson(jsonRes) {
    ok = jsonRes['ok'];
    ranking = jsonRes['ranking'] == null ? null : new RankBean.fromJson(jsonRes['ranking']);
  }

  @override
  String toString() {
    return '{"ok": $ok,"ranking": $ranking}';
  }
}

class RankBean {

  int priority;
  int total;
  bool collapse;
  bool isSub;
  String id;
  String biTag;
  String cover;
  String created;
  String gender;
  String icon;
  String shortTitle;
  String tag;
  String title;
  String updated;
  List<BookBean> books;

  RankBean.fromParams({this.priority, this.total, this.collapse, this.isSub, this.id, this.biTag, this.cover, this.created, this.gender, this.icon, this.shortTitle, this.tag, this.title, this.updated, this.books});

RankBean.fromJson(jsonRes) {
priority = jsonRes['priority'];
total = jsonRes['total'];
collapse = jsonRes['collapse'];
isSub = jsonRes['isSub'];
id = jsonRes['_id'];
biTag = jsonRes['biTag'];
cover = jsonRes['cover'];
created = jsonRes['created'];
gender = jsonRes['gender'];
icon = jsonRes['icon'];
id = jsonRes['id'];
shortTitle = jsonRes['shortTitle'];
tag = jsonRes['tag'];
title = jsonRes['title'];
updated = jsonRes['updated'];
books = jsonRes['books'] == null ? null : [];

for (var booksItem in books == null ? [] : jsonRes['books']){
books.add(booksItem == null ? null : new BookBean.fromJson(booksItem));
}
}

@override
String toString() {
  return '"priority": $priority,"total": $total,"collapse": $collapse,"isSub": $isSub,"_id": ${id != null?'${json.encode(id)}':'null'},"biTag": ${biTag != null?'${json.encode(biTag)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"created": ${created != null?'${json.encode(created)}':'null'},"gender": ${gender != null?'${json.encode(gender)}':'null'},"icon": ${icon != null?'${json.encode(icon)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"shortTitle": ${shortTitle != null?'${json.encode(shortTitle)}':'null'},"tag": ${tag != null?'${json.encode(tag)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"updated": ${updated != null?'${json.encode(updated)}':'null'},"books": $books}';
}
}

//class BookBean {
//
//  int latelyFollower;
//  bool allowMonthly;
//  String id;
//  String author;
//  String cover;
//  String majorCate;
//  String minorCate;
//  dynamic retentionRatio;
//  String shortIntro;
//  String site;
//  String title;
//
//  BookBean.fromParams({this.latelyFollower, this.allowMonthly, this.id, this.author, this.cover, this.majorCate, this.minorCate, this.retentionRatio, this.shortIntro, this.site, this.title});
//
//  BookBean.fromJson(jsonRes) {
//    latelyFollower = jsonRes['latelyFollower'];
//    allowMonthly = jsonRes['allowMonthly'];
//    id = jsonRes['_id'];
//    author = jsonRes['author'];
//    cover = jsonRes['cover'];
//    majorCate = jsonRes['majorCate'];
//    minorCate = jsonRes['minorCate'];
//    retentionRatio = jsonRes['retentionRatio'];
//    shortIntro = jsonRes['shortIntro'];
//    site = jsonRes['site'];
//    title = jsonRes['title'];
//  }

//  @override
//  String toString() {
//    return '{"latelyFollower": $latelyFollower,"allowMonthly": $allowMonthly,"_id": ${id != null?'${json.encode(id)}':'null'},"author": ${author != null?'${json.encode(author)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"majorCate": ${majorCate != null?'${json.encode(majorCate)}':'null'},"minorCate": ${minorCate != null?'${json.encode(minorCate)}':'null'},"retentionRatio": ${retentionRatio != null?'${json.encode(retentionRatio)}':'null'},"shortIntro": ${shortIntro != null?'${json.encode(shortIntro)}':'null'},"site": ${site != null?'${json.encode(site)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
//  }
//}

