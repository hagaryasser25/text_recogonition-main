import 'package:firebase_database/firebase_database.dart';

class Users {
  String? id;
  String? data;
  String? photoUrl;


  Users({this.id, this.data, this.photoUrl});

  Users.fromSnapshot(DataSnapshot dataSnapshot) {
    data = (dataSnapshot.child("data").value.toString());
    id = (dataSnapshot.child("id").value.toString());
    photoUrl = (dataSnapshot.child("photoUrl").value.toString());

  }
}