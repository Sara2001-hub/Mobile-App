import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/constants.dart';
import 'package:mentor_mate/screens/trainer/add_task_screen.dart';

class TasksScreen extends StatefulWidget {
  final String comingFrom;
  const TasksScreen({super.key, required this.comingFrom});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  var tasks = FirebaseFirestore.instance.collection("Tasks").snapshots();

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
          "Tasks",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: StreamBuilder(
                stream: tasks,
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
                          return GestureDetector(
                            onTap: () {
                              // Get.to(const AddTrainingAndDevelopment(),
                              //     transition: Transition.rightToLeftWithFade, arguments: "Edit");
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ListTile(
                                tileColor: secondaryColor.withOpacity(0.2),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data!.docs[index]["taskName"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Poppins")),
                                    Text(
                                        snapshot.data!.docs[index]
                                            ["description"],
                                        style: const TextStyle(
                                            fontFamily: "Poppins")),
                                  ],
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Due Date",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14)),
                                    Text(
                                        snapshot.data!.docs[index]["date"] +
                                            " " +
                                            snapshot.data!.docs[index]["time"],
                                        style: const TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14)),
                                  ],
                                ),
                              ),
                            ),
                          );
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
      floatingActionButton: widget.comingFrom == "Trainer" ?
      FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTaskScreen()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )): Container(),
    );
  }
}
