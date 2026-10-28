



import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fooddeliveryapp/providers/ui_refresh_provider.dart';
import 'package:fooddeliveryapp/pages/home.dart';
import 'package:fooddeliveryapp/pages/order.dart';
import 'package:fooddeliveryapp/pages/profile.dart';
import 'package:fooddeliveryapp/pages/wallet.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});
@override
State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final UiRefreshProvider _uiRefreshProvider = UiRefreshProvider();

  late List<Widget> pages;
  late Home HomePage;
 late Order order;
 late Wallet wallet;
  late Profile profilepage;


  int currentTabIndex=0;

  @override
  void initState() {
    HomePage = Home();
    order = Order();
   wallet = Wallet();
    profilepage = Profile();


    pages = [HomePage, order,wallet, profilepage];
    super.initState();
  }
    @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<UiRefreshProvider>.value(
      value: _uiRefreshProvider,
      child: Consumer<UiRefreshProvider>(
        builder: (context, refreshProvider, child) {
          return Scaffold(
      resizeToAvoidBottomInset: false,
    bottomNavigationBar: CurvedNavigationBar (
      height: 70,
      backgroundColor:  Colors.white,
      color: Colors.black,
      animationDuration: Duration(milliseconds: 300),
      onTap: (int index) {
        currentTabIndex=index;
        _uiRefreshProvider.refresh();

      },
      items: [

        Icon(
          Icons.home,
          color: Colors.white,
          size: 30.0,
        ),


        Icon(
          Icons.shopping_bag,
          color: Colors.white,
          size: 30.0,
        ),


      Icon(
        Icons.wallet,
        color: Colors.white,
        size: 30.0,
      ),

      Icon(
        Icons.person,
        color: Colors.white,
        size: 30.0,
      ),

      ]),
      body: pages[currentTabIndex],
    );
        },
      ),
    );




  }
}
