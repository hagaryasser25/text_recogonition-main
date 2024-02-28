import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:text_recogonition/models/data_model.dart';

class UserData extends StatefulWidget {
  static const routeName = '/user-data';
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Data> dataList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData();
  }

  @override
  void fetchData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("data").child("${FirebaseAuth.instance.currentUser!.uid}");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Data p = Data.fromJson(event.snapshot.value);
      dataList.add(p);
      print(dataList.length);
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
          title: Center(child: Text("Data")),
          backgroundColor: Color.fromARGB(255, 142, 145, 231),
        ),
        body: Padding(
                padding:  EdgeInsets.only(
                  top: 15.h,
                  right: 10.w,
                  left: 10.w,
                ),
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 15, left: 15, bottom: 10),
                          child: Column(children: [
                            Image.network(
                              height: 100,
                                        '${dataList[index].photoUrl}',
                                        fit: BoxFit.fill,
                                      ),
                            Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'student data : ${dataList[index].data.toString()}',
                                  style: TextStyle(fontSize: 17),
                                )),
                         
                          
                                InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              super.widget));
                                  base
                                      .child(dataList[index].id.toString())
                                      .remove();
                              },
                              child: Icon(Icons.delete,
                                  color: Color.fromARGB(255, 122, 122, 122)),
                            )
                          ]),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
       
    );
  }
}
