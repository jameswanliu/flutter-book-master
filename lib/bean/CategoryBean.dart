import 'dart:convert' show json;

class CategoryBean {
  bool ok;
  List<MaleBean> female;
  List<MaleBean> male;
  List<Picture> picture;
  List<Press> press;

  CategoryBean.fromParams(
      {this.ok, this.female, this.male, this.picture, this.press});

  factory CategoryBean(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new CategoryBean.fromJson(json.decode(jsonStr))
          : new CategoryBean.fromJson(jsonStr);

  CategoryBean.fromJson(jsonRes) {
    ok = jsonRes['ok'];
    female = jsonRes['female'] == null ? null : [];

    for (var femaleItem in female == null ? [] : jsonRes['female']) {
      female.add(femaleItem == null ? null : new MaleBean.fromJson(femaleItem));
    }

    male = jsonRes['male'] == null ? null : [];

    for (var maleItem in male == null ? [] : jsonRes['male']) {
      male.add(maleItem == null ? null : new MaleBean.fromJson(maleItem));
    }

    picture = jsonRes['picture'] == null ? null : [];

    for (var pictureItem in picture == null ? [] : jsonRes['picture']) {
      picture
          .add(pictureItem == null ? null : new Picture.fromJson(pictureItem));
    }

    press = jsonRes['press'] == null ? null : [];

    for (var pressItem in press == null ? [] : jsonRes['press']) {
      press.add(pressItem == null ? null : new Press.fromJson(pressItem));
    }
  }

  @override
  String toString() {
    return '{"ok": $ok,"female": $female,"male": $male,"picture": $picture,"press": $press}';
  }
}

class Press {
  int bookCount;
  int monthlyCount;
  String icon;
  String name;
  List<String> bookCover;

  Press.fromParams(
      {this.bookCount,
      this.monthlyCount,
      this.icon,
      this.name,
      this.bookCover});

  Press.fromJson(jsonRes) {
    bookCount = jsonRes['bookCount'];
    monthlyCount = jsonRes['monthlyCount'];
    icon = jsonRes['icon'];
    name = jsonRes['name'];
    bookCover = jsonRes['bookCover'] == null ? null : [];

    for (var bookCoverItem in bookCover == null ? [] : jsonRes['bookCover']) {
      bookCover.add(bookCoverItem);
    }
  }

  @override
  String toString() {
    return '{"bookCount": $bookCount,"monthlyCount": $monthlyCount,"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"bookCover": $bookCover}';
  }
}

class Picture {
  int bookCount;
  int monthlyCount;
  String icon;
  String name;
  List<String> bookCover;

  Picture.fromParams(
      {this.bookCount,
      this.monthlyCount,
      this.icon,
      this.name,
      this.bookCover});

  Picture.fromJson(jsonRes) {
    bookCount = jsonRes['bookCount'];
    monthlyCount = jsonRes['monthlyCount'];
    icon = jsonRes['icon'];
    name = jsonRes['name'];
    bookCover = jsonRes['bookCover'] == null ? null : [];

    for (var bookCoverItem in bookCover == null ? [] : jsonRes['bookCover']) {
      bookCover.add(bookCoverItem);
    }
  }

  @override
  String toString() {
    return '{"bookCount": $bookCount,"monthlyCount": $monthlyCount,"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"bookCover": $bookCover}';
  }
}

class MaleBean {
  int bookCount;
  int monthlyCount;
  String icon;
  String name;
  List<String> bookCover;

  MaleBean.fromParams(
      {this.bookCount,
      this.monthlyCount,
      this.icon,
      this.name,
      this.bookCover});

  MaleBean.fromJson(jsonRes) {
    bookCount = jsonRes['bookCount'];
    monthlyCount = jsonRes['monthlyCount'];
    icon = jsonRes['icon'];
    name = jsonRes['name'];
    bookCover = jsonRes['bookCover'] == null ? null : [];

    for (var bookCoverItem in bookCover == null ? [] : jsonRes['bookCover']) {
      bookCover.add(bookCoverItem);
    }
  }

  @override
  String toString() {
    return '{"bookCount": $bookCount,"monthlyCount": $monthlyCount,"icon": ${icon != null ? '${json.encode(icon)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"bookCover": $bookCover}';
  }
}
