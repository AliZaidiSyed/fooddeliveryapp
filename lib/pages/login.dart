import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fooddeliveryapp/providers/ui_refresh_provider.dart';
import 'package:fooddeliveryapp/Admin/admin_login.dart';
import 'package:fooddeliveryapp/pages/bottomnav.dart';
import 'package:fooddeliveryapp/pages/forget_password.dart';
import 'package:fooddeliveryapp/pages/signup.dart';
import 'package:fooddeliveryapp/services/shared_pref.dart';
import 'package:fooddeliveryapp/services/widget_support.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UiRefreshProvider _uiRefreshProvider = UiRefreshProvider();

  String email="", password="";
  TextEditingController emailController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  bool _obsecureText=true;


  @override
  void dispose() {

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }



  userLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text.trim(), password: password,);

      var user = await FirebaseFirestore.instance
          .collection("users")
          .where("Email", isEqualTo: email)
          .get();

      await SharedpreferenceHelper.saveUserEmail(email);
      await SharedpreferenceHelper.saveUserName(user.docs[0]["Name"]);
      await SharedpreferenceHelper.saveUserId(user.docs[0]["Id"]);


        Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNav()));
    }  on FirebaseAuthException catch (e) {

  if (e.code == "invalid-credential") {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  backgroundColor: Colors.red,
  content: Text(
  "Invalid Email or Password",
  style: TextStyle(color: Colors.white),
  ),
  ),
  );
  }

  else if (e.code == "user-not-found") {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  backgroundColor: Colors.red,
  content: Text(
  "User not found",
  style: TextStyle(color: Colors.white),
  ),
  ),
  );
  }

  else if (e.code == "wrong-password") {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  backgroundColor: Colors.red,
  content: Text(
  "Wrong Password",
  style: TextStyle(color: Colors.white),
  ),
  ),
  );
  }

  else if (e.code == "invalid-email") {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  backgroundColor: Colors.orange,
  content: Text(
  "Invalid Email Address",
  style: TextStyle(color: Colors.white),
  ),
  ),
  );
  }

  else if (e.code == "network-request-failed") {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  backgroundColor: Colors.red,
  content: Text(
  "Check your internet connection",
  style: TextStyle(color: Colors.white),
  ),
  ),
  );
  }

  else {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
  backgroundColor: Colors.red,
  content: Text(
  e.message ?? "Something went wrong",
  style: TextStyle(color: Colors.white),
  ),
  ),
  );
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
      body:SafeArea(
        child: SingleChildScrollView(
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
                    GestureDetector(
                      onLongPress: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>AdminLogin()));

                      },
                      child: Image.asset("images/logo1.png",
                        width:150,height: 50,fit: BoxFit.cover,
                      ),
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
                    height: MediaQuery.of(context).size.height/1.65,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.0),
                        Center(
                          child: Text("Login",
                            style: AppWidget.HeadlineTextField(),
                          ),
                        ),

                        SizedBox(height:20.0),
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

                        SizedBox(height:20.0),
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
                                    _obsecureText=
                                      !_obsecureText;
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
                        SizedBox(height:10.0),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {

                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword()));

                      },

                                child: Text("Forget Password?",style: AppWidget.SimpleTextField(),)),
                          ],

                        ),
                        SizedBox(height: 40.0,),
                        GestureDetector(
                          onTap: (){

                              if(  emailController.text!="" && passwordController.text!=""){
                                email=emailController.text;
                                  password=passwordController.text;
                                _uiRefreshProvider.refresh();
                                userLogin();
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
                              child:Center(child: Text("Login",style:AppWidget.BoldWhiteTextFieldStyle(),)),

                            ),
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dont Have An Account",style: AppWidget.SimpleTextField(),),
                            SizedBox(width:10.0),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=> Signup()));
                              },



                              child: Text("SignUp",style: AppWidget.boldTextFieldStyle(),)
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
