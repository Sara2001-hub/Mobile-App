import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentor_mate/app_utils.dart';
import 'package:mentor_mate/constants.dart';
import 'package:mentor_mate/screens/download_file.dart';
import 'package:mentor_mate/screens/manager/trainers_screen.dart';
import 'package:mentor_mate/screens/trainee/notifications_screen.dart';
import 'package:mentor_mate/screens/trainer/attendance_screen.dart';
import 'package:mentor_mate/screens/trainer/send_notification_screen.dart';
import 'package:mentor_mate/screens/trainer/tasks_screen.dart';
import 'package:mentor_mate/screens/trainer/trainees_screen.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

class ManagerHomeScreen extends StatefulWidget {
  final String userType;

  const ManagerHomeScreen({super.key, required this.userType});

  @override
  State<ManagerHomeScreen> createState() => _ManagerHomeScreenState();
}

class _ManagerHomeScreenState extends State<ManagerHomeScreen> {
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
        // title: Image.asset(
        //   'assets/images/logo.jpeg',
        //   color: Colors.white,
        // fit: BoxFit.scaleDown,
        // height: 50,
        // ),
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
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Welcome",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text(
                    "Manager",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  Text(
                    "Email: manager@gmail.com",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * .674,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const TrainersScreen()));
                    },
                    child: Container(
                      height: size.height * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/manager.png",
                            color: Colors.white,
                            height: 50,
                          ),
                          // Icon(
                          //   Icons.people_outline_sharp,
                          //   color: Colors.white,
                          //   size: 50,
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "List of Trainers",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const TraineesScreen(comingFrom: "Manager")));
                    },
                    child: Container(
                      height: size.height * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_alt_sharp,
                            color: Colors.white,
                            size: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "List of Trainees",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const TasksScreen(comingFrom: "Manager")));
                    },
                    child: Container(
                      height: size.height * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task,
                            color: Colors.white,
                            size: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Tasks",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AdminAttendanceScreen(
                                      comingFrom: "Manager")));
                    },
                    child: Container(
                      height: size.height * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_people,
                            color: Colors.white,
                            size: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Attendance",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            Container(
                              height: size.height * 0.5,
                              child: Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("Download Report for: ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18
                                          )),
                                      const SizedBox(height: 15,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                          generateAndSaveAttendancesExcel();

                                        },
                                        child: Container(
                                          width: size.width * 0.5,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: primaryColorLight,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: primaryColor)
                                          ),
                                          child: Center(
                                            child: const Text("Attendances",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18
                                            ),),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);

                                          generateAndSaveTasksExcel();

                                        },
                                        child: Container(
                                          width: size.width * 0.5,
                                          height: 40, decoration: BoxDecoration(
                                            color: primaryColorLight,
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: primaryColor)
                                        ),
                                          child: Center(
                                            child: const Text("Tasks",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18
                                              ),),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                      );

                    },
                    child: Container(
                      height: size.height * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.document_scanner,
                            color: Colors.white,
                            size: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Reports",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) => const NotificationsScreen()));
                    },
                    child: Container(
                      height: size.height * 0.22,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.feedback_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Feedback",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> generateAndSaveAttendancesExcel() async {
    Fluttertoast.showToast(
      msg: 'Downloading...',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: primaryColor,
      textColor: Colors.white,
    );

    final xcel.Workbook workbook =
        xcel.Workbook(); // create a new excel workbook
    final xcel.Worksheet sheet = workbook.worksheets[
        0]; // the sheet we will be populating (only the first sheet)
    const String excelFile = 'AttendanceSheet'; // the name of the excel

    /// design how the data in the excel sheet will be presented
    /// you can get the cell to populate by index e.g., (1, 1) or by name e.g., (A1)
    sheet.getRangeByIndex(1, 1).setText('Attendances');

    // set the titles for the subject results we want to fetch
    sheet.getRangeByIndex(4, 1).setText("S.No");
    sheet.getRangeByIndex(4, 2).setText('Trainee Name');
    sheet.getRangeByIndex(4, 3).setText('Date');
    sheet.getRangeByIndex(4, 4).setText('Status');

    // loop through the results to set the data in the excel sheet cells
    FirebaseFirestore.instance
        .collection('Attendance')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var i = 0; i < (querySnapshot.docs).length; i++) {
        sheet
            .getRangeByIndex(i + 5, 1)
            .setText((i+1).toString());

        sheet
            .getRangeByIndex(i + 5, 2)
            .setText(querySnapshot.docs[i]['traineeName']);
        sheet.getRangeByIndex(i + 5, 3).setText(querySnapshot.docs[i]['date']);
        sheet.getRangeByIndex(i + 5, 4).setText(querySnapshot.docs[i]['status']);
      }

      // save the document in the downloads file
      final List<int> bytes = workbook.saveAsStream();
      File('/storage/emulated/0/Documents/$excelFile.xlsx').writeAsBytes(bytes);

      // toast message to user
      Fluttertoast.showToast(
        msg: 'Excel file successfully downloaded',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: primaryColor,
        textColor: Colors.white,
      );

      //dispose the workbook
      workbook.dispose();
    });

  }

  Future<void> generateAndSaveTasksExcel() async {
    Fluttertoast.showToast(
      msg: 'Downloading...',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: primaryColor,
      textColor: Colors.white,
    );


    final xcel.Workbook workbook =
    xcel.Workbook(); // create a new excel workbook
    final xcel.Worksheet sheet = workbook.worksheets[
    0]; // the sheet we will be populating (only the first sheet)
    const String excelFile = 'Tasks'; // the name of the excel

    /// design how the data in the excel sheet will be presented
    /// you can get the cell to populate by index e.g., (1, 1) or by name e.g., (A1)
    sheet.getRangeByIndex(1, 1).setText('Tasks');

    // set the titles for the subject results we want to fetch
    sheet.getRangeByIndex(4, 1).setText("S.No");
    sheet.getRangeByIndex(4, 2).setText('Task Name');
    sheet.getRangeByIndex(4, 3).setText('Description');
    sheet.getRangeByIndex(4, 4).setText('Due Date');

    sheet.setColumnWidthInPixels(2, 30);
    sheet.setColumnWidthInPixels(2, 60);

    // loop through the results to set the data in the excel sheet cells
    FirebaseFirestore.instance
        .collection('Tasks')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var i = 0; i < (querySnapshot.docs).length; i++) {
        sheet
            .getRangeByIndex(i + 5, 1)
            .setText((i+1).toString());

        sheet
            .getRangeByIndex(i + 5, 2)
            .setText(querySnapshot.docs[i]['taskName']);
        sheet.getRangeByIndex(i + 5, 3).setText(querySnapshot.docs[i]['description']);
        sheet.getRangeByIndex(i + 5, 4).setText(querySnapshot.docs[i]['date']);
      }

      // save the document in the downloads file
      final List<int> bytes = workbook.saveAsStream();
      File('/storage/emulated/0/Documents/$excelFile.xlsx').writeAsBytes(bytes);

      // toast message to user
      Fluttertoast.showToast(
        msg: 'Excel file successfully downloaded',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: primaryColor,
        textColor: Colors.white,
      );

      //dispose the workbook
      workbook.dispose();
    });

  }

}
