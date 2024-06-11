import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentor_mate/constants.dart';
import 'package:mentor_mate/screens/trainer/trainer_home_screen.dart';
import 'package:mentor_mate/screens/trainer/trainer_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBottomNavBarTrainerScreen extends StatefulWidget {
  const AppBottomNavBarTrainerScreen({Key? key}) : super(key: key);

  @override
  _AppBottomNavBarTrainerScreenState createState() => _AppBottomNavBarTrainerScreenState();
}

class _AppBottomNavBarTrainerScreenState extends State<AppBottomNavBarTrainerScreen> {
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

  getToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print('customerAccessToken');
    print( _pref.getString('customerAccessToken'));

    print('adminAccessToken');
    print( _pref.getString('adminAccessToken'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('UserType');
    setState(() {
      _pages = [
        TrainerHomeScreen(userType: "Trainer"),
        TrainerProfileScreen(userType: "Trainer"),
      ];
    });
  }



  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    //getToken();
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        // backgroundColor: milkyColor,
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: CupertinoTabBar(
          activeColor: Colors.white,
          inactiveColor: Colors.white54,
          currentIndex: _selectedIndex,
          backgroundColor: primaryColor,
          iconSize: 40,
          onTap: _onItemTapped,
          items: [
            orientation == Orientation.portrait
                ? BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 0;
                      //    _pages[0] = InstructorHomeScreen( instructorId: widget.subTitle,);
                    });
                  },
                  child: Icon(
                    Icons.home_outlined,
                    size: 25,
                    //color: Color(0xFF3A5A98),
                  ),
                ),
              ),
              label: 'Dashboard',
            )
                : BottomNavigationBarItem(
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 0;
                          //  _pages[0] = HomeScreen();
                        });
                      },
                      child: Icon(
                        Icons.home_outlined,
                        size: 25,
                        //color: Color(0xFF3A5A98),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            orientation == Orientation.portrait
                ? BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 1;
                      // _pages[2] = ProfileScreen(userType: widget.title.toString(),);
                    });
                  },
                  child: Icon(
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
                    padding: EdgeInsets.only(bottom: 4),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = 1;
                          //   _pages[2] = ProfileScreen(userType: widget.title.toString(),);
                        });
                      },
                      child: Icon(
                        Icons.account_circle_outlined,
                        size: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the App?'),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }

}
