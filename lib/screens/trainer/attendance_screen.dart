import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/app_utils.dart';
import 'package:mentor_mate/constants.dart';

class AdminAttendanceScreen extends StatefulWidget {
  final String comingFrom;
  const AdminAttendanceScreen({super.key, required this.comingFrom});

  @override
  State<AdminAttendanceScreen> createState() => _AdminAttendanceScreenState();
}

class _AdminAttendanceScreenState extends State<AdminAttendanceScreen> {
  var attendances =
      FirebaseFirestore.instance.collection("Attendance").snapshots();

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
            "Attendance",
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
                            final docId = snapshot.data!.docs[index].id;
                            return GestureDetector(
                              onTap: () {
                                // Get.to(const AddTrainingAndDevelopment(),
                                //     transition: Transition.rightToLeftWithFade, arguments: "Edit");
                              },
                              child: Container(
                                color: secondaryColor.withOpacity(0.2),
                                height: 120,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Trainee Name: " +
                                                snapshot.data!.docs[index]
                                                    ["traineeName"],
                                            style: const TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                        Text(
                                            "Date: " +
                                                snapshot.data!.docs[index]
                                                    ["date"],
                                            style: const TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(height: 8),
                                        snapshot.data!.docs[index]["status"] ==
                                                "Pending" && widget.comingFrom == "Trainer"
                                            ? Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 120,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        const BoxShadow(
                                                            color:
                                                                Colors.black26,
                                                            offset:
                                                                Offset(0, 4),
                                                            blurRadius: 5.0)
                                                      ],
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 0.2),
                                                      // border: Border.all(width: 0.5,color: Colors.black),
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        stops: [0.0, 1.5],
                                                        colors: [
                                                          Colors.green,
                                                          Colors.greenAccent,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          minimumSize: MaterialStateProperty
                                                              .all(Size(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.8,
                                                                  50)),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .transparent),
                                                          // elevation: MaterialStateProperty.all(3),
                                                          shadowColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .transparent),
                                                        ),
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Attendance")
                                                              .doc(docId).update({
                                                            "status": "Approved"
                                                          }).then((value) {
                                                            AppUtils.instance
                                                                .showToast(
                                                                    toastMessage:
                                                                        'Attendance Approved.');
                                                           setState(() {

                                                           });
                                                          });
                                                        },
                                                        child: const Text(
                                                            'Approve',
                                                            style:
                                                                buttonStyle)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width: 120,
                                                    height: 35,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        const BoxShadow(
                                                            color:
                                                                Colors.black26,
                                                            offset:
                                                                Offset(0, 4),
                                                            blurRadius: 5.0)
                                                      ],
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 0.2),
                                                      // border: Border.all(width: 0.5,color: Colors.black),
                                                      gradient:
                                                          const LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        stops: [0.0, 1.5],
                                                        colors: [
                                                          Colors.red,
                                                          Colors.redAccent,
                                                        ],
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          minimumSize: MaterialStateProperty
                                                              .all(Size(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.8,
                                                                  50)),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .transparent),
                                                          // elevation: MaterialStateProperty.all(3),
                                                          shadowColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .transparent),
                                                        ),
                                                        onPressed: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                              "Attendance")
                                                              .doc(docId).update({
                                                            "status": "Declined"
                                                          }).then((value) {
                                                            AppUtils.instance
                                                                .showToast(
                                                                toastMessage:
                                                                'Attendance Declined.');
                                                            setState(() {

                                                            });
                                                          });
                                                        },
                                                        child: const Text(
                                                            'Decline',
                                                            style:
                                                                buttonStyle)),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                snapshot.data!.docs[index]
                                                    ["status"],
                                                style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    color: snapshot.data!.docs[index]["status"] == "Pending" ? Colors.deepPurple  : (snapshot.data!.docs[index]["status"] == "Pending" ? Colors.red : Colors.green),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14)),
                                      ]),
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
        ));
  }
}
