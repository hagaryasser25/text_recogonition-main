import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:text_recogonition/admin/admin_data.dart';
import 'package:text_recogonition/models/data_model.dart';
import 'package:text_recogonition/models/students_model.dart';

class AdminStudents extends StatefulWidget {
  static const routeName = '/admin-students';
  const AdminStudents({super.key});

  @override
  State<AdminStudents> createState() => _AdminStudentsState();
}

class _AdminStudentsState extends State<AdminStudents> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Students> studentsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchStudents();
  }

  @override
  void fetchStudents() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("users");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Students p = Students.fromJson(event.snapshot.value);
      studentsList.add(p);
      print(studentsList.length);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
          title: Center(child: Text("Students Data", style: TextStyle(color: Colors.white),)),
          backgroundColor: Color.fromARGB(255, 142, 145, 231),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                  bottom: 15.h,
                ),
                crossAxisCount: 6,
                itemCount: studentsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w, left: 10.w),
                        child: Center(
                          child: Column(children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Image.asset('assets/images/student.png',
                                width: 155.w, height: 100.h),
                            SizedBox(
                              height: 10.h,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${studentsList[index].name.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                            Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${studentsList[index].email.toString()}',
                                  style: TextStyle(fontSize: 15),
                                )),
                            /*
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      super.widget));
                          base
                              .child(studentsList[index].uid.toString())
                              .remove();
                        },
                        child: Icon(Icons.delete,
                            color: Color.fromARGB(255, 122, 122, 122)),
                      ),
                      */
                            SizedBox(
                              height: 10.h,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                                padding: const EdgeInsets.all(0.0),
                                elevation: 5,
                              ),
                              onPressed: () async {
                                
                                    
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AdminData(
                                        uid: '${studentsList[index].uid.toString()}',
                                      );
                                    }));
                                    
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 142, 145, 231),
                                    Color.fromARGB(255, 160, 130, 237)
                                  ]),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  constraints:
                                      const BoxConstraints(minWidth: 88.0),
                                  child: const Text("data",
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(3, index.isEven ? 3 : 3),
                mainAxisSpacing: 40.0,
                crossAxisSpacing: 5.0.w,
              ),
            )
          ],
        ),
      ),
    );
  }
}
