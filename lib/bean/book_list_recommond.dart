import 'dart:convert' show json;

class BookListRecommondBean {

  int total;
  bool ok;
  List<BookListBean> booklists;

  BookListRecommondBean.fromParams({this.total, this.ok, this.booklists});

  factory BookListRecommondBean(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BookListRecommondBean.fromJson(json.decode(jsonStr)) : new BookListRecommondBean.fromJson(jsonStr);

  BookListRecommondBean.fromJson(jsonRes) {
    total = jsonRes['total'];
    ok = jsonRes['ok'];
    booklists = jsonRes['booklists'] == null ? null : [];

    for (var booklistsItem in booklists == null ? [] : jsonRes['booklists']){
      booklists.add(booklistsItem == null ? null : new BookListBean.fromJson(booklistsItem));
    }
  }

  @override
  String toString() {
    return '{"total": $total,"ok": $ok,"booklists": $booklists}';
  }
}

class BookListBean {

  int bookCount;
  int collectorCount;
  String author;
  String cover;
  String desc;
  String id;
  String title;
  List<String> covers;

  BookListBean.fromParams({this.bookCount, this.collectorCount, this.author, this.cover, this.desc, this.id, this.title, this.covers});

  BookListBean.fromJson(jsonRes) {
    bookCount = jsonRes['bookCount'];
    collectorCount = jsonRes['collectorCount'];
    author = jsonRes['author'];
    cover = jsonRes['cover'];
    desc = jsonRes['desc'];
    id = jsonRes['id'];
    title = jsonRes['title'];
    covers = jsonRes['covers'] == null ? null : [];

    for (var coversItem in covers == null ? [] : jsonRes['covers']){
      covers.add(coversItem);
    }
  }

  @override
  String toString() {
    return '{"bookCount": $bookCount,"collectorCount": $collectorCount,"author": ${author != null?'${json.encode(author)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"desc": ${desc != null?'${json.encode(desc)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"covers": $covers}';
  }
}

