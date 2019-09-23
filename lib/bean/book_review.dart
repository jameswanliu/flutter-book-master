

import 'dart:convert' show json;

class BookReview {

  int today;
  int total;
  bool ok;
  List<ReviewBean> reviews;

  BookReview.fromParams({this.today, this.total, this.ok, this.reviews});

  factory BookReview(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BookReview.fromJson(json.decode(jsonStr)) : new BookReview.fromJson(jsonStr);

  BookReview.fromJson(jsonRes) {
    today = jsonRes['today'];
    total = jsonRes['total'];
    ok = jsonRes['ok'];
    reviews = jsonRes['reviews'] == null ? null : [];

    for (var reviewsItem in reviews == null ? [] : jsonRes['reviews']){
      reviews.add(reviewsItem == null ? null : new ReviewBean.fromJson(reviewsItem));
    }
  }

  @override
  String toString() {
    return '{"today": $today,"total": $total,"ok": $ok,"reviews": $reviews}';
  }
}

class ReviewBean {

  int commentCount;
  int likeCount;
  int rating;
  String id;
  String content;
  String created;
  String state;
  String title;
  String updated;
  Author author;
  HelpfulBean helpful;

  ReviewBean.fromParams({this.commentCount, this.likeCount, this.rating, this.id, this.content, this.created, this.state, this.title, this.updated, this.author, this.helpful});

  ReviewBean.fromJson(jsonRes) {
    commentCount = jsonRes['commentCount'];
    likeCount = jsonRes['likeCount'];
    rating = jsonRes['rating'];
    id = jsonRes['_id'];
    content = jsonRes['content'];
    created = jsonRes['created'];
    state = jsonRes['state'];
    title = jsonRes['title'];
    updated = jsonRes['updated'];
    author = jsonRes['author'] == null ? null : new Author.fromJson(jsonRes['author']);
    helpful = jsonRes['helpful'] == null ? null : new HelpfulBean.fromJson(jsonRes['helpful']);
  }

  @override
  String toString() {
    return '{"commentCount": $commentCount,"likeCount": $likeCount,"rating": $rating,"_id": ${id != null?'${json.encode(id)}':'null'},"content": ${content != null?'${json.encode(content)}':'null'},"created": ${created != null?'${json.encode(created)}':'null'},"state": ${state != null?'${json.encode(state)}':'null'},"title": ${title != null?'${json.encode(title)}':'null'},"updated": ${updated != null?'${json.encode(updated)}':'null'},"author": $author,"helpful": $helpful}';
  }
}

class HelpfulBean {

  int no;
  int total;
  int yes;

  HelpfulBean.fromParams({this.no, this.total, this.yes});

  HelpfulBean.fromJson(jsonRes) {
    no = jsonRes['no'];
    total = jsonRes['total'];
    yes = jsonRes['yes'];
  }

  @override
  String toString() {
    return '{"no": $no,"total": $total,"yes": $yes}';
  }
}

class Author {

  double lv;
  String id;
  String activityAvatar;
  String avatar;
  String gender;
  String nickname;
  String type;

  Author.fromParams({this.lv, this.id, this.activityAvatar, this.avatar, this.gender, this.nickname, this.type});

  Author.fromJson(jsonRes) {
    lv = jsonRes['lv'];
    id = jsonRes['_id'];
    activityAvatar = jsonRes['activityAvatar'];
    avatar = jsonRes['avatar'];
    gender = jsonRes['gender'];
    nickname = jsonRes['nickname'];
    type = jsonRes['type'];
  }

  @override
  String toString() {
    return '{"lv": $lv,"_id": ${id != null?'${json.encode(id)}':'null'},"activityAvatar": ${activityAvatar != null?'${json.encode(activityAvatar)}':'null'},"avatar": ${avatar != null?'${json.encode(avatar)}':'null'},"gender": ${gender != null?'${json.encode(gender)}':'null'},"nickname": ${nickname != null?'${json.encode(nickname)}':'null'},"type": ${type != null?'${json.encode(type)}':'null'}}';
  }
}

