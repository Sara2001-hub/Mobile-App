
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/app_utils.dart';
import 'package:mentor_mate/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddTrainerScreen extends StatefulWidget {
  final String comingFrom;
  final String? name;
  final String? mobileNumber;
  final String? email;
  final String? docId;

  const AddTrainerScreen({super.key, required this.comingFrom, this.name, this.mobileNumber, this.email, this.docId});

  @override
  State<AddTrainerScreen> createState() => _AddTrainerScreenState();
}

class _AddTrainerScreenState extends State<AddTrainerScreen> {
  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool showLoader = false;
  String trainerId  = "";

  @override
  void initState() {
    // TODO: implement initState
    if(widget.comingFrom == "edit"){
      nameController.text = widget.name ?? "";
      mobileController.text = widget.mobileNumber ?? "";
      emailController.text = widget.email ?? "";
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
         widget.comingFrom == "add" ? "Add Trainer" : "Edit Trainer",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showLoader,
        child: Column(
          children: [
        SizedBox(height: 20,),
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
                controller: mobileController,
                validator: (value){
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
                enabled: widget.comingFrom == "add",
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
                  validator: (value){
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

                        widget.comingFrom == "add" ?    addTrainer() : editTrainer(widget.docId ?? "");
                      },
                      child: Text( widget.comingFrom == "add" ? "Add Trainer" : "Edit Trainer", style: buttonStyle)),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  void addTrainer() async {
    if (nameController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please enter Trainer\'s Name');
    }
    else if (mobileController.text.isEmpty) {
      AppUtils.instance.showToast(
          toastMessage: 'Please enter Trainer\'s Mobile Number');
    }
    else if (emailController.text.isEmpty) {
      AppUtils.instance.showToast(
          toastMessage: 'Please enter Trainer\'s Email Address');
    }
    else if (passwordController.text.isEmpty) {
      AppUtils.instance.showToast(
          toastMessage: 'Please enter Trainer\'s Password');
    }
    else {
      setState(() {
        showLoader = true;
      });
      registerTrainerUsingEmailPassword(
          trainerName: nameController.text,
          emailID: emailController.text,
          password: passwordController.text,
          context: context).then((user) {
          FirebaseFirestore.instance.collection("Trainer").add({
            "name": nameController.text,
            "mobileNumber": mobileController.text,
            "email": emailController.text,
            "id": trainerId
          }).then((value) {
            AppUtils.instance.showToast(
                toastMessage: 'Trainer added.');
            setState(() {
              showLoader = false;
            });
            Navigator.pop(context, "added");
          });
      });
    }
  }

  void editTrainer(String docId) async {
    if (nameController.text.isEmpty) {
      AppUtils.instance.showToast(toastMessage: 'Please enter Trainer\'s Name');
    }
    else if (mobileController.text.isEmpty) {
      AppUtils.instance.showToast(
          toastMessage: 'Please enter Trainer\'s Mobile Number');
    }
    else if (emailController.text.isEmpty) {
      AppUtils.instance.showToast(
          toastMessage: 'Please enter Trainer\'s Email Address');
    }
    else {
      setState(() {
        showLoader = true;
      });
        FirebaseFirestore.instance.collection("Trainer").doc(docId).update({
          "name": nameController.text,
          "mobileNumber": mobileController.text,
          "email": emailController.text,
          "id": trainerId
        }).then((value) {
          AppUtils.instance.showToast(
              toastMessage: 'Trainer Updated.');
          setState(() {
            showLoader = false;
          });
          Navigator.pop(context, "added");
      });
    }
  }


  Future<User?> registerTrainerUsingEmailPassword({
    required String trainerName,
    required String emailID,
    required String password,
    required BuildContext? context

  }) async {
    FirebaseApp app = await Firebase.initializeApp(
        name: 'secondary', options: Firebase.app().options);
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app).createUserWithEmailAndPassword(
        email: emailID,
        password: password,
      );
      user = userCredential.user;
      user = auth.currentUser;
      trainerId = userCredential.user?.uid ?? "";
      print('UID: ${userCredential.user?.uid ?? ""}');
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoader = false;
      });
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');

        AppUtils.instance.showToast(toastMessage: "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        AppUtils.instance.showToast(toastMessage: "The account already exists for that email.");
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
