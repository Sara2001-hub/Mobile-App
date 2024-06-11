

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var notifications =
  FirebaseFirestore.instance.collection("Feedback").snapshots();


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
          "Feedback",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    body: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: StreamBuilder(
              stream: notifications,
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
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ListTile(
                                tileColor: secondaryColor.withOpacity(0.2),
                                title: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data!.docs[index]["title"],
                                        style: const TextStyle(
                                            fontFamily: "Poppins")),
                                    Text(
                                        snapshot.data!.docs[index]["description"] ?? "",
                                        style: const TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.green,
                                            fontWeight: FontWeight.w500,
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
    );
  }
}
