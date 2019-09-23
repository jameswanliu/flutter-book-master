import 'dart:convert' show json;


///书单详情
class BookListDetailResp {

  bool ok;
  BookList bookList;

  BookListDetailResp.fromParams({this.ok, this.bookList});

  factory BookListDetailResp(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BookListDetailResp.fromJson(json.decode(jsonStr)) : new BookListDetailResp.fromJson(jsonStr);

  BookListDetailResp.fromJson(jsonRes) {
    ok = jsonRes['ok'];
    bookList = jsonRes['bookList'] == null ? null : new BookList.fromJson(jsonRes['bookList']);
  }

  @override
  String toString() {
    return '{"ok": $ok,"bookList": $bookList}';
  }
}

class BookList {

  int collectorCount;
  int total;
  int updateCount;
  bool isDistillate;
  bool isDraft;
  String ids;
  String created;
  String desc;
  String gender;
  String id;
  String shareLink;
  String title;
  String updated;
  List<BooksBean> books;
  List<String> tags;
  AuthorBean author;

  BookList.fromParams({this.collectorCount, this.total, this.updateCount, this.isDistillate, this.isDraft, this.ids, this.created, this.desc, this.gender, this.id, this.shareLink, this.title, this.updated, this.books, this.tags, this.author});

  BookList.fromJson(jsonRes) {
    collectorCount = jsonRes['collectorCount'];
    total = jsonRes['total'];
    updateCount = jsonRes['updateCount'];
    isDistillate = jsonRes['isDistillate'];
    isDraft = jsonRes['isDraft'];
    ids = jsonRes['_id'];
    created = jsonRes['created'];
    desc = jsonRes['desc'];
    gender = jsonRes['gender'];
    id = jsonRes['id'];
    shareLink = jsonRes['shareLink'];
    title = jsonRes['title'];
    updated = jsonRes['updated'];
    books = jsonRes['books'] == null ? null : [];

    for (var booksItem in books == null ? [] : jsonRes['books']){
      books.add(booksItem == null ? null : new BooksBean.fromJson(booksItem));
    }

    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']){
      tags.add(tagsItem);
    }

    author = jsonRes['author'] == null ? null : new AuthorBean.fromJson(jsonRes['author']);
  }

  @override
  String toString() {
    return '{"collectorCount": $collectorCount,"total": $total,"updateCount": $updateCount,"isDistillate": $isDistillate,"isDraft": $isDraft,"_id": ${ids != null?'${json.encode(ids)}':'null'},"created": ${created != null?'${json.encode(created)}':'null'},"desc": ${desc != null?'${json.encode(desc)}':'null'},"gender": ${gender != null?'${json.encode(gender)}':'null'},"id": ${id != null?'${json.encode(id)}':'null'},"shareLink": ${shareLink != null?'${json.encode(shareLink)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"updated": ${updated != null?'${json.encode(updated)}':'null'},"books": $books,"tags": $tags,"author": $author}';
  }
}

class AuthorBean {

  String gender;
  int lv;
  String ids;
  String avatar;
  String nickname;
  String type;

  AuthorBean.fromParams({this.gender, this.lv, this.ids, this.avatar, this.nickname, this.type});

  AuthorBean.fromJson(jsonRes) {
    gender = jsonRes['gender'];
    lv = jsonRes['lv'];
    ids = jsonRes['_id'];
    avatar = jsonRes['avatar'];
    nickname = jsonRes['nickname'];
    type = jsonRes['type'];
  }

  @override
  String toString() {
    return '{"gender": ${gender != null?'${json.encode(gender)}':'null'},"lv": $lv,"_id": ${ids != null?'${json.encode(ids)}':'null'},"avatar": ${avatar != null?'${json.encode(avatar)}':'null'},"nickname": ${nickname != null?'${json.encode(nickname)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'}}';
  }
}

class BooksBean {

  String comment;
  Book book;

  BooksBean.fromParams({this.comment, this.book});

  BooksBean.fromJson(jsonRes) {
    comment = jsonRes['comment'];
    book = jsonRes['book'] == null ? null : new Book.fromJson(jsonRes['book']);
  }

  @override
  String toString() {
    return '{"comment": ${comment != null?'${json.encode(comment)}':'null'},"book": $book}';
  }
}

class Book {

  int banned;
  int latelyFollower;
  int wordCount;
  double retentionRatio;
  bool allowFree;
  bool allowMonthly;
  String ids;
  String author;
  String cat;
  String cover;
  String longIntro;
  String majorCate;
  String minorCate;
  String site;
  String title;

  Book.fromParams({this.banned, this.latelyFollower, this.wordCount, this.retentionRatio, this.allowFree, this.allowMonthly, this.ids, this.author, this.cat, this.cover, this.longIntro, this.majorCate, this.minorCate, this.site, this.title});

  Book.fromJson(jsonRes) {
    banned = jsonRes['banned'];
    latelyFollower = jsonRes['latelyFollower'];
    wordCount = jsonRes['wordCount'];
    retentionRatio = jsonRes['retentionRatio'];
    allowFree = jsonRes['allowFree'];
    allowMonthly = jsonRes['allowMonthly'];
    ids = jsonRes['_id'];
    author = jsonRes['author'];
    cat = jsonRes['cat'];
    cover = jsonRes['cover'];
    longIntro = jsonRes['longIntro'];
    majorCate = jsonRes['majorCate'];
    minorCate = jsonRes['minorCate'];
    site = jsonRes['site'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"banned": $banned,"latelyFollower": $latelyFollower,"wordCount": $wordCount,"retentionRatio": $retentionRatio,"allowFree": $allowFree,"allowMonthly": $allowMonthly,"_id": ${ids != null?'${json.encode(ids)}':'null'},"author": ${author != null?'${json.encode(author)}':'null'},"cat": ${cat != null?'${json.encode(cat)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"longIntro": ${longIntro != null?'${json.encode(longIntro)}':'null'},"majorCate": ${majorCate != null?'${json.encode(majorCate)}':'null'},"minorCate": ${minorCate != null?'${json.encode(minorCate)}':'null'},"site": ${site != null?'${json.encode(site)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'}}';
  }
}

