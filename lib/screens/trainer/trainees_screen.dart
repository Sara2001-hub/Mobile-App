

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/app_utils.dart';
import 'package:mentor_mate/screens/trainer/add_trainee_screen.dart';

import '../../constants.dart';

class TraineesScreen extends StatefulWidget {
  final String comingFrom;
  const TraineesScreen({super.key, required this.comingFrom});

  @override
  State<TraineesScreen> createState() => _TraineesScreenState();
}

class _TraineesScreenState extends State<TraineesScreen> {

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
          "Trainees",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Trainee").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text("Something went wrong",
                            style: TextStyle(
                                fontFamily: "Poppins")));
                  } else if (!snapshot.hasData) {
                    return const Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle(fontFamily: "Poppins"),
                        ));
                  } else if (snapshot
                      .requireData.docChanges.isEmpty) {
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
                            onTap: (){
                              // Get.to(const AddTrainingAndDevelopment(),
                              //     transition: Transition.rightToLeftWithFade, arguments: "Edit");
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: secondaryColor.withOpacity(0.4)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            snapshot.data!.docs[index]
                                            ["name"],
                                            style: const TextStyle(
                                                fontFamily: "Poppins", fontWeight: FontWeight.w500)),
                                        Text(
                                            snapshot.data!.docs[index]
                                            ["department"],
                                            style: const TextStyle(
                                                fontFamily: "Poppins")),
                                        Text(
                                            snapshot.data!.docs[index]
                                            ["mobileNumber"],
                                            style: const TextStyle(
                                                fontFamily: "Poppins")),
                                        Text(
                                            snapshot.data!.docs[index]
                                            ["email"],
                                            style: const TextStyle(
                                                fontFamily: "Poppins")),
                                      ],
                                    ),
                                    Visibility(
                                      visible: widget.comingFrom == "Manager",
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: Text('Delete Trainee'),
                                                      content: Text(
                                                          'Do you want to delete this trainee?'),
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
                                                                  "Trainee")
                                                                  .doc(docId)
                                                                  .delete()
                                                                  .then((value) {


                                                                Navigator.of(
                                                                    context)
                                                                    .pop(true);

                                                                AppUtils.instance
                                                                    .showToast(
                                                                    toastMessage:
                                                                    'Trainee deleted.');

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
                                                      builder: (context) => AddTraineeScreen(comingFrom: "edit",
                                                        name: snapshot.data!.docs[index]["name"],
                                                        email: snapshot.data!.docs[index]["email"],
                                                        mobileNumber: snapshot.data!.docs[index]["mobileNumber"],
                                                        docId: snapshot.data!.docs[index].id,
                                                        department: snapshot.data!.docs[index]["department"],
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
                                      ),
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
                            style: TextStyle(
                                fontFamily: "Poppins")));
                  }
                }),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddTraineeScreen(comingFrom: "add",)));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
