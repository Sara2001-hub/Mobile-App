import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/constants.dart';
import 'package:mentor_mate/screens/trainer/add_task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTasksScreen extends StatefulWidget {
  const MyTasksScreen({super.key});

  @override
  State<MyTasksScreen> createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasksScreen> {
  var tasks = FirebaseFirestore.instance.collection("Tasks").snapshots();

  TaskModel modelTask = TaskModel();
  List<TaskModel> myTasks = [];
  
  getMyTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String traineeId = prefs.getString("userId") ?? "";

    FirebaseFirestore.instance.collection('Tasks')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        modelTask = TaskModel();
        modelTask.title = doc['taskName'];
        modelTask.description = doc["description"];
        modelTask.date = doc["date"];
        modelTask.time = doc["time"];
        modelTask.trainees = json.decode(doc["trainee"]);
        for (var employee in modelTask.trainees ?? []) {
          if (employee == traineeId) {
            setState(() {
              myTasks.add(modelTask);
            });
          }
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getMyTasks();
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
          "My Tasks",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child:  ListView.builder(
                itemCount: myTasks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        tileColor: secondaryColor.withOpacity(0.2),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(myTasks[index].title ?? "",
                                style: const TextStyle(
                                    fontFamily: "Poppins")),
                            Text(
                                myTasks[index].description ?? "",
                                style: const TextStyle(
                                    fontFamily: "Poppins")),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Due Date",
                                style: const TextStyle(
                                  fontSize: 14,
                                    fontFamily: "Poppins")),
                            Text(
                                "${myTasks[index].date ?? ""} ${myTasks[index].time ?? ""}",
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}


class TaskModel {
  String? title;
  String? description;
  String? date;
  String? time;
  List? trainees;
}