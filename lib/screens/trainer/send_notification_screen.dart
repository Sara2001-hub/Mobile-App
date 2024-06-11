

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/app_utils.dart';

import '../../constants.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({super.key});

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
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
        Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
          child: TextFormField(
            controller: titleController,
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
              labelText: 'Title',
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
            controller: descriptionController,
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
              labelText: 'Type your feedback here..',
              labelStyle: const TextStyle(
                color: textColor,
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
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
                    sendFeedback();
                  },
                  child: const Text('Send', style: buttonStyle)),
            ),
          ),
        )

      ],
    ),
    );
  }

  void sendFeedback() async {
    if (titleController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please enter feedback Title');
    }
    else  if (descriptionController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please enter Description');
    }
    else {
      FirebaseFirestore.instance.collection("Feedback").add({
        "title": titleController.text,
        "description": descriptionController.text,
      }).then((value) {
        AppUtils.instance.showToast(
            toastMessage: 'Feedback sent');
        Navigator.pop(context, "added");
      });
    }
  }
}
