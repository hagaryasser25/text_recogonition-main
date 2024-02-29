import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:text_recogonition/user/user_home.dart';

class DisplayScreen extends StatefulWidget {
  final String text;
  final String imagePath;
  const DisplayScreen({super.key, required this.imagePath, required this.text});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              padding: const EdgeInsets.all(30),
              child: Image.network('${widget.imagePath}'),
            ),
            Text(widget.text),
            ConstrainedBox(
              constraints:
                  BoxConstraints.tightFor(width: double.infinity, height: 65),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: HexColor('#6bbcba'),
                ),
                onPressed: () async {
                  String data = widget.text;
                  String url = widget.imagePath;

                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    String uid = user.uid;
                    int date = DateTime.now().millisecondsSinceEpoch;

                    DatabaseReference companyRef =
                        FirebaseDatabase.instance.reference().child('data');

                    String? id = companyRef.push().key;

                    await companyRef.child(uid).set({
                      'id': id,
                      'photoUrl': url,
                      'data': data,
                      'uid': uid,
                    });
                  }
                  showAlertDialog(context);
                },
                child: Text("save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("the data has been saved"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
