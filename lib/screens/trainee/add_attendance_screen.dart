import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentor_mate/app_utils.dart';
import 'package:mentor_mate/constants.dart';

class AddAttendanceScreen extends StatefulWidget {
  final String traineeName;
  final String traineeId;

  const AddAttendanceScreen({super.key, required this.traineeName, required this.traineeId});

  @override
  State<AddAttendanceScreen> createState() => _AddAttendanceScreenState();
}

class _AddAttendanceScreenState extends State<AddAttendanceScreen> {
  var attendanceDateController = TextEditingController();

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
          "Add Attendance",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mark Attendance",
              style: TextStyle(
                  fontSize: 24,
                color: textColor
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              child: TextFormField(
                controller: attendanceDateController,
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
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
                          MediaQuery.of(context).size.width, 50)),
                      backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                      // elevation: MaterialStateProperty.all(3),
                      shadowColor:
                      MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      addAttendance();
                    },
                    child: const Text('Submit', style: buttonStyle)),
              ),
            )


          ],
        ),
      ),
    );
  }

  void addAttendance() {
    if (attendanceDateController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please select date');
    } else {
      FirebaseFirestore.instance.collection("Attendance").add({
        "date": attendanceDateController.text,
        "traineeName": widget.traineeName,
        "traineeId": widget.traineeId,
        "status": "Pending"
      }).then((value) {
        AppUtils.instance.showToast(toastMessage: 'Attendance marked.');
        Navigator.pop(context, "added");
      });
    }
  }

  Future selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now(),
    );
    if (picked != null) {
      print("picked $picked");
      setState(() =>
      attendanceDateController.text = DateFormat('dd/MM/yyyy').format(picked));
      print("Attendance Date ${attendanceDateController.text}");
    }
  }

}
