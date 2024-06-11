import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mentor_mate/bottomNavBar/app_bottom_nav_bar_trainer.dart';
import 'package:mentor_mate/bottomNavBar/app_bottom_nav_bar_trainee_screen.dart';
import 'package:mentor_mate/bottomNavBar/app_bottom_nav_bar_manager.dart';
import 'package:mentor_mate/constants.dart';
import 'package:mentor_mate/screens/usertype_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:mec/constants.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key }) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3; // delay for 5 seconds
  String userType = '',email = '', uid = '';

  @override
  void initState() {
    getData();
    _loadWidget();
    super.initState();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (userType == "Admin") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => AppBottomNavBarTrainerScreen()));

    }
    else if (userType == "Trainer") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => AppBottomNavBarManagerScreen()));

    }
    else if (userType == "Trainee") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => AppBottomNavBarTraineeScreen()));

    }
    else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => UserType()));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Starting usertype ' + prefs.getString('userType').toString());
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        // uid = prefs.getString('userId')!;
      });
      print(userType.toString() + ' This is user type');
    } else {
      print('Starting usertype');
    }
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
     // backgroundColor: primaryColor,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: new BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.jpeg',), fit: BoxFit.cover
          )
          //
          // gradient: LinearGradient(begin: Alignment.topRight,
          //   end: Alignment.bottomLeft,
          //   stops: [
          //   0.1,
          //   0.9
          // ], colors: [
          //   primaryColor,
          //     primaryColor,
          //     // darkBrownColor
          // ],
          // ),
        ),
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SizedBox(
        //         height: 120,
        //         // width: 120,
        //         child: Image.asset('assets/images/splash.jpeg.png', fit: BoxFit.scaleDown,)),
        //   ],
        // ),
      ),
    );
  }
}
