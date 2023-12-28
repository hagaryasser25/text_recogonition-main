import 'package:flutter/cupertino.dart';

class Data {
  Data({
    String? data,
    String? id,
    String? photoUrl,

  }) {
    _data = data;
    _id = id;
    _photoUrl = photoUrl;

  }

  Data.fromJson(dynamic json) {
    _data = json['data'];
    _id = json['id'];
    _photoUrl = json['photoUrl'];

  }

  String? _data;
  String? _id;
  String? _photoUrl;


  String? get data => _data;
  String? get id => _id;
  String? get photoUrl => _photoUrl;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['id'] = _id;
    map['photoUrl'] = _photoUrl;


    return map;
  }
}