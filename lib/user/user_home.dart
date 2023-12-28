import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text_recogonition/home.dart';
import 'package:text_recogonition/user/open_screen.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/tes';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home")),
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
          Center(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 90,
                  ),
                  child: Text("add photo to scan it"),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, size: 30),
                  onPressed: () {
                    Navigator.pushNamed(context, HomePage.routeName);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
