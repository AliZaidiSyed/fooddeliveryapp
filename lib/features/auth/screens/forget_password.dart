import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/core/theme/widget_support.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController=TextEditingController();



  Future<void> resetPassword(String email) async {
    if (email.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please enter your email",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            "Email Sent! Check Your Email",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = "Something went wrong";

      if (e.code == "invalid-email") {
        message = "Please enter a valid email";
      } else if (e.code == "user-not-found") {
        message = "No user found with this email";
      } else {
        message =  "Something went wrong";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }


  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

      @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(


        child: Column(
          children: [
         Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children:[
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding:EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: HotFlavourColors.primary,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),


                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width/7,),
              Expanded(child: Text("Forget Password",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.black),)),
            ],
          ),
        ),
        SizedBox(height: 30.0,),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color:HotFlavourColors.cream,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)),


            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Reset the Password", style: AppWidget.boldTextFieldStyle(),),

                SizedBox(height:20.0),
                Text("Email",style: AppWidget.SignUpTextFieldStyle(),),
                SizedBox(height:10.0),
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
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),


                SizedBox(height: 40.0,),
                GestureDetector(
                  onTap: () {
                     resetPassword(emailController.text);

                  },
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color:HotFlavourColors.primary,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                   child:  Center(  child:  Text("Send Email",style:TextStyle(fontWeight:FontWeight.bold,color: Colors.white, fontSize: 15.0)))),
                    ),
                  ),


          ],
            ),
          ),
        ),














      ],
      ),
      ),

    );

  }
}
