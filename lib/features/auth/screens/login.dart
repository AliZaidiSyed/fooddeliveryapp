import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fooddeliveryapp/providers/auth_form_provider.dart';
import 'package:fooddeliveryapp/features/admin/screens/admin_login.dart';
import 'package:fooddeliveryapp/features/navigation/screens/bottomnav.dart';
import 'package:fooddeliveryapp/features/auth/screens/forget_password.dart';
import 'package:fooddeliveryapp/features/auth/screens/signup.dart';
import 'package:fooddeliveryapp/core/services/shared_pref.dart';
import 'package:fooddeliveryapp/core/theme/widget_support.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email="", password="";
  TextEditingController emailController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  final AuthFormProvider _authFormProvider = AuthFormProvider();
  bool get _obsecureText => _authFormProvider.obscurePassword;


  @override
  void dispose() {
    _authFormProvider.dispose();

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
  backgroundColor: HotFlavourColors.orange,
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
    


    return ChangeNotifierProvider<AuthFormProvider>.value(
      value: _authFormProvider,
      child: Consumer<AuthFormProvider>(
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
                    color:HotFlavourColors.softRed,
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
                            color: HotFlavourColors.cream,
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
                            color: HotFlavourColors.cream,
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
                                    _authFormProvider.togglePasswordVisibility();
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

                                userLogin();
                              }
                          },
                          child: Center(
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color:HotFlavourColors.primary,
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
