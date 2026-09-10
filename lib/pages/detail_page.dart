import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fooddeliveryapp/services/constant.dart';
import 'package:fooddeliveryapp/services/database.dart';
import 'package:fooddeliveryapp/services/shared_pref.dart';
import 'package:fooddeliveryapp/services/widget_support.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';

class DetailPage extends StatefulWidget {
   String image;
  String price;
   String name;

String description;
  DetailPage(  { required this.image, required this.name, required this.price, required this.description});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController addresscontroller = TextEditingController();
  Map<String, dynamic>? paymentIntent;
  String?name, id, email, address, wallet;
  int quantity = 1,
      totalprice = 0;

  getthesharedpref() async {
    name = await SharedpreferenceHelper.getUserName();
    id = await SharedpreferenceHelper.getUserId();
    email = await SharedpreferenceHelper.getUserEmail();
    address = await SharedpreferenceHelper.getUserAddress();
    setState(() {

    });
  }

  getUserWallet() async {
    await getthesharedpref();
    QuerySnapshot querySnapshot = await DataBaseMethods().getUserWalletbyemail(
        email!);
    wallet = "${querySnapshot.docs[0]['Wallet']}";

    //print(wallet);
    setState(() {

    });
  }


  void initState() {
    totalprice = int.parse(widget.price);
    getthesharedpref();
    getUserWallet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child:SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 40.0, left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Icon(
                      Icons.arrow_back, size: 30.0, color: Colors.white,),
                  ),
                ),
                SizedBox(height: 10.0),
                Center(
                  child: Image.asset(widget.image,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 3.5,
                    fit: BoxFit.contain,),
                ),
                SizedBox(height: 30.0,),
                Text(widget.name, style: AppWidget.HeadlineTextField(),),
                Text("\$" + widget.price,
                    style: AppWidget.priceTextFieldStyle()),
                SizedBox(height: 20.0),


                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child:
                  Text(
                    widget.description,
                  ),
                ),
                SizedBox(height: 30.0),
                Text("Quantity", style: AppWidget.priceTextFieldStyle(),),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        quantity = quantity + 1;
                        totalprice = totalprice + int.parse(widget.price);

                        setState(() {

                        });
                      },

                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xffef2b39),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.add,
                            color: Colors.white, size: 30.0,
                          ),
                        ),


                      ),
                    ),
                    SizedBox(width: 20.0),
                    Text(quantity.toString(),
                        style: AppWidget.HeadlineTextField()),
                    SizedBox(width: 20.0),
                    GestureDetector(

                      onTap: () {
                        if (quantity > 1) {
                          quantity = quantity - 1;
                          totalprice = totalprice - int.parse(widget.price);

                          setState(() {

                          });
                        }
                      },

                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color(0xffef2b39),
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white, size: 30.0,
                          ),
                        ),),
                    ),
                  ],
                ),
                SizedBox(height: 40.0,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(20),

                      child: Container(
                        height: 60,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Color(0xffef2b39),
                          borderRadius: BorderRadius.circular(20),

                        ),
                        child: Center(child: Text("\$" + totalprice.toString(),
                            style: AppWidget.BoldWhiteTextFieldStyle())),

                      ),
                    ),
                    SizedBox(width: 30.0),
                    GestureDetector(
                      onTap: () async {
                        if (address == null   || addresscontroller.text.isEmpty) {
                          openBox();
                        }
                        else if (int.parse(wallet!) >= totalprice) {
                          int updatedwallet = int.parse(wallet!) - totalprice;
                          await DataBaseMethods().updateUserWallet(
                              updatedwallet.toString(), id!);
                          String orderId = randomAlphaNumeric(10);
                          Map<String, dynamic> userOrderMap = {
                            "Name": name,
                            "Id": id,
                            "Quantity": quantity.toString(),
                            "Total": totalprice.toString(),
                            "Email": email,
                            "FoodName": widget.name,
                            "FoodImage": widget.image,
                            "OrderId": orderId,
                            "Status": "Pending",
                            "Address":  addresscontroller.text,
                            "Timestamp": FieldValue.serverTimestamp(),
                          };
                          await DataBaseMethods().addUserOrderDetails(
                              userOrderMap, id!, orderId);
                          await DataBaseMethods().addAdminOrderDetails(
                              userOrderMap, orderId);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "Order Placed Successfully",
                                style: TextStyle(fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                              )));
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "Add Some Money to Your Wallet",
                                style: TextStyle(fontSize: 10.0,
                                    fontWeight: FontWeight.bold),
                              )));
                        }
                      },
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(20),

                        child: Container(
                          height: 70,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),

                          ),
                          child: Center(child: Text(
                              "Order Now",
                              style: AppWidget.WhiteTextFieldStyle())),

                        ),
                      ),
                    ),


                  ],
                ),
              ],
            )
        ),
      ),


    ),
    );
  }




  Future openBox() {

    return showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              content: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.cancel),
                          ),
                          SizedBox(width: 30.0,),
                          Text("Add the Address",
                            style: TextStyle(
                              color: Color(0xff008000),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          )
                        ],),
                      SizedBox(height: 20.0),
                      Text("Add Address"),
                      SizedBox(height: 10.0),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: addresscontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Address",
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      GestureDetector(
                        onTap: () async {

                        if(addresscontroller.text.trim().isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Warning", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                                content: Text("Please enter your address."),
                                actions: [
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.pop(
                                          context);
                                    },

                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                          address = addresscontroller.text;
                          await SharedpreferenceHelper.saveUserAddress(
                              addresscontroller.text);
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            width: 100,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0xFF008000),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text("Add", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),),
                            ),

                          ),
                        ),

                      ),


                    ],
                  ),
                ),
              ),
            ));
  }
/*createPaymentIntent(String amount,String currency) async {
  try {
    Map<String,dynamic> body={
      'amount':calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]':'card'

    };
    var response= await http.post(
      Uri.parse("https://api.stripe.com/v1/payment_intents"),
      headers:{
        "Authorization": "Bearer $secretkey",
        "Content-Type": "application/x-www-form-urlencoded",
    },
      body:body,


    );
    return jsonDecode(response.body);

  }catch(err){
    print("err changing user:${err.toString()}");
  }
}} */

}





