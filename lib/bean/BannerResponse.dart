import 'package:json_annotation/json_annotation.dart';

part 'BannerResponse.g.dart';


@JsonSerializable()
class BannerResponse extends Object {

  @JsonKey(name: 'data')
  List<Data> data;

  @JsonKey(name: 'ok')
  bool ok;

  BannerResponse(this.data,this.ok,);

  factory BannerResponse.fromJson(Map<String, dynamic> srcJson) => _$BannerResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);

}


@JsonSerializable()
class Data extends Object {

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: '__v')
  int v;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'link')
  String link;

  @JsonKey(name: 'fullDes')
  String fullDes;

  @JsonKey(name: 'simpleDes')
  String simpleDes;

  @JsonKey(name: 'img')
  String img;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'node')
  Node node;

  @JsonKey(name: 'page')
  String page;

  @JsonKey(name: 'platforms')
  List<String> platforms;

  Data(this.id,this.v,this.type,this.link,this.fullDes,this.simpleDes,this.img,this.title,this.order,this.node,this.page,this.platforms,);

  factory Data.fromJson(Map<String, dynamic> srcJson) => _$DataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


@JsonSerializable()
class Node extends Object {

  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'order')
  int order;

  @JsonKey(name: 'sex')
  String sex;

  Node(this.id,this.order,this.sex,);

  factory Node.fromJson(Map<String, dynamic> srcJson) => _$NodeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NodeToJson(this);

}



