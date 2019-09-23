import 'dart:convert' show json;
class BookListResp {

  int total;
  bool ok;
  List<BookListsBean> bookLists;

  BookListResp.fromParams({this.total, this.ok, this.bookLists});

  factory BookListResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BookListResp.fromJson(json.decode(jsonStr)) : new BookListResp.fromJson(jsonStr);

  BookListResp.fromJson(jsonRes) {
    total = jsonRes['total'];
    ok = jsonRes['ok'];
    bookLists = jsonRes['bookLists'] == null ? null : [];

    for (var bookListsItem in bookLists == null ? [] : jsonRes['bookLists']){
      bookLists.add(bookListsItem == null ? null : new BookListsBean.fromJson(bookListsItem));
    }
  }

  @override
  String toString() {
    return '{"total": $total,"ok": $ok,"bookLists": $bookLists}';
  }
}

class BookListsBean {

  int bookCount;
  int collectorCount;
  String id;
  String author;
  String cover;
  String desc;
  String gender;
  String title;
  List<String> covers;

  BookListsBean.fromParams({this.bookCount, this.collectorCount, this.id, this.author, this.cover, this.desc, this.gender, this.title, this.covers});

  BookListsBean.fromJson(jsonRes) {
    bookCount = jsonRes['bookCount'];
    collectorCount = jsonRes['collectorCount'];
    id = jsonRes['_id'];
    author = jsonRes['author'];
    cover = jsonRes['cover'];
    desc = jsonRes['desc'];
    gender = jsonRes['gender'];
    title = jsonRes['title'];
    covers = jsonRes['covers'] == null ? null : [];

    for (var coversItem in covers == null ? [] : jsonRes['covers']){
      covers.add(coversItem);
    }
  }

  @override
  String toString() {
    return '{"bookCount": $bookCount,"collectorCount": $collectorCount,"_id": ${id != null?'${json.encode(id)}':'null'},"author": ${author != null?'${json.encode(author)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"desc": ${desc != null?'${json.encode(desc)}':'null'},"gender": ${gender != null?'${json.encode(gender)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"covers": $covers}';
  }
}

