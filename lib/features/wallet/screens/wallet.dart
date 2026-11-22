import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import "dart:convert";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:fooddeliveryapp/providers/wallet_provider.dart';
import "package:flutter_stripe/flutter_stripe.dart";
import "package:fooddeliveryapp/core/config/constant.dart";
import "package:fooddeliveryapp/core/services/database.dart";
import "package:fooddeliveryapp/core/services/shared_pref.dart";
import "package:fooddeliveryapp/core/theme/widget_support.dart";
import "package:http/http.dart" as http;
import "package:intl/intl.dart";
import "package:random_string/random_string.dart";

class Wallet extends StatefulWidget {



  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  final WalletProvider _walletProvider = WalletProvider();

  Map<String,dynamic>? paymentIntent;
  TextEditingController amountcontroller= TextEditingController();
  @override
  void initState() {
    super.initState();
    _walletProvider.loadWallet();
  }
  Widget allTransaction() {
    return StreamBuilder(
        stream: _walletProvider.transactions, builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData ? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,

          itemBuilder: (context, index) {

            DocumentSnapshot ds=snapshot.data.docs[index];


            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 20,right: 20.0, bottom: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: HotFlavourColors.cream,borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Expanded(child: Text(ds['Date'],style:TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),)),
                  SizedBox(width: 20.0,),
                  Column(
                    children: [


                      Text(ds["Type"] == "Refund" ? "Refund Amount" : "Amount Added to Wallet"),
                      Text("\$" + ds["Amount"],style: TextStyle(color: HotFlavourColors.primary, fontSize: 18,fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              ),

            );

          }) : Container();
    });
  }




  @override
  void dispose() {
    _walletProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WalletProvider>.value(
      value: _walletProvider,
      child: Consumer<WalletProvider>(
        builder: (context, walletProvider, child) {
          return Scaffold(
      resizeToAvoidBottomInset: false,
      body:SafeArea(
        child:walletProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : walletProvider.error != null
              ? Center(child: Text(walletProvider.error!))
              : Container(
          margin: EdgeInsets.only(top:40.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Wallet",style: AppWidget.HeadlineTextField(),),
                ],),
              SizedBox(height: 10,),
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


                      Container(
                        margin: EdgeInsets.only(left:20.0,right: 20.0,top: 20.0),
                        child:   Material(
                          elevation: 3.0,
                          borderRadius:BorderRadius.circular(10),
                          child: Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(left:20.0,top:20,right: 18),
                              width:MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                              child:Row(
                                children: [
                                  Image.asset("images/wallet.png",
                                    height:100,
                                    width:100,
                                    fit: BoxFit.cover,),
                                  SizedBox(width: 60.0,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Your Wa!llet",style:AppWidget.boldTextFieldStyle()),
                                      Text("\$"+walletProvider.wallet!, style: AppWidget.boldTextFieldStyle(),)

                                    ],
                                  )
                                ],
                              )
                          ),
                        ),

                      ),
                      SizedBox(height: 20.0,),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap:(){
                                makePayment("100");

                              },
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black45,width: 2.0,),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text("\$100", style: AppWidget.priceTextFieldStyle(),)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                makePayment("50");
                              },
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black45,width: 2.0,),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text("\$50", style: AppWidget.priceTextFieldStyle(),)),
                              ),
                            ),

                            GestureDetector(
                              onTap: (){
                                makePayment('200');
                              },
                              child: Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.black45,width: 2.0,),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text("\$200", style: AppWidget.priceTextFieldStyle(),)),
                              ),
                            )

                          ],
                        ),
                      ),
                      SizedBox(height: 30.0,),
                      GestureDetector(
                        onTap: (){
                          openBox();
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 20.0,right: 20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: HotFlavourColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Add Money",
                              style: AppWidget.BoldWhiteTextFieldStyle(),),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)

                              )),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Text("Your Transactions", style:AppWidget.boldTextFieldStyle() ,),
                              SizedBox(height: 20.0,),
                              Expanded(

                                //height: MediaQuery.of(context).size.height/2.5,
                                child: allTransaction(),
                              )


                            ],
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
        },
      ),
    );
  }
  Future <void> makePayment(String amount) async {
    if (_walletProvider.isProcessingPayment) return;
    _walletProvider.setProcessingPayment(true);
    try {
      paymentIntent = await createPaymentIntent(amount, "USD");
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent?['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: "Adnan")).then((value) {});

      await displayPaymentSheet(amount);
    } catch (e, s) {
      print("Exception:$e$s");
    } finally {
      _walletProvider.setProcessingPayment(false);
    }
  }

  Future<void> displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        int updatedWallet=int.parse(_walletProvider.wallet!) + int.parse(amount);
        await DataBaseMethods().updateUserWallet(updatedWallet.toString(), _walletProvider.userId!);
        await _walletProvider.loadWallet();
        DateTime now=DateTime.now();
        String formattedDate=DateFormat("dd-MMM-yyyy").format(now);
        Map<String,dynamic> userTransactionMap={
          "Amount":amount,
          "Date":formattedDate,
          "Timestamp": FieldValue.serverTimestamp(),
          "Type": "Added",

        };

        await DataBaseMethods.addUserTransaction(userTransactionMap, _walletProvider.userId!);

        showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        ),
                        Text("Payment Successfully")
                      ],
                    )
                  ],
                ),
              ),
        );

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print("Error is----> $error $stackTrace");
      });
    } on StripeException catch (e) {
      print("Error is----> $e");
      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                content: Text("Cancelled"),


              )

      );
    } catch (e) {
      print("$e");
    }
  }



  createPaymentIntent(String amount,String currency) async {
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
  }
  String calculateAmount(String amount) {
    final calculatedAmount = int.parse(amount) * 100;
    return calculatedAmount.toString();
  }


  Future openBox()=> showDialog(
      context:context,
      builder:(context)=>AlertDialog(
        content:SingleChildScrollView(
          child:Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel),
                    ),
                    SizedBox(width:30.0,),
                    Text("Add the Amount",
                      style: TextStyle(
                        color: HotFlavourColors.deepRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    )],),
                SizedBox(height:20.0),
                Text("Enter Amount"),
                SizedBox(height:10.0),

                Container(
                  decoration: BoxDecoration(
                    color: HotFlavourColors.cream,
                    border: Border.all(
                      color: HotFlavourColors.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: TextField(
                    controller: amountcontroller,
                    decoration: const InputDecoration(
                      hintText: "Amount",
                      filled: false,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 18,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),

                SizedBox(height: 20.0,),
                GestureDetector(
                  onTap: () async {

                    if (amountcontroller.text
                        .trim()
                        .isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Warning", style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                            content: Text("Please enter  the amount."),
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



                    await   makePayment(amountcontroller.text);
                    amountcontroller.clear();
                    if(mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: Center(
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: HotFlavourColors.deepRed,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Add",style: TextStyle(
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