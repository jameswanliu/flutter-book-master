import 'dart:convert' show json;

import 'package:flutter_book_master/bean/BookBean.dart';

class RankingResp {
  bool ok;
  RankingBean ranking;

  RankingResp.fromParams({this.ok, this.ranking});

  factory RankingResp(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new RankingResp.fromJson(json.decode(jsonStr))
          : new RankingResp.fromJson(jsonStr);

  RankingResp.fromJson(jsonRes) {
    ok = jsonRes['ok'];
    ranking = jsonRes['ranking'] == null
        ? null
        : new RankingBean.fromJson(jsonRes['ranking']);
  }

  @override
  String toString() {
    return '{"ok": $ok,"ranking": $ranking}';
  }
}

class RankingBean {
  int v;
  int priority;
  int total;
  bool collapse;
  bool isSub;
  bool news;
  String ids;
  String biTag;
  String cover;
  String created;
  String gender;
  String icon;
  String id;
  String shortTitle;
  String tag;
  String title;
  String updated;
  List<BookBean> books;

  RankingBean.fromParams(
      {this.v,
      this.priority,
      this.total,
      this.collapse,
      this.isSub,
      this.news,
      this.ids,
      this.biTag,
      this.cover,
      this.created,
      this.gender,
      this.icon,
      this.id,
      this.shortTitle,
      this.tag,
      this.title,
      this.updated,
      this.books});

  RankingBean.fromJson(jsonRes) {
    v = jsonRes['__v'];
    priority = jsonRes['priority'];
    total = jsonRes['total'];
    collapse = jsonRes['collapse'];
    isSub = jsonRes['isSub'];
    news = jsonRes['new'];
    ids = jsonRes['_id'];
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

    for (var booksItem in books == null ? [] : jsonRes['books']) {
      books.add(booksItem == null ? null : new BookBean.fromJson(booksItem));
    }
  }

  @override
  String toString() {
    return '{"__v": $v,"priority": $priority,"total": $total,"collapse": $collapse,"isSub": $isSub,"new": $news,"_id": ${ids != null ? '${json.encode(ids)}' : 'null'},"biTag": ${biTag != null ? '${json.encode(biTag)}' : 'null'},"cover": ${cover != null ? '${json.encode(cover)}' : 'null'},"created": ${created != null ? '${json.encode(created)}' : 'null'},"gender": ${gender != null ? '${json.encode(gender)}' : 'null'},"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"shortTitle": ${shortTitle != null ? '${json.encode(shortTitle)}' : 'null'},"tag": ${tag != null ? '${json.encode(tag)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"updated": ${updated != null ? '${json.encode(updated)}' : 'null'},"books": $books}';
  }
}

