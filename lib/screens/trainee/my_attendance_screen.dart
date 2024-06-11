import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/constants.dart';
import 'package:mentor_mate/firebase_auth.dart';
import 'package:mentor_mate/screens/trainee/add_attendance_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAttendanceScreen extends StatefulWidget {
  const MyAttendanceScreen({super.key});

  @override
  State<MyAttendanceScreen> createState() => _MyAttendanceScreenState();
}

class _MyAttendanceScreenState extends State<MyAttendanceScreen> {
  var attendances =
      FirebaseFirestore.instance.collection("Attendance").snapshots();

  String userType = "";
  String email = "";
  String uid = "";
  String name = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MethodsHandler _methodsHandler = MethodsHandler();

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        uid = prefs.getString('userId')!;
        name = prefs.getString('userName')!;
      });
      print("uid: " + uid);
    } else {
      print('Starting usertype');
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          "My Attendance",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: StreamBuilder(
                stream: attendances,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text("Something went wrong",
                            style: TextStyle(fontFamily: "Poppins")));
                  } else if (!snapshot.hasData) {
                    return const Center(
                        child: Text(
                      "No Data Found",
                      style: TextStyle(fontFamily: "Poppins"),
                    ));
                  } else if (snapshot.requireData.docChanges.isEmpty) {
                    return const Center(
                        child: Text(
                      "No Data Found",
                      style: TextStyle(fontFamily: "Poppins"),
                    ));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (uid == snapshot.data!.docs[index]['traineeId']) {
                            return GestureDetector(
                              onTap: () {
                                // Get.to(const AddTrainingAndDevelopment(),
                                //     transition: Transition.rightToLeftWithFade, arguments: "Edit");
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ListTile(
                                  tileColor: secondaryColor.withOpacity(0.2),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data!.docs[index]["date"],
                                          style: const TextStyle(
                                              fontFamily: "Poppins")),
                                    ],
                                  ),
                                  trailing: Text(
                                      snapshot.data!.docs[index]["status"],
                                      style: const TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
                                ),
                              ),
                            );
                          }
                        });
                  } else {
                    return const Center(
                        child: Text('No Data Found',
                            style: TextStyle(fontFamily: "Poppins")));
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddAttendanceScreen(
                          traineeName: name,
                          traineeId: uid,
                        )));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
