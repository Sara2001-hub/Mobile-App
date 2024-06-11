import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/app_utils.dart';
import 'package:mentor_mate/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddTraineeScreen extends StatefulWidget {
  final String comingFrom;
  final String? name;
  final String? mobileNumber;
  final String? email;
  final String? department;
  final String? docId;

  const AddTraineeScreen(
      {super.key,
      required this.comingFrom,
      this.name,
      this.mobileNumber,
      this.email,
      this.department,
      this.docId});

  @override
  State<AddTraineeScreen> createState() => _AddTraineeScreenState();
}

class _AddTraineeScreenState extends State<AddTraineeScreen> {
  var nameController = TextEditingController();
  var departmentController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool showLoader = false;
  String traineeId = "";

  @override
  void initState() {
    // TODO: implement initState
    if (widget.comingFrom == "edit") {
      nameController.text = widget.name ?? "";
      mobileController.text = widget.mobileNumber ?? "";
      emailController.text = widget.email ?? "";
      departmentController.text = widget.department ?? "";
    }
    super.initState();
  }

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
        title: Text(
          widget.comingFrom == "add" ? "Add Trainee" : "Edit Trainee",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showLoader,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
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
                  labelText: 'Name',
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
                controller: departmentController,
                keyboardType: TextInputType.name,
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
                  labelText: 'Department',
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
                controller: mobileController,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return 'Enter a valid mobile number';
                  }
                  return null;
                },
                keyboardType: TextInputType.phone,
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
                  labelText: 'Mobile Number',
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
                controller: emailController,
                enabled:  widget.comingFrom == "add",
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
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.comingFrom == "add",
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return 'Enter a valid password';
                    } else if (value.length < 8) {
                      return 'Password must be atLeast 8 characters';
                    }
                    return null;
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
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontFamily: "Poppins",
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width, 50)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.transparent),
                        // elevation: MaterialStateProperty.all(3),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        widget.comingFrom == "add" ?  addTrainee() : ediTrainee(widget.docId ?? "");
                      },
                      child: Text(
                          widget.comingFrom == "add"
                              ? "Add Trainee"
                              : "Edit Trainee",
                          style: buttonStyle)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addTrainee() async {
    if (nameController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please enter Trainee\'s Name');
    } else if (departmentController.text.isEmpty) {
      AppUtils.instance
          .showToast(toastMessage: 'Please enter Trainee\'s Department');
    } else if (mobileController.text.isEmpty) {
      AppUtils.instance
          .showToast(toastMessage: 'Please enter Trainee\'s Mobile Number');
    } else if (emailController.text.isEmpty) {
      AppUtils.instance
          .showToast(toastMessage: 'Please enter Trainee\'s Email Address');
    } else if (passwordController.text.isEmpty) {
      AppUtils.instance
          .showToast(toastMessage: 'Please enter Trainee\'s Password');
    } else {
      setState(() {
        showLoader = true;
      });
      registerTraineeUsingEmailPassword(
              traineeName: nameController.text,
              emailID: emailController.text,
              password: passwordController.text,
              context: context)
          .then((user) {
            if(traineeId.isNotEmpty) {
              FirebaseFirestore.instance.collection("Trainee").add({
                "name": nameController.text,
                "department": departmentController.text,
                "mobileNumber": mobileController.text,
                "email": emailController.text,
                "id": traineeId
              }).then((value) {
                AppUtils.instance.showToast(toastMessage: 'Trainee added.');
                setState(() {
                  showLoader = false;
                });
                Navigator.pop(context, "added");
              });
            }
      });
    }
  }


  void ediTrainee(String docId) async {
    if (nameController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please enter Trainee\'s Name');
    } else if (departmentController.text.isEmpty) {
      AppUtils.instance
          .showToast(toastMessage: 'Please enter Trainee\'s Department');
    } else if (mobileController.text.isEmpty) {
      AppUtils.instance
          .showToast(toastMessage: 'Please enter Trainee\'s Mobile Number');
    } else if (emailController.text.isEmpty) {
      AppUtils.instance
          .showToast(toastMessage: 'Please enter Trainee\'s Email Address');
    }  else {
      setState(() {
        showLoader = true;
      });

        FirebaseFirestore.instance.collection("Trainee").doc(docId).update({
          "name": nameController.text,
          "department": departmentController.text,
          "mobileNumber": mobileController.text,
        }).then((value) {
          AppUtils.instance.showToast(toastMessage: 'Trainee updated.');
          setState(() {
            showLoader = false;
          });
          Navigator.pop(context, "added");
      });
    }
  }

  Future<User?> registerTraineeUsingEmailPassword(
      {required String traineeName,
      required String emailID,
      required String password,
      required BuildContext? context}) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'secondary', options: Firebase.app().options);
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(
        email: emailID,
        password: password,
      );
      // UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      //   email: emailID,
      //   password: password,
      // );
      user = userCredential.user;
      // await user!.updateDisplayName(traineeName);
      // await user.reload();
      // user = auth.currentUser;
      traineeId = user?.uid ?? "";
      // app.delete();
      // user = userCredential.user;
      // await user!.updateDisplayName(employeeName);
      // debugPrint("add trainee ${user!.displayName}");
      // debugPrint("add trainee $user");
      // await user.reload();
      // user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoader = false;
      });
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');

        AppUtils.instance
            .showToast(toastMessage: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        AppUtils.instance.showToast(
            toastMessage: "The account already exists for that email.");
      }
    } catch (e) {
      setState(() {
        showLoader = false;
      });
      debugPrint(e.toString());
    }
    return user;
  }
}
