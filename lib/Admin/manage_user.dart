import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/services/auth.dart';
import 'package:fooddeliveryapp/services/database.dart';
import 'package:fooddeliveryapp/services/widget_support.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({super.key});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  Stream? userStream;


  getontheload() async {
    userStream=await DataBaseMethods().getAllUsers();
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getontheload();
  }


  Widget allUsers() {
    return StreamBuilder(
        stream: userStream, builder: (context, AsyncSnapshot snapshot) {
      if(snapshot.hasData){
        print(snapshot.data.docs.length);
      }

      return snapshot.hasData ? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,

          itemBuilder: (context, index) {

            DocumentSnapshot ds=snapshot.data.docs[index];
            return Container(
              margin:EdgeInsets.only(left: 20,right:20,bottom: 20.0) ,

              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.all(10),
                  // margin:EdgeInsets.only(left: 20,right:20,) ,
                  width:MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color:Colors.white,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                      child: Icon(Icons.person,size: 60,color: Colors.grey[600],),
                  ),

                          SizedBox(width: 10.0,),


                             Expanded(
                               child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                     Row(
                                      children: [
                                        Icon(Icons.person,color: Color(0xffef2b39),),
                                        SizedBox(width: 10,),
                                         Expanded(child: Text(ds['Name'],style: AppWidget.boldTextFieldStyle(),)),
                                      ],
                                    ),


                                  Row(
                                    children: [
                                      Icon(Icons.email_outlined,color: Color(0xffef2b39),),
                                      SizedBox(width: 10,),
                                         Expanded(child: Text(ds['Email'],style:TextStyle(fontWeight:FontWeight.bold))),
                                    ],
                                  ),
                                  SizedBox(height: 10.0,),
                                  GestureDetector(
                                    onTap: () async{
                                      await DataBaseMethods().DeleteUser(ds['Id']);


                                    },
                                    child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(color: Colors.black,
                                          borderRadius: BorderRadius.circular(10)),
                                      width: 100,
                                      child: Center(child: Text("Remove", style: AppWidget.WhiteTextFieldStyle(),)),
                                    ),
                                  )

                                ],
                                                           ),
                             ),
                          

                        ],
                      )
                    ],
                  ),
                ),
              ),
            );


          }) : Container();
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      body: SafeArea(

        child:Container(
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
                          color: Color(0xffef2b39),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),


                      ),
                    ),
                    SizedBox(width:20),
                    Expanded(child: Text("Current Users",style: AppWidget.HeadlineTextField(),)),
                  ],
                ),
              ),
              SizedBox(height:20.0),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color:Color(0xffececf8),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),

                  ),
                  child:Column(
                    children: [
                      SizedBox(height:20),
                      Container(

                         height: MediaQuery.of(context).size.height/2,
                          child: allUsers(),

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


