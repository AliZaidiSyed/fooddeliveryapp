import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:fooddeliveryapp/features/navigation/screens/bottomnav.dart";
import "package:fooddeliveryapp/features/auth/screens/onboarding.dart";


class Authwrapper extends StatelessWidget {
  const Authwrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){

          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }

          if(snapshot.hasData){
            return BottomNav();
          }
          else {
            return Onboarding();
          }
        }
    );
  }
}
