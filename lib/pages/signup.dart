import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:fooddeliveryapp/providers/ui_refresh_provider.dart';
import "package:fooddeliveryapp/pages/bottomnav.dart";
import "package:fooddeliveryapp/pages/login.dart";
import "package:fooddeliveryapp/services/database.dart";
import "package:fooddeliveryapp/services/shared_pref.dart";
import "package:fooddeliveryapp/services/widget_support.dart";
import "package:random_string/random_string.dart";



class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final UiRefreshProvider _uiRefreshProvider = UiRefreshProvider();

  String email="", password="",name="";
  TextEditingController nameController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  bool _obsecureText=true;


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }




  registration () async {
  if(password != null &&
  nameController.text!="" &&
  emailController.text!="") {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.
      createUserWithEmailAndPassword(email: emailController.text.trim(), password: password);
      String Id = randomAlphaNumeric(10);

      Map<String, dynamic> userInfoMap = {
          "Name" :nameController.text,
          "Email":emailController.text,
          "Id":Id,
        "Wallet":"0",

          };
      await SharedpreferenceHelper.saveUserEmail(email);
      await SharedpreferenceHelper.saveUserName(nameController.text);
      await SharedpreferenceHelper.saveUserId(Id);
      await  DataBaseMethods().addUserDetails(userInfoMap, Id);


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 10.0,fontWeight: FontWeight.bold),
          )));


      Navigator.push(context,MaterialPageRoute( builder: (context)=> BottomNav()));

  }on FirebaseAuthException catch (e) {
      if(e.code== "weak-password"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: Colors.orangeAccent,
         content: Text(
         "Password Provided is too weak",
         style: TextStyle(fontSize: 10.0),
  )));
  }
      else if(e.code== "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Email Already Exists",
              style: TextStyle(fontSize: 10.0),
            )));
      }
      else if(e.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Invalid Email Address"),
          ),
        );
      }


      else if(e.code == "network-request-failed") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Check your Internet Connection"),
          ),
        );
      }

      else if(e.code == "too-many-requests") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Too many attempts, try again later"),
          ),
        );
      }

      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("Something went wrong: ${e.message}"),
          ),
        );
      }


  }
  }
}
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UiRefreshProvider>.value(
      value: _uiRefreshProvider,
      child: Consumer<UiRefreshProvider>(
        builder: (context, refreshProvider, child) {
          return Scaffold(
      body: SafeArea(
        child:SingleChildScrollView(
        child: Container(
          child:Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/3.1,
                padding: EdgeInsets.only(top:20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color:Color(0xffffefbf),
                  borderRadius: BorderRadius.only(
                      bottomLeft:Radius.circular(40),
                      bottomRight:Radius.circular(40)  )
        
                ),
                child: Column(
                  children: [
                    Image.asset("images/pan.png",
                      height:170,
                      fit: BoxFit.contain,
                      width:130,
                    ),
                    Image.asset("images/logo1.png",
                      width:150,height: 50,fit: BoxFit.cover,
                    ),
        
        
                  ],
              ),
              ),
        
              Container(
                margin: EdgeInsets.only(
                    top:MediaQuery.of(context).size.height/3.2,
                    left: 20.0,
                    right:20.0),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0,right:20.0),
                    width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
        
                    ),
                //  height: MediaQuery.of(context).size.height/1.65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.0),
                        Center(
                            child: Text("SignUp",
                            style: AppWidget.HeadlineTextField(),
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        Text("Name",style: AppWidget.SignUpTextFieldStyle(),),
                        SizedBox(height:5.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffececf8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Name",
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                        ),
                        SizedBox(height:10.0),
                        Text("Email",style: AppWidget.SignUpTextFieldStyle(),),
                        SizedBox(height:5.0),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffececf8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Email",
                              prefixIcon: Icon(Icons.mail_outline),
                            ),
                          ),
                        ),
        
                        SizedBox(height:10.0),
                        Text("Password",style: AppWidget.SignUpTextFieldStyle(),),
                        SizedBox(height:5.0),
                        Container(
                          decoration: BoxDecoration(

                            color: Color(0xffececf8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: passwordController,
                            obscureText: _obsecureText,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Password",
                              prefixIcon: Icon(Icons.password_outlined),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _obsecureText=!_obsecureText;
                                  _uiRefreshProvider.refresh();
                                },

                                  child:
                                  Icon(_obsecureText ? Icons.visibility : Icons
                                      .visibility_off
                                  ),


                              )
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        GestureDetector(
                          onTap: (){
                            if(nameController.text!="" && emailController.text!="" && passwordController.text!=""){
                              name=nameController.text;
                                email=emailController.text;
                                password=passwordController.text;
                              _uiRefreshProvider.refresh();
                              registration();
                            }
                          },
                          child: Center(
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color:Color(0xffef2b39),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child:Center(child: Text("SignUp",style:AppWidget.BoldWhiteTextFieldStyle(),)),






                            ),
                          ),
                        ),
                        SizedBox(height:20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already Have an Account",style: AppWidget.SimpleTextField(),),
                            SizedBox(width:10.0),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> Login()));
        
                              },
                              child: Text("Login",style: AppWidget.boldTextFieldStyle(),),
                             ),
                            
                          ],
                        ),
        
                      ],
        
                  ),
                ),
              ),
              ),
        
            ],
        
          ),
        ),
      ),
    ),
    );
        },
      ),
    );
  }
}
