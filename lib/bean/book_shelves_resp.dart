

import 'dart:convert' show json;

class BookShelveResp {

  bool ok;
  List<BookShelveBean> books;

  BookShelveResp.fromParams({this.ok, this.books});

  factory BookShelveResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BookShelveResp.fromJson(json.decode(jsonStr)) : new BookShelveResp.fromJson(jsonStr);

  BookShelveResp.fromJson(jsonRes) {
    ok = jsonRes['ok'];
    books = jsonRes['books'] == null ? null : [];

    for (var booksItem in books == null ? [] : jsonRes['books']){
      books.add(booksItem == null ? null : new BookShelveBean.fromJson(booksItem));
    }
  }

  @override
  String toString() {
    return '{"ok": $ok,"books": $books}';
  }
}

class BookShelveBean {

  int chaptersCount;
  int latelyFollower;
  double retentionRatio;
  bool allowFree;
  bool allowMonthly;
  bool hasCp;
  String id;
  String author;
  String contentType;
  String cover;
  String lastChapter;
  String majorCate;
  String shortIntro;
  String title;
  String updated;

  BookShelveBean.fromParams({this.chaptersCount, this.latelyFollower, this.retentionRatio, this.allowFree, this.allowMonthly, this.hasCp, this.id, this.author, this.contentType, this.cover, this.lastChapter, this.majorCate, this.shortIntro, this.title, this.updated});

  BookShelveBean.fromJson(jsonRes) {
    chaptersCount = jsonRes['chaptersCount'];
    latelyFollower = jsonRes['latelyFollower'];
    retentionRatio = jsonRes['retentionRatio'];
    allowFree = jsonRes['allowFree'];
    allowMonthly = jsonRes['allowMonthly'];
    hasCp = jsonRes['hasCp'];
    id = jsonRes['_id'];
    author = jsonRes['author'];
    contentType = jsonRes['contentType'];
    cover = jsonRes['cover'];
    lastChapter = jsonRes['lastChapter'];
    majorCate = jsonRes['majorCate'];
    shortIntro = jsonRes['shortIntro'];
    title = jsonRes['title'];
    updated = jsonRes['updated'];
  }

  @override
  String toString() {
    return '{"chaptersCount": $chaptersCount,"latelyFollower": $latelyFollower,"retentionRatio": $retentionRatio,"allowFree": $allowFree,"allowMonthly": $allowMonthly,"hasCp": $hasCp,"_id": ${id != null?'${json.encode(id)}':'null'},"author": ${author != null?'${json.encode(author)}':'null'},"contentType": ${contentType != null?'${json.encode(contentType)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"lastChapter": ${lastChapter != null?'${json.encode(lastChapter)}':'null'},"majorCate": ${majorCate != null?'${json.encode(majorCate)}':'null'},"shortIntro": ${shortIntro != null?'${json.encode(shortIntro)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"updated": ${updated != null?'${json.encode(updated)}':'null'}}';
  }
}

