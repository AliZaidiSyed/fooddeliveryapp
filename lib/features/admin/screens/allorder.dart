import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fooddeliveryapp/providers/admin_orders_provider.dart';
import 'package:fooddeliveryapp/core/services/database.dart';
import 'package:fooddeliveryapp/core/theme/widget_support.dart';


class Allorder extends StatefulWidget {
  const Allorder({super.key});

  @override
  State<Allorder> createState() => _AllorderState();
}

class _AllorderState extends State<Allorder> {
  final AdminOrdersProvider _screenProvider = AdminOrdersProvider();


  @override
  void initState() {
    super.initState();
    _screenProvider.loadOrders();
  }


  Widget allOrders() {
    if (_screenProvider.isLoading) return Center(child: CircularProgressIndicator());
    if (_screenProvider.error != null) return Center(child: Text(_screenProvider.error!));
    return StreamBuilder(
        stream: _screenProvider.orders, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasError
          ? Center(child: Text('Unable to load data: ${snapshot.error}'))
          : snapshot.hasData ? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,

          itemBuilder: (context, index) {

            DocumentSnapshot ds=snapshot.data.docs[index];
            return    Container(
              margin: EdgeInsets.only( left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
                bottom: 15.0, ),

              child: Material(
                elevation:3.0 ,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Container(
                  margin: EdgeInsets.only(  left: MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.04,),
                  width: MediaQuery.of(context).size.width,
                  // padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),

                  child:Column(
                    children:[
                      SizedBox(height:5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined,
                            color: HotFlavourColors.primary,),
                          SizedBox(width:10.0),
                          Text(ds['Address'],style: AppWidget.SimpleTextField(),),

                        ],
                      ),
                      Divider(),
                      Row(
                        //  crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Image.asset(ds['FoodImage'],
                              height:MediaQuery.of(context).size.width*0.24,
                              width:MediaQuery.of(context).size.width*0.24,

                              fit:BoxFit.contain),
                          SizedBox(width:MediaQuery.of(context).size.width*0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(ds['FoodName'], style:AppWidget.boldTextFieldStyle()),

                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.format_list_numbered, color:HotFlavourColors.primary),
                                    SizedBox(width:10.0),
                                    Text(ds['Quantity'], style:AppWidget.boldTextFieldStyle()),
                                    SizedBox(width: 10.0,),

                                    Icon(Icons.monetization_on, color:HotFlavourColors.primary),
                                    SizedBox(width:10.0),
                                    Text(ds["Total"], style:AppWidget.boldTextFieldStyle())
                                  ],
                                ),
                                                Row(children: [
                                                  Icon(Icons.person,color: HotFlavourColors.primary,),
                                                  SizedBox(width:10.0),
                                                  Expanded(child: Text(ds["Name"],style: AppWidget.SimpleTextField(),)),
                                                ],),

                                              SizedBox(height:5.0),


                                                 Row(children: [
                                                  Icon(Icons.email_outlined,color: HotFlavourColors.primary,),
                                                  SizedBox(width:10.0),
                                                  Expanded(child: Text(ds["Email"],style: AppWidget.SimpleTextField(),)),
                                                ],),

                                              SizedBox(height: 5.0,),
                                              Text(ds['Status']+"!",style:TextStyle( color:HotFlavourColors.primary,fontSize: 20.0, fontWeight: FontWeight.bold)


                                              ),
                                              SizedBox(height: 5.0,),
                                              GestureDetector(
                                                onTap: () async{
                                                  await DataBaseMethods().updateAdminOrder(ds.id);
                                                  await DataBaseMethods().updateUserOrder(ds['Id'],ds.id,);

                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width * 0.24,
                                                  height: MediaQuery.of(context).size.width * 0.11,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius.circular(10),

                                                  ),
                                                  child:Center( child:Text("Delivered", style: AppWidget.WhiteTextFieldStyle(),)),
                                                ),
                                              ),

                                              SizedBox(height:10.0),


                                          ],


                                          ),
                          ) ,

                          ],
                      ),

                ],

                  ),
                ),
              ),
            );

          }) : Container();
    });
  }
  @override
  void dispose() {
    _screenProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminOrdersProvider>.value(
      value: _screenProvider,
      child: Consumer<AdminOrdersProvider>(
        builder: (context, screenProvider, child) {
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
                        color: HotFlavourColors.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,),


                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/6,),
                  Text("All Orders",style: AppWidget.HeadlineTextField(),),
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
                    SizedBox(height: 20,),
                    Expanded(


                   child: allOrders(),
                    ),




                  ],
                ),

              ),
            ),
            
          ],
        ),
      ),

      ),
    );
        },
      ),
    );
  }
}
