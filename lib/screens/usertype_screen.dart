import 'package:flutter/material.dart';
import 'package:mentor_mate/constants.dart';
import 'package:mentor_mate/screens/login_screen.dart';
import 'package:mentor_mate/screens/welcome_screen.dart';

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  State<UserType> createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  bool isTrainerSelected = false,
      isTraineeSelected = false,
      isManagerSelected = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        // decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   stops: [0.0, 1.0],
        //   colors: [
        //     milkyColor,
        //     milkyColor,
        //   ],
        // ),
        // image: DecorationImage(
        //   image: AssetImage("assets/images/main-page.png"), fit: BoxFit.cover,
        // )
        // ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: size.height*0.05,
            // ),
            // SizedBox(
            //   child: Image.asset('assets/images/logo.jpeg',
            //     height: 200,
            // color: primaryColor,
            // ),
            // ),
            // Text("Mentor Mate",
            // style: TextStyle(
            //   fontSize: 30,
            //   fontFamily: "Poppins",
            //   fontWeight: FontWeight.w600,
            //   color: primaryColor
            // ),),
            SizedBox(
              height: size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Choose Yourself",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    fontSize: 36),
              ),
            ),
            SizedBox(
              height: size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 15,
                    children: [
                      //Admin/Trainer
                      InkWell(
                        onTap: () {
                          setState(() {
                            isTrainerSelected = true;
                            isTraineeSelected = false;
                            isManagerSelected = false;
                          });
                        },
                        child: Container(
                          height: size.height * 0.25,
                          decoration: BoxDecoration(
                            border: isTrainerSelected
                                ? Border.all(width: 2, color: primaryColor)
                                : Border.all(width: 1, color: Colors.white),
                            color: isTrainerSelected
                                ? primaryColor.withOpacity(0.15)
                                : Color(0xffececec),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/manager.png",
                                color: Colors.black,
                                height: 60,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Trainer",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Trainee
                      InkWell(
                        onTap: () {
                          setState(() {
                            isTraineeSelected = true;
                            isTrainerSelected = false;
                            isManagerSelected = false;
                          });
                        },
                        child: Container(
                          height: size.height * 0.25,
                          decoration: BoxDecoration(
                            color: isTraineeSelected
                                ? primaryColor.withOpacity(0.15)
                                : Color(0xffececec),
                            border: isTraineeSelected
                                ? Border.all(width: 2, color: primaryColor)
                                : Border.all(width: 1, color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/trainee.png",
                                color: Colors.black,
                                height: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Trainee",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //Manager
                      InkWell(
                        onTap: () {
                          setState(() {
                            isManagerSelected = true;
                            isTraineeSelected = false;
                            isTrainerSelected = false;
                          });
                        },
                        child: Container(
                          height: size.height * 0.25,
                          decoration: BoxDecoration(
                            border: isManagerSelected
                                ? Border.all(width: 2, color: primaryColor)
                                : Border.all(width: 1, color: Colors.white),
                            color: isManagerSelected
                                ? primaryColor.withOpacity(0.15)
                                : Color(0xffececec),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/manager.png",
                                color: Colors.black,
                                height: 50,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Manager/Admin",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Padding(
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      if (isTrainerSelected) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                      userType: 'Admin',
                                    )));
                      } else if (isTraineeSelected) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                      userType: 'Trainee',
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen(
                                  userType: 'Manager',
                                )));
                      }
                    },
                    child: const Text('Next', style: buttonStyle)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
