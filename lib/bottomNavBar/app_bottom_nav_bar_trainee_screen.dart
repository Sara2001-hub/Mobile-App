import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_mate/constants.dart';
import 'package:mentor_mate/screens/trainee/trainee_home_screen.dart';
import 'package:mentor_mate/screens/trainee/trainee_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBottomNavBarTraineeScreen extends StatefulWidget {
  const AppBottomNavBarTraineeScreen({Key? key,}) : super(key: key);

  @override
  _AppBottomNavBarTraineeScreenState createState() => _AppBottomNavBarTraineeScreenState();
}

class _AppBottomNavBarTraineeScreenState extends State<AppBottomNavBarTraineeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  List<Widget> _pages = [
    //  HomeScreen(),
    // BookingScreen(),
    // ProfileScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int cartTotal = 0;



  getTotal() async {
    setState(() {

      cartTotal = 0;
    });
    FirebaseFirestore.instance
        .collection('UserCart').where('userId', isEqualTo: _auth.currentUser!.uid.toString()).where('productStatus', isEqualTo: 'Pending')
        .get().then((value) {


      for(int i=0 ;i <value.docs.length ; i++) {

        setState(() {
          cartTotal = cartTotal + int.parse(value.docs[i]['productPrice'].toString());
        });
      }


    });
  }

  getToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('customerAccessToken');
    print( _pref.getString('customerAccessToken'));

    print('adminAccessToken');
    print( _pref.getString('adminAccessToken'));
  }

  @override
  void initState() {
    //cartController.fetchCartItems();
    // TODO: implement initState
    super.initState();
    print('UserType');
      setState(() {
        _pages = [
          const TraineeHomeScreen(userType:"Trainee"),
          const TraineeProfileScreen(userType: "Trainee"),
        ];
      });
    getToken();
  }



  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;

    //getToken();
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          height: 55,
          //  color: Colors.white,
          child: SizedBox(
            height: 70,
            child:

            CupertinoTabBar(
              activeColor: Colors.white,
              inactiveColor: primaryColorLight,
              currentIndex: _selectedIndex,
              backgroundColor: primaryColor,
              iconSize: 40,
              onTap: _onItemTapped,
              items:
             [
                orientation == Orientation.portrait
                    ? BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                          _pages[0] = TraineeHomeScreen(userType: "Trainee",);
                        });
                      },
                      child: const Icon(
                        Icons.home_outlined,
                        size: 25,
                        //color: Color(0xFF3A5A98),
                      ),
                    ),
                  ),
                  label: 'Home',
                )
                    : BottomNavigationBarItem(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 0;
                            //  _pages[0] = HomeScreen();
                            });
                          },
                          child: const Icon(
                            Icons.home_outlined,
                            size: 25,
                            //color: Color(0xFF3A5A98),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Home',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),

                orientation == Orientation.portrait
                    ? BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                          _pages[1] = TraineeProfileScreen(userType: "Trainee",);
                        });
                      },
                      child: const Icon(
                        Icons.account_circle_outlined,
                        size: 25,
                      ),
                    ),
                  ),
                  label: 'Profile',
                )
                    : BottomNavigationBarItem(
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 1;
                              _pages[1] = TraineeProfileScreen(userType:"Trainee",);
                            });
                          },
                          child: const Icon(
                            Icons.account_circle_outlined,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Profile',
                        style: TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit the App?'),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:const Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            child:const Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
}
