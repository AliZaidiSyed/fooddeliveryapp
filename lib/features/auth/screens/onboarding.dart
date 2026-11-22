import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import "package:flutter/material.dart";
import "package:fooddeliveryapp/features/auth/screens/signup.dart";
import "package:fooddeliveryapp/core/theme/widget_support.dart";

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}
class _OnboardingState extends State<Onboarding> {
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(child:
      Container (
        margin: EdgeInsets.only(top:40.0),
        child:Column (
            children:[
              Image.asset("images/onboard.png",
              width:350,
              height: 350,
                fit: BoxFit.contain,
              ),
              SizedBox(height:20.0),
              Text("Fastest Food Delivery App",
                  textAlign: TextAlign.center,
                  style:AppWidget.HeadlineTextField()),
              SizedBox(height:30.0),
              Text("Craving Someting delicious \n order now and enjoy  \n delicious food",
                  textAlign:TextAlign.center,
                  style:AppWidget.SimpleTextField()),
             SizedBox(height:30.0),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> Signup()));
                },
                child: Container(
                  height: 60,
                  width:MediaQuery.of(context).size.width/2,
                  decoration: BoxDecoration(color:HotFlavourColors.primary,
                  borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child:Text( "Get Started",
                      style:TextStyle(
                          color: Colors.white,
                          fontSize:20.0,
                          fontWeight: FontWeight.bold),
                
                  ),
                ),
                ),
              ),],
        ),
      ),
      ),
    );
  }
}