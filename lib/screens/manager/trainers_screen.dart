import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/screens/manager/add_trainer_screen.dart';
import 'package:mentor_mate/screens/trainer/add_trainee_screen.dart';

import '../../app_utils.dart';
import '../../constants.dart';

class TrainersScreen extends StatefulWidget {
  const TrainersScreen({super.key});

  @override
  State<TrainersScreen> createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen> {
  var trainers = FirebaseFirestore.instance.collection("Trainer").snapshots();

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
          "Trainers",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: StreamBuilder(
                stream: trainers,
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
                          final docId = snapshot.data!.docs[index].id;
                          return GestureDetector(
                            onTap: () {
                              // Get.to(const AddTrainingAndDevelopment(),
                              //     transition: Transition.rightToLeftWithFade, arguments: "Edit");
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: secondaryColor.withOpacity(0.4)),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!.docs[index]["name"],
                                            style: const TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500)),
                                        Text(
                                            snapshot.data!.docs[index]
                                                ["mobileNumber"],
                                            style: const TextStyle(
                                                fontFamily: "Poppins")),
                                        Text(
                                            snapshot.data!.docs[index]["email"],
                                            style: const TextStyle(
                                                fontFamily: "Poppins")),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: Text('Delete Trainer'),
                                                  content: Text(
                                                      'Do you want to delete this trainer?'),
                                                  actions: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  primaryColor,
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(false),
                                                      //return false when click on "NO"
                                                      child: Text('No'),
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Trainer")
                                                              .doc(docId)
                                                              .delete()
                                                              .then((value) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(true);

                                                            AppUtils.instance
                                                                .showToast(
                                                                    toastMessage:
                                                                        'Trainer deleted.');

                                                            setState(() {});
                                                          });
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                            backgroundColor: Colors.red,
                                                            textStyle: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        child: Text('Yes'))
                                                  ],
                                                ),
                                              );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.delete_rounded,
                                                  color: Colors.red,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AddTrainerScreen(comingFrom: "edit",
                                                    name: snapshot.data!.docs[index]["name"],
                                                      email: snapshot.data!.docs[index]["email"],
                                                      mobileNumber: snapshot.data!.docs[index]["mobileNumber"],
                                                      docId: snapshot.data!.docs[index].id,
                                                    )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit,
                                                  color: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  "Edit",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
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
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddTrainerScreen(comingFrom: "add",)));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
