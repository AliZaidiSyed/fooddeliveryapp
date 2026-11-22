import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/features/admin/screens/home_admin.dart';
import 'package:fooddeliveryapp/core/theme/widget_support.dart';


class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();



  @override
  void dispose() {
    usernamecontroller.dispose();

    passwordcontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea (

   child:  SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3.1,
                padding: EdgeInsets.only(top: 20.0),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    color: HotFlavourColors.softRed,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))

                ),
                child: Column(
                  children: [
                    Image.asset("images/pan.png",
                      height: 180,
                      fit: BoxFit.fill,
                      width: 140,
                    ),
                    Image.asset("images/logo1.png",
                      width: 150, height: 50, fit: BoxFit.cover,
                    ),


                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height / 3.2,
                    left: 20.0,
                    right: 20.0),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0,top: 10,bottom: 30),
                    width: MediaQuery
                        .of(context)
                        .size.width,

                   // height: MediaQuery.of(context).size.width/2.1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.0),
                        Center(
                          child: Text("Admin",
                            style: AppWidget.HeadlineTextField(),
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        Text(
                          "UserName", style: AppWidget.SignUpTextFieldStyle(),),
                        SizedBox(height: 5.0),
                        Container(
                          decoration: BoxDecoration(
                            color: HotFlavourColors.cream,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: usernamecontroller,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Name",
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0),
                        Text(
                          "Password", style: AppWidget.SignUpTextFieldStyle(),),
                        SizedBox(height: 5.0),
                        Container(
                          decoration: BoxDecoration(

                            color: HotFlavourColors.cream,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: passwordcontroller,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Password",
                              prefixIcon: Icon(Icons.password_outlined),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        GestureDetector(
                          onTap: () {
                            loginAdmin();

                          },
                          child: Center(
                            child: Container(
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                color: HotFlavourColors.primary,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Center(child: Text("Login",
                                style: AppWidget.BoldWhiteTextFieldStyle(),)),


                            ),
                          ),
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

  }

  loginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['username'] != usernamecontroller.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Your Username is not correct",
                style: TextStyle(fontSize: 10.0),
              )));
        } else if (result.data()['password'] != passwordcontroller.text) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: HotFlavourColors.orange,
              content: Text(
                "Your password is not correct",
                style: TextStyle(fontSize: 10.0),
              )));
        }
        else{
          Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeAdmin()));
        }
      });
    });
  }
}






