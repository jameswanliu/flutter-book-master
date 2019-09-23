import 'dart:convert' show json;

class BookDetail {

  Object discount;
  int banned;
  int buytype;
  int chaptersCount;
  int currency;
  int followerCount;
  int latelyFollower;
  int postCount;
  int safelevel;
  int serializeWordCount;
  int sizetype;
  int wordCount;
  bool gg;
  bool le;
  bool advertRead;
  bool allowBeanVoucher;
  bool allowFree;
  bool allowMonthly;
  bool allowVoucher;
  bool donate;
  bool hasCopyright;
  bool hasCp;
  bool isAllowNetSearch;
  bool isFineBook;
  bool isForbidForFreeApp;
  bool isMakeMoneyLimit;
  bool isSerial;
  bool limit;
  String id;
  String author;
  String authorDesc;
  String cat;
  String contentType;
  String copyright;
  String copyrightDesc;
  String cover;
  String creater;
  String lastChapter;
  String longIntro;
  String majorCate;
  String majorCateV2;
  String minorCate;
  String minorCateV2;
  String originalAuthor;
  String retentionRatio;
  String superscript;
  String title;
  List<dynamic> anchors;
  String updated;
  List<String> gender;
  List<String> tags;
  Rating rating;

  BookDetail.fromParams({this.discount, this.banned, this.buytype, this.chaptersCount, this.currency, this.followerCount, this.latelyFollower, this.postCount, this.safelevel, this.serializeWordCount, this.sizetype, this.wordCount, this.gg, this.le, this.advertRead, this.allowBeanVoucher, this.allowFree, this.allowMonthly, this.allowVoucher, this.donate, this.hasCopyright, this.hasCp, this.isAllowNetSearch, this.isFineBook, this.isForbidForFreeApp, this.isMakeMoneyLimit, this.isSerial, this.limit, this.id, this.author, this.authorDesc, this.cat, this.contentType, this.copyright, this.copyrightDesc, this.cover, this.creater, this.lastChapter, this.longIntro, this.majorCate, this.majorCateV2, this.minorCate, this.minorCateV2, this.originalAuthor, this.retentionRatio, this.superscript, this.title, this.updated, this.anchors, this.gender, this.tags, this.rating});

  factory BookDetail(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BookDetail.fromJson(json.decode(jsonStr)) : new BookDetail.fromJson(jsonStr);

  BookDetail.fromJson(jsonRes) {
    discount = jsonRes['discount'];
    banned = jsonRes['banned'];
    buytype = jsonRes['buytype'];
    chaptersCount = jsonRes['chaptersCount'];
    currency = jsonRes['currency'];
    followerCount = jsonRes['followerCount'];
    latelyFollower = jsonRes['latelyFollower'];
    postCount = jsonRes['postCount'];
    safelevel = jsonRes['safelevel'];
    serializeWordCount = jsonRes['serializeWordCount'];
    sizetype = jsonRes['sizetype'];
    wordCount = jsonRes['wordCount'];
    gg = jsonRes['_gg'];
    le = jsonRes['_le'];
    advertRead = jsonRes['advertRead'];
    allowBeanVoucher = jsonRes['allowBeanVoucher'];
    allowFree = jsonRes['allowFree'];
    allowMonthly = jsonRes['allowMonthly'];
    allowVoucher = jsonRes['allowVoucher'];
    donate = jsonRes['donate'];
    hasCopyright = jsonRes['hasCopyright'];
    hasCp = jsonRes['hasCp'];
    isAllowNetSearch = jsonRes['isAllowNetSearch'];
    isFineBook = jsonRes['isFineBook'];
    isForbidForFreeApp = jsonRes['isForbidForFreeApp'];
    isMakeMoneyLimit = jsonRes['isMakeMoneyLimit'];
    isSerial = jsonRes['isSerial'];
    limit = jsonRes['limit'];
    id = jsonRes['_id'];
    author = jsonRes['author'];
    authorDesc = jsonRes['authorDesc'];
    cat = jsonRes['cat'];
    contentType = jsonRes['contentType'];
    copyright = jsonRes['copyright'];
    copyrightDesc = jsonRes['copyrightDesc'];
    cover = jsonRes['cover'];
    creater = jsonRes['creater'];
    lastChapter = jsonRes['lastChapter'];
    longIntro = jsonRes['longIntro'];
    majorCate = jsonRes['majorCate'];
    majorCateV2 = jsonRes['majorCateV2'];
    minorCate = jsonRes['minorCate'];
    minorCateV2 = jsonRes['minorCateV2'];
    originalAuthor = jsonRes['originalAuthor'];
    retentionRatio = jsonRes['retentionRatio'];
    superscript = jsonRes['superscript'];
    title = jsonRes['title'];
    updated = jsonRes['updated'];
    anchors = jsonRes['anchors'] == null ? null : [];

    for (var anchorsItem in anchors == null ? [] : jsonRes['anchors']){
      anchors.add(anchorsItem);
    }

    gender = jsonRes['gender'] == null ? null : [];

    for (var genderItem in gender == null ? [] : jsonRes['gender']){
      gender.add(genderItem);
    }

    tags = jsonRes['tags'] == null ? null : [];

    for (var tagsItem in tags == null ? [] : jsonRes['tags']){
      tags.add(tagsItem);
    }

    rating = jsonRes['rating'] == null ? null : new Rating.fromJson(jsonRes['rating']);
  }

  @override
  String toString() {
    return '{"discount": $discount,"banned": $banned,"buytype": $buytype,"chaptersCount": $chaptersCount,"currency": $currency,"followerCount": $followerCount,"latelyFollower": $latelyFollower,"postCount": $postCount,"safelevel": $safelevel,"serializeWordCount": $serializeWordCount,"sizetype": $sizetype,"wordCount": $wordCount,"_gg": $gg,"_le": $le,"advertRead": $advertRead,"allowBeanVoucher": $allowBeanVoucher,"allowFree": $allowFree,"allowMonthly": $allowMonthly,"allowVoucher": $allowVoucher,"donate": $donate,"hasCopyright": $hasCopyright,"hasCp": $hasCp,"isAllowNetSearch": $isAllowNetSearch,"isFineBook": $isFineBook,"isForbidForFreeApp": $isForbidForFreeApp,"isMakeMoneyLimit": $isMakeMoneyLimit,"isSerial": $isSerial,"limit": $limit,"_id": ${id != null?'${json.encode(id)}':'null'},"author": ${author != null?'${json.encode(author)}':'null'},"authorDesc": ${authorDesc != null?'${json.encode(authorDesc)}':'null'},"cat": ${cat != null?'${json.encode(cat)}':'null'},"contentType": ${contentType != null?'${json.encode(contentType)}':'null'},"copyright": ${copyright != null?'${json.encode(copyright)}':'null'},"copyrightDesc": ${copyrightDesc != null?'${json.encode(copyrightDesc)}':'null'},"cover": ${cover != null?'${json.encode(cover)}':'null'},"creater": ${creater != null?'${json.encode(creater)}':'null'},"lastChapter": ${lastChapter != null?'${json.encode(lastChapter)}':'null'},"longIntro": ${longIntro != null?'${json.encode(longIntro)}':'null'},"majorCate": ${majorCate != null?'${json.encode(majorCate)}':'null'},"majorCateV2": ${majorCateV2 != null?'${json.encode(majorCateV2)}':'null'},"minorCate": ${minorCate != null?'${json.encode(minorCate)}':'null'},"minorCateV2": ${minorCateV2 != null?'${json.encode(minorCateV2)}':'null'},"originalAuthor": ${originalAuthor != null?'${json.encode(originalAuthor)}':'null'},"retentionRatio": ${retentionRatio != null?'${json.encode(retentionRatio)}':'null'},"superscript": ${superscript != null?'${json.encode(superscript)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"updated": ${updated != null?'${json.encode(updated)}':'null'},"anchors": $anchors,"gender": $gender,"tags": $tags,"rating": $rating}';
  }
}

class Rating {

  int count;
  double score;
  bool isEffect;

  Rating.fromParams({this.count, this.score, this.isEffect});

  Rating.fromJson(jsonRes) {
    count = jsonRes['count'];
    score = jsonRes['score'];
    isEffect = jsonRes['isEffect'];
  }

  @override
  String toString() {
    return '{"count": $count,"score": $score,"isEffect": $isEffect}';
  }
}

