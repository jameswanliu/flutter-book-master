import 'dart:convert' show json;

class BeanListBean {
  int total;
  bool ok;
  List<BookBean> books;

  BeanListBean.fromParams({this.total, this.ok, this.books});

  factory BeanListBean(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new BeanListBean.fromJson(json.decode(jsonStr))
          : new BeanListBean.fromJson(jsonStr);

  BeanListBean.fromJson(jsonRes) {
    total = jsonRes['total'];
    ok = jsonRes['ok'];
    books = jsonRes['books'] == null ? null : [];

    for (var booksItem in books == null ? [] : jsonRes['books']) {
      books.add(booksItem == null ? null : new BookBean.fromJson(booksItem));
    }
  }

  @override
  String toString() {
    return '{"total": $total,"ok": $ok,"books": $books}';
  }
}

class BookBean {
  bool isHeader;

  String headerName;

  bool isFooter;

  BookBean({this.isHeader, this.headerName, this.isFooter});

  int banned;
  int latelyFollower;
  int sizetype;
  dynamic retentionRatio;
  bool allowMonthly;
  String id;
  String author;
  String contentType;
  String cover;
  String lastChapter;
  String majorCate;
  String minorCate;
  String shortIntro;
  String site;
  String superscript;
  String title;
  List<dynamic> tags;

  BookBean.fromParams(
      {this.banned,
      this.latelyFollower,
      this.sizetype,
      this.retentionRatio,
      this.allowMonthly,
      this.id,
      this.author,
      this.contentType,
      this.cover,
      this.lastChapter,
      this.majorCate,
      this.minorCate,
      this.shortIntro,
      this.site,
      this.superscript,
      this.title,
      this.tags});

  BookBean.fromJson(jsonRes) {
    banned = jsonRes['banned'];
    latelyFollower = jsonRes['latelyFollower'];
    sizetype = jsonRes['sizetype'];
    retentionRatio = jsonRes['retentionRatio'];
    allowMonthly = jsonRes['allowMonthly'];
    id = jsonRes['_id'];
    author = jsonRes['author'];
    contentType = jsonRes['contentType'];
    cover = jsonRes['cover'];
    lastChapter = jsonRes['lastChapter'];
    majorCate = jsonRes['majorCate'];
    minorCate = jsonRes['minorCate'];
    shortIntro = jsonRes['shortIntro'];
    site = jsonRes['site'];
    superscript = jsonRes['superscript'];
    title = jsonRes['title'];
    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']) {
      tags.add(tagsItem);
    }
  }

  @override
  String toString() {
    return '{"banned": $banned,"latelyFollower": $latelyFollower,"sizetype": $sizetype,"retentionRatio": $retentionRatio,"allowMonthly": $allowMonthly,"_id": ${id != null ? '${json.encode(id)}' : 'null'},"author": ${author != null ? '${json.encode(author)}' : 'null'},"contentType": ${contentType != null ? '${json.encode(contentType)}' : 'null'},"cover": ${cover != null ? '${json.encode(cover)}' : 'null'},"lastChapter": ${lastChapter != null ? '${json.encode(lastChapter)}' : 'null'},"majorCate": ${majorCate != null ? '${json.encode(majorCate)}' : 'null'},"minorCate": ${minorCate != null ? '${json.encode(minorCate)}' : 'null'},"shortIntro": ${shortIntro != null ? '${json.encode(shortIntro)}' : 'null'},"site": ${site != null ? '${json.encode(site)}' : 'null'},"superscript": ${superscript != null ? '${json.encode(superscript)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"tags": $tags}';
  }
}
