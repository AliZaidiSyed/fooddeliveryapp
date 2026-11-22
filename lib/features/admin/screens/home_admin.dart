import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/features/admin/screens/allorder.dart';
import 'package:fooddeliveryapp/features/admin/screens/manage_user.dart';
import 'package:fooddeliveryapp/core/theme/widget_support.dart';



class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        child:Container(
          margin: EdgeInsets.only(top: 60.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[


                    Text("Home Admin ",style: AppWidget.HeadlineTextField(),),
                  ],
                ),
              ),
              SizedBox(height:20.0),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color:HotFlavourColors.cream,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),

                  ),
                  child:Column(
                    children: [
                      SizedBox(height:80),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Allorder()));

                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20.0,right: 20.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(30),
                            elevation: 3.0,
                            child: Container(
                              padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 10,bottom: 10),
                              margin: EdgeInsets.only(left: 20.0,right: 20.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("images/delivery-man.png",
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.contain,),
                                  Text("Manage\nOrders",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),



                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(color: HotFlavourColors.primary, borderRadius: BorderRadius.circular(30)),
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,size:30.0,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 50.0,),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>ManageUser()));

                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 20.0,right: 20.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(30),
                            elevation: 3.0,
                            child: Container(
                              padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 10,bottom: 10),
                              margin: EdgeInsets.only(left: 20.0,right: 20.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset("images/team.png",
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.contain,),
                                  Text("Manage\nUsers",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),



                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(color: HotFlavourColors.primary, borderRadius: BorderRadius.circular(30)),
                                    child: Icon(Icons.arrow_forward_ios,color: Colors.white,size:30.0,),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )


                    ],
                  ),
                ),
              ),
            ],





          ),
        ),

      ),
    );



  }
}

