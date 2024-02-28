import 'package:flutter/cupertino.dart';

class Students {
  Students({
    String? email,
    String? uid,
    String? name,

  }) {
    _email = email;
    _uid = uid;
    _name = name;

  }

  Students.fromJson(dynamic json) {
    _email = json['email'];
    _uid = json['uid'];
    _name = json['name'];

  }

  String? _email;
  String? _uid;
  String? _name;


  String? get email => _email;
  String? get uid => _uid;
  String? get name => _name;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['uid'] = _uid;
    map['name'] = _name;


    return map;
  }
}