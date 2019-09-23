// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BannerResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) {
  return BannerResponse(
      (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['ok'] as bool);
}

Map<String, dynamic> _$BannerResponseToJson(BannerResponse instance) =>
    <String, dynamic>{'data': instance.data, 'ok': instance.ok};

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      json['_id'] as String,
      json['__v'] as int,
      json['type'] as String,
      json['link'] as String,
      json['fullDes'] as String,
      json['simpleDes'] as String,
      json['img'] as String,
      json['title'] as String,
      json['order'] as int,
      json['node'] == null
          ? null
          : Node.fromJson(json['node'] as Map<String, dynamic>),
      json['page'] as String,
      (json['platforms'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      '_id': instance.id,
      '__v': instance.v,
      'type': instance.type,
      'link': instance.link,
      'fullDes': instance.fullDes,
      'simpleDes': instance.simpleDes,
      'img': instance.img,
      'title': instance.title,
      'order': instance.order,
      'node': instance.node,
      'page': instance.page,
      'platforms': instance.platforms
    };

Node _$NodeFromJson(Map<String, dynamic> json) {
  return Node(
      json['_id'] as String, json['order'] as int, json['sex'] as String);
}

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      '_id': instance.id,
      'order': instance.order,
      'sex': instance.sex
    };
