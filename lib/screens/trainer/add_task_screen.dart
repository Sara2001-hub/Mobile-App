import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_mate/app_utils.dart';

import '../../constants.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var taskTitleController = TextEditingController();
  var taskDetailController = TextEditingController();
  var taskDateController = TextEditingController();
  var taskTimeController = TextEditingController();
  var traineesController = TextEditingController();
  List<TraineeModel> selectedTrainees = [];
  List<String> selectedTraineeIds = [];
  var trainees = FirebaseFirestore.instance.collection("Trainee").snapshots();
  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          elevation: 1,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
          centerTitle: true,
          title: const Text(
            "Add Task",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Task",
                    style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  Text(
                    "Let's be productive!",
                    style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: TextFormField(
                controller: taskTitleController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: textColor, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "",

                  //make hint text
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Task Name',
                  labelStyle: const TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: TextFormField(
                controller: taskDetailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: textColor, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "",

                  //make hint text
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Description',
                  labelStyle: const TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: TextFormField(
                controller: taskDateController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                onTap: () {
                  selectDate();
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: textColor, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "",

                  //make hint text
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Date',
                  labelStyle: const TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: TextFormField(
                controller: taskTimeController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                onTap: () {
                  selectTime(context);
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: textColor, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "",

                  //make hint text
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Time',
                  labelStyle: const TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              height: selectedTrainees.length * 35,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     crossAxisSpacing: 10,
                  //     mainAxisSpacing: 10,
                  //     mainAxisExtent: 35,
                  //     childAspectRatio: 2.9),
                  itemCount: selectedTrainees.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 30,
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: secondaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: secondaryColor.withOpacity(0.3)),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              selectedTrainees[index].name ?? "",
                              style: const TextStyle(
                                color: textColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTraineeIds
                                      .remove(selectedTrainees[index].id);
                                });
                                for (var employee in selectedTrainees) {
                                  if (employee.id == selectedTrainees[index].id) {
                                    selectedTrainees.remove(employee);
                                  }
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.close,
                                  size: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                selectTraineesPopup();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  enabled: false,
                  controller: traineesController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "* Required";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    label: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: textColor,
                        ),
                        Text(
                          "Add trainees",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    hintStyle: TextStyle(
                      color: Color(0xFF89889B),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 5.0)
                    ],
                    border: Border.all(color: Colors.white, width: 0.2),
                    // border: Border.all(width: 0.5,color: Colors.black),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.5],
                      colors: [
                        primaryColor,
                        primaryColorLight,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(Size(
                            MediaQuery.of(context).size.width, 50)),
                        backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                        // elevation: MaterialStateProperty.all(3),
                        shadowColor:
                        MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        addTask();
                      },
                      child: const Text('Add Task', style: buttonStyle)),
                ),
              ),
            )

          ],
        ));
  }

  selectTraineesPopup() {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            backgroundColor: Colors.white,
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      child: StreamBuilder(
                          stream: trainees,
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
                                      style: TextStyle(fontFamily: "Poppins")));
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
                                    return GestureDetector(
                                      onTap: () {
                                        if (selectedTraineeIds.contains(
                                            snapshot.data!.docs[index]['id'])) {
                                          setDialogState(() {
                                            selectedTraineeIds.remove(
                                                snapshot.data!.docs[index]['id']);
                                          });
                                          for (var employee
                                              in selectedTrainees) {
                                            if (employee.id ==
                                                snapshot.data!.docs[index]['id']) {
                                              selectedTrainees.remove(employee);
                                            }
                                          }
                                        } else {
                                          TraineeModel traineeModel =
                                              TraineeModel();
                                          traineeModel.name = snapshot.data!
                                              .docs[index]["name"];
                                          traineeModel.id =
                                              snapshot.data!.docs[index]['id'];
                                          selectedTrainees.add(traineeModel);
                                          setDialogState(() {
                                            selectedTraineeIds.add(
                                                snapshot.data!.docs[index]['id']);
                                          });
                                        }
                                      },
                                      child: ListTile(
                                        tileColor: index.isOdd
                                            ? Colors.blueGrey.withOpacity(0.1)
                                            : Colors.white,
                                        title: Text(
                                            snapshot.data!.docs[index]
                                                ["name"],
                                            style: const TextStyle(
                                                fontFamily: "Poppins")),
                                        leading: Text('${index + 1}',
                                            style: const TextStyle(
                                                fontFamily: "Poppins")),
                                        trailing: Visibility(
                                            visible: selectedTraineeIds
                                                .contains(snapshot
                                                    .data!.docs[index]['id']),
                                            child: const Icon(
                                              Icons.check,
                                              size: 20,
                                              color: Colors.green,
                                            )),
                                        // trailing: Icons,
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
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            const BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 4),
                                blurRadius: 5.0)
                          ],
                          border: Border.all(color: Colors.white, width: 0.2),
                          // border: Border.all(width: 0.5,color: Colors.black),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.0, 1.5],
                            colors: [
                              primaryColor,
                              primaryColorLight,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(Size(
                                  MediaQuery.of(context).size.width * 0.8, 50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              // elevation: MaterialStateProperty.all(3),
                              shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            onPressed: () {
                              setState(() {});
                              Navigator.pop(context);
                              },
                            child: const Text('Done', style: buttonStyle)),
                      ),
                    )
                  ],
                ),
              ),
            ));
      }),
    );
  }

  Future selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025));
    if (picked != null) {
      print("picked $picked");
      setState(() =>
          taskDateController.text = DateFormat('dd/MM/yyyy').format(picked));
      print("dobController ${taskDateController.text}");
    }
  }

  selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
        helpText: "Select Time",
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 150.0),
            child: SizedBox(
              height: 520,
              child: Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: primaryColor,
                  colorScheme: const ColorScheme.light(
                    primary: primaryColor,
                  ),
                  buttonTheme:
                      const ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              ),
            ),
          );
        });
    if (picked != null) {
      String formattedTime =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

      taskTimeController.text = formattedTime;
    }
  }

  void addTask() {
    if (taskTitleController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please enter Task Name');
    }
    else  if (taskDetailController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please enter Task Description');
    }
    else if (taskDateController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please select task due date');
    }
    else if (taskTimeController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please select task due time');
    }
    else if (selectedTrainees.isEmpty) {
      AppUtils.instance.showToast(
          toastMessage: 'Please select at least one trainee');
    }

    else {
      FirebaseFirestore.instance.collection("Tasks").add({
        "taskName": taskTitleController.text,
        "description": taskDetailController.text,
        "date": taskDateController.text,
        "time": taskTimeController.text,
        "trainee": jsonEncode(selectedTraineeIds)
      }).then((value) {
        AppUtils.instance.showToast(
            toastMessage: 'Task added.');
        Navigator.pop(context, "added");
      });
    }
  }
}

class TraineeModel {
  String? name;
  String? id;
}
