

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/constants.dart';
import 'package:mentor_mate/firebase_auth.dart';
import 'package:mentor_mate/screens/trainee/ChatBotScreen.dart';
import 'package:mentor_mate/screens/trainee/my_attendance_screen.dart';
import 'package:mentor_mate/screens/trainee/my_tasks_screen.dart';
import 'package:mentor_mate/screens/trainee/notifications_screen.dart';
import 'package:mentor_mate/screens/trainer/send_notification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TraineeHomeScreen extends StatefulWidget {
  final String userType;
  const TraineeHomeScreen({super.key, required this.userType});

  @override
  State<TraineeHomeScreen> createState() => _TraineeHomeScreenState();
}

class _TraineeHomeScreenState extends State<TraineeHomeScreen> {

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
    super.initState();
    userType = '';
    email = '';
    uid = '';
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        backgroundColor: primaryColor,
        //primaryColor1,
        title: const Text(
          "Mentor Mate",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: size.height * 0.12,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Welcome",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),),
                  Text(name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),),
                  Text("Email: $email",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16
                    ),),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * .65,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.count(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 15,
                children: [
                  // InkWell(
                  //   onTap: (){
                  //     // Navigator.push(context,
                  //     //     MaterialPageRoute(builder: (BuildContext context) => TraineesScreen()));
                  //   },
                  //   child: Container(
                  //     height: size.height * 0.25,
                  //     decoration: BoxDecoration(
                  //       color: Colors.deepOrange,
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: const Column(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Icon(Icons.people, color: Colors.white, size: 50,),
                  //         Text("List of Trainees",
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.w600,
                  //               fontSize: 18
                  //           ),),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => const MyTasksScreen()));
                    },
                    child: Container(
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.task, color: Colors.white, size: 50,),
                          SizedBox(height: 10,),
                          Text("My Tasks",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => const MyAttendanceScreen()));
                    },
                    child: Container(
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.emoji_people, color: Colors.white, size: 50,),
                          SizedBox(height: 10,),
                          Text("My Attendance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => const ChatBotScreen()));
                    },
                    child: Container(
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.support_agent_rounded, color: Colors.white, size: 50,),
                          SizedBox(height: 10,),
                          Text("Chatbot",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => const SendNotificationScreen()));
                    },
                    child: Container(
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.feedback_rounded, color: Colors.white, size: 50,),
                          SizedBox(height: 10,),
                          Text("Feedback",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),),
                        ],
                      ),
                    ),
                  ),
                ],),
            ),
          )
        ],
      ),
    );
  }
}
