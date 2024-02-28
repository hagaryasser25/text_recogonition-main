import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:text_recogonition/home.dart';
import 'package:text_recogonition/user/open_screen.dart';
import 'package:text_recogonition/user/user_data.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/tes';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title:
              Center(child: Text("Home", style: TextStyle(color: Colors.white))),
          backgroundColor: Color.fromARGB(255, 142, 145, 231),
          actions: [
            //<-- SEE HERE
            IconButton(
              icon: Center(
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Confirmation"),
                        content: Text('Are you sure that you want to logout'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushNamed(context, OpenScreen.id);
                            },
                            child: Text("yes"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Image.asset("assets/images/home2.jpg"),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
              ),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, UserData.routeName);
                      },
                      child: card('assets/images/data.png', "data")),
                  SizedBox(
                    width: 15.w,
                  ),
                  InkWell(
                      onTap: () {
                       Navigator.pushNamed(context, HomePage.routeName);
                      },
                      child: card('assets/images/scan.png', "scan photo")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget card(String url, String text) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: SizedBox(
      width: 150.w,
      height: 170.h,
      child: Column(children: [
        SizedBox(
          height: 10.h,
        ),
        Container(width: 100.w, height: 100.h, child: Image.asset(url)),
        SizedBox(height: 5),
        Text(text, style: TextStyle(fontSize: 18, color: HexColor('#32486d')))
      ]),
    ),
  );
}
