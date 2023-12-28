import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gtext/gtext.dart';
import 'package:text_recogonition/admin/admin_data.dart';
import 'package:text_recogonition/admin/admin_home.dart';
import 'package:text_recogonition/auth/admin_login.dart';
import 'package:text_recogonition/auth/welcome_screen.dart';
import 'package:text_recogonition/home.dart';
import 'package:text_recogonition/user/display_screen.dart';
import 'package:text_recogonition/user/open_screen.dart';
import 'package:text_recogonition/user/translate_screen.dart';
import 'package:text_recogonition/user/user_home.dart';
import 'package:translator/translator.dart';


import 'auth/login_screen.dart';
import 'auth/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const OpenScreen()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : const UserHome(),
      routes: {
        OpenScreen.id: (context) => OpenScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        AdminLogin.routeName: (context) => AdminLogin(),
        AdminHome.routeName: (context) => AdminHome(),
        AdminData.routeName: (context) => AdminData(),
        SignUpScreen.id: (context) => SignUpScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomePage.routeName: (context) => HomePage(),
        UserHome.routeName: (context) => UserHome(),
      },
    );
  }
}
