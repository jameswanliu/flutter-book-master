import 'package:json_annotation/json_annotation.dart';

part 'RankRespone.g.dart';

@JsonSerializable()
class Entity extends Object {
  @JsonKey(name: 'picture')
  List<Picture> picture;

  @JsonKey(name: 'female')
  List<Female> female;

  @JsonKey(name: 'epub')
  List<Epub> epub;

  @JsonKey(name: 'male')
  List<Male> male;

  @JsonKey(name: 'ok')
  bool ok;

  Entity(
    this.picture,
    this.female,
    this.epub,
    this.male,
    this.ok,
  );

  factory Entity.fromJson(Map<String, dynamic> srcJson) =>
      _$EntityFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EntityToJson(this);
}

@JsonSerializable()
class Picture extends Object {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'collapse')
  bool collapse;

  @JsonKey(name: 'shortTitle')
  String shortTitle;

  Picture(
    this.id,
    this.title,
    this.cover,
    this.collapse,
    this.shortTitle,
  );

  factory Picture.fromJson(Map<String, dynamic> srcJson) =>
      _$PictureFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PictureToJson(this);
}

@JsonSerializable()
class Female extends Object {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'collapse')
  bool collapse;

  @JsonKey(name: 'monthRank')
  String monthRank;

  @JsonKey(name: 'totalRank')
  String totalRank;

  @JsonKey(name: 'shortTitle')
  String shortTitle;


  Female(
    this.id,
    this.title,
    this.cover,
    this.collapse,
    this.monthRank,
    this.totalRank,
    this.shortTitle,
  );

  factory Female.fromJson(Map<String, dynamic> srcJson) =>
      _$FemaleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FemaleToJson(this);
}

@JsonSerializable()
class Epub extends Object {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'collapse')
  bool collapse;

  @JsonKey(name: 'shortTitle')
  String shortTitle;

  Epub(
    this.id,
    this.title,
    this.cover,
    this.collapse,
    this.shortTitle,
  );

  factory Epub.fromJson(Map<String, dynamic> srcJson) =>
      _$EpubFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EpubToJson(this);
}

@JsonSerializable()
class Male extends Object {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'collapse')
  bool collapse;

  @JsonKey(name: 'monthRank')
  String monthRank;

  @JsonKey(name: 'totalRank')
  String totalRank;

  @JsonKey(name: 'shortTitle')
  String shortTitle;

  Male(
    this.id,
    this.title,
    this.cover,
    this.collapse,
    this.monthRank,
    this.totalRank,
    this.shortTitle,
  );

  factory Male.fromJson(Map<String, dynamic> srcJson) =>
      _$MaleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MaleToJson(this);
}
