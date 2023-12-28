import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:text_recogonition/admin/admin_home.dart';
import 'package:text_recogonition/auth/welcome_screen.dart';
import 'package:text_recogonition/home.dart';

import '../components/components.dart';
import '../constants.dart';
import '../user/open_screen.dart';
import '../user/user_home.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});
  static const routeName = '/adminLogin';

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, OpenScreen.id);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LoadingOverlay(
          isLoading: _saving,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const TopScreenImage(screenImageName: 'welcome.png'),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const ScreenTitle(title: 'Login'),
                        CustomTextField(
                          textField: TextField(
                              controller: emailController,
                              onChanged: (value) {
                                _email = value;
                              },
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                  hintText: 'Email')),
                        ),
                        CustomTextField(
                          textField: TextField(
                            controller: passwordController,
                            obscureText: true,
                            onChanged: (value) {
                              _password = value;
                            },
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                            decoration: kTextInputDecoration.copyWith(
                                hintText: 'Password'),
                          ),
                        ),
                        CustomBottomScreen(
                          textButton: 'Login',
                          heroTag: 'login_btn',
                          question: 'Forgot password?',
                          buttonPressed: () async {
                            var email = emailController.text.trim();
                            var password = passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              MotionToast(
                                      primaryColor: Colors.blue,
                                      width: 300,
                                      height: 50,
                                      position: MotionToastPosition.center,
                                      description:
                                          Text("please fill all fields"))
                                  .show(context);

                              return;
                            }
  if (email != 'admin@gmail.com') {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("wrong email or password"))
                                        .show(context);

                                    return;
                                  }

                                  if (password != '123456789') {
                                    MotionToast(
                                            primaryColor: Colors.blue,
                                            width: 300,
                                            height: 50,
                                            position:
                                                MotionToastPosition.center,
                                            description:
                                                Text("wrong email or password"))
                                        .show(context);

                                    return;
                                  }

                            ProgressDialog progressDialog = ProgressDialog(
                                context,
                                title: Text('Logging In'),
                                message: Text('Please Wait'));
                            progressDialog.show();

                            try {
                              FirebaseAuth auth = FirebaseAuth.instance;
                              UserCredential userCredential =
                                  await auth.signInWithEmailAndPassword(
                                      email: email, password: password);

                              if (userCredential.user != null) {
                                progressDialog.dismiss();
                                Navigator.pushNamed(context, AdminHome.routeName);
                              }
                            } on FirebaseAuthException catch (e) {
                              progressDialog.dismiss();
                              if (e.code == 'user-not-found') {
                                MotionToast(
                                        primaryColor: Colors.blue,
                                        width: 300,
                                        height: 50,
                                        position: MotionToastPosition.center,
                                        description: Text("user not found"))
                                    .show(context);

                                return;
                              } else if (e.code == 'wrong-password') {
                                MotionToast(
                                        primaryColor: Colors.blue,
                                        width: 300,
                                        height: 50,
                                        position: MotionToastPosition.center,
                                        description:
                                            Text("wrong email or password"))
                                    .show(context);

                                return;
                              }
                            } catch (e) {
                              MotionToast(
                                      primaryColor: Colors.blue,
                                      width: 300,
                                      height: 50,
                                      position: MotionToastPosition.center,
                                      description: Text("something went wrong"))
                                  .show(context);

                              progressDialog.dismiss();
                            }
                          },
                          questionPressed: () {
                            signUpAlert(
                              onPressed: () async {
                                await FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: _email);
                              },
                              title: 'RESET YOUR PASSWORD',
                              desc:
                                  'Click on the button to reset your password',
                              btnText: 'Reset Now',
                              context: context,
                            ).show();
                          },
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
