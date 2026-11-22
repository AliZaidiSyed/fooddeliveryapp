

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedpreferenceHelper {
 static String userIdKey= "USERKEY";
 static  String userNameKey= "USERNAMEKEY";
 static  String userEmailKey= "USEREMAILKEY";
 static  String userImageKey= "USERIMAGEKEY";
 static String userAddressKey="USERADRESSKEY";


  static Future<bool> saveUserId(String getUserId) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(userIdKey,getUserId);
  }

 static Future<bool> saveUserName(String getUserName) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(userNameKey,getUserName);
  }


 static Future<bool> saveUserEmail(String getUserEmail) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey,getUserEmail);
  }


 static Future<bool> saveUserImage(String getUserImage) async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.setString(userImageKey,getUserImage);
  }


 static Future<bool> saveUserAddress(String getUserAddress) async{
   SharedPreferences prefs= await SharedPreferences.getInstance();
   return prefs.setString(userAddressKey,getUserAddress);
 }

 static Future<String?>  getUserId() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }


 static Future<String?>  getUserName() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

 static Future<String?>  getUserEmail() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

 static Future<String?>  getUserImage() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    return prefs.getString(userImageKey);
  }


 static Future<String?>  getUserAddress() async {
   SharedPreferences prefs= await SharedPreferences.getInstance();
   return prefs.getString(userAddressKey);
 }


}