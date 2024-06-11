import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mentor_mate/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppUtils{
  AppUtils._privateConstructor();
  static final AppUtils instance = AppUtils._privateConstructor();

  void showToast({String? toastMessage, Color? backgroundColor, Color? textColor,Toast? toastLength=Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
        msg: toastMessage!,
        backgroundColor: backgroundColor ?? primaryColor,
        textColor: textColor,
        toastLength:toastLength ,
        gravity: ToastGravity.BOTTOM);
  }

  showSnackBar(GlobalKey<ScaffoldState>? scaffoldKey, BuildContext? context,
      String msg, {Color? color, int? duration}) {
    return ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color?? textColor,
        duration: Duration(seconds: duration ?? 3),
      ),
    );
  }

  Future<void> clearPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
