import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/pages/onboarding.dart';
import 'package:fooddeliveryapp/services/auth.dart';
import 'package:fooddeliveryapp/services/database.dart';
import 'package:fooddeliveryapp/services/shared_pref.dart';
import 'package:fooddeliveryapp/services/widget_support.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String ? name,email;
  String? userId;

  getUserSharedpref() async{
    name= await SharedpreferenceHelper.getUserName();
    email=await SharedpreferenceHelper.getUserEmail();
    setState(() {

    });
  }
  @override
  void initState() {
    getUserSharedpref();
    super.initState();



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
        child:SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top:40.0),
            child: Column(
              children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Profile",style: AppWidget.HeadlineTextField(),),
              ],),
            SizedBox(height: 10,),

                Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color:Color(0xffececf8),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),

                    ),
                  child: Column(
                    children: [
                      SizedBox(height: 30.0,),
                      Container(
                        width: 120,
                          height: 120,
                       // decoration: BoxDecoration(color: Colors.red, ),
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(120),
                          child:Icon(Icons.person,size:60,color:Colors.grey[600]),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 18.0,right: 18.0, top: 18.0, bottom: 10.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                               borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.person_outline, color: Color(0xffef2b39),size: 30.0,),
                                SizedBox(width: 30.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                  Text("Name", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18.0),),
                                    Text(name ?? "No Name",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18.0),),
                               ],
                                )

                              ],
                            ),



                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 18.0,right: 18.0, top: 18.0, bottom: 10.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.person_outline, color: Color(0xffef2b39),size: 30.0,),
                                SizedBox(width: 30.0,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text("Email", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18.0),),
                                     Text(email ?? "No Email",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 12.0),)

                                  ],
                                )

                              ],
                            ),



                          ),
                        ),
                      ),

                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: () async{
                          await AuthMethod().SignOut();
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> Onboarding()));

                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Material(
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.only(left: 18.0,right: 18.0, top: 18.0, bottom: 18.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.logout, color: Color(0xffef2b39),size: 30.0,),
                                  SizedBox(width: 30.0,),
                                  Text("Logout", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios_outlined,color: Color(0xffef2b39),),


                                    ],
                                  ),
                            ),




                            ),
                          ),
                      ),




                      SizedBox(height: 35,),
                    GestureDetector(

                    onTap:() async{

                        await AuthMethod().deleteUser();
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Onboarding()));

                          },
                        child: Container(
                          margin: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Material(
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: EdgeInsets.only(left: 18.0,right: 18.0, top: 18.0, bottom: 18.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Color(0xffef2b39),size: 30.0,),
                                  SizedBox(width: 30.0,),
                                  Text("Delete Account", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios_outlined,color: Color(0xffef2b39),),


                                ],
                              ),
                            ),




                          ),
                        ),
                      ),
                      ],



                  ),
                  ),






    ]),
    ),
    ),
    ),
    );
  }}