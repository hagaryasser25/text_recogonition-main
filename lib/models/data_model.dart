import 'package:flutter/cupertino.dart';

class Data {
  Data({
    String? data,
    String? id,
    String? photoUrl,
    String? uid,

  }) {
    _data = data;
    _id = id;
    _photoUrl = photoUrl;
    _uid = uid;

  }

  Data.fromJson(dynamic json) {
    _data = json['data'];
    _id = json['id'];
    _photoUrl = json['photoUrl'];
     _uid = json['uid'];

  }

  String? _data;
  String? _id;
  String? _photoUrl;
  String? _uid;


  String? get data => _data;
  String? get id => _id;
  String? get photoUrl => _photoUrl;
  String? get uid => _uid;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['id'] = _id;
    map['photoUrl'] = _photoUrl;
map['uid'] = _uid;

    return map;
  }
}