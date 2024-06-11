import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/constants.dart';
import 'package:mentor_mate/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrainerProfileScreen extends StatefulWidget {
  final String userType;

  const TrainerProfileScreen({super.key, required this.userType});

  @override
  State<TrainerProfileScreen> createState() => _TrainerProfileScreenState();
}

class _TrainerProfileScreenState extends State<TrainerProfileScreen> {
  String userType = "";
  String email = "";
  String uid = "";
  String name = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MethodsHandler _methodsHandler = MethodsHandler();

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        uid = prefs.getString('userId')!;
      });
      FirebaseFirestore.instance
          .collection(userType)
          .where('uid', isEqualTo: _auth.currentUser!.uid.toString())
          .get()
          .then((value) {
        setState(() {
          name = value.docs[0]['name'];
          email = value.docs[0]['email'];
        });
      });
    } else {
      print('Starting usertype');
    }
  }

  @override
  void initState() {
    super.initState();
      userType = '';
      email = '';
      uid = '';
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
              width: size.width,
              height: size.height*0.35,
              decoration: new BoxDecoration(
                // borderRadius: BorderRadius.only(bottomRight: Radius.circular(0), bottomLeft: Radius.circular(50)),
                gradient: LinearGradient(begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.1,
                    0.9
                  ], colors: [

                    primaryColor,
                    primaryColorLight,
                  ],
                ),
              ),
              child: Column(children: [
                Padding(
                  padding:  EdgeInsets.only(top: size.height*0.03),
                  child: Container(
                    height: size.height*0.08,
                    width: size.width,
                    child: Stack(
                      alignment: Alignment.centerRight,

                      children: [
                        Container(
                            width: size.width,
                            height: size.height*0.08,
                            child: Center(
                              child: Text('Profile',
                                style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                              ),
                            )),
                      ],),

                  ),
                ),

                SizedBox(
                  height: size.height*0.01,
                ),

                Container(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage( 'assets/images/coffee_header.jpeg'),
                        ),
                      ],
                    )),

                SizedBox(
                  height: size.height*0.02,
                ),

                Container(
                    width: size.width,
                    child: Center(
                      child: Text(name == '' ? (widget.userType) : name,
                        style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                    )),


                SizedBox(
                  height: size.height*0.01,
                ),

                Container(
                    width: size.width,
                    child: Center(
                      child: Text(email == '' ? 'trainer@gmail.com' : email,
                        style: TextStyle(color: Colors.white, fontSize: 13,fontWeight: FontWeight.w400),
                      ),
                    )),





              ],)
          ),


          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4,bottom: 4,left: 10,right: 10),
            child: ListTile(
              shape: RoundedRectangleBorder( //<-- SEE HERE
                side: BorderSide(width: 1,color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),

              tileColor: Colors.white,
              leading: Container(
                decoration: BoxDecoration(
                  color: secondaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 30,
                height: 30,//devSize.height*0.05,
                child: Icon(Icons.logout, color: Colors.red,),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios, color: Colors.black,size: 15,
              ),
              title:  Text('Logout', style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500
              )),
              onTap: () async {
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserType()));
                _methodsHandler.signOut(context);

              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
