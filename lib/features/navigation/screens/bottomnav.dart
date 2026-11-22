import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';




import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fooddeliveryapp/providers/food_delivery_provider.dart';
import 'package:fooddeliveryapp/features/catalog/screens/home.dart';
import 'package:fooddeliveryapp/features/orders/screens/order.dart';
import 'package:fooddeliveryapp/features/profile/screens/profile.dart';
import 'package:fooddeliveryapp/features/wallet/screens/wallet.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});
@override
State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final FoodDeliveryProvider _foodDeliveryProvider = FoodDeliveryProvider();

  late List<Widget> pages;
  late Home HomePage;
 late Order order;
 late Wallet wallet;
  late Profile profilepage;



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
  void dispose() {
    _foodDeliveryProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<FoodDeliveryProvider>.value(
      value: _foodDeliveryProvider,
      child: Consumer<FoodDeliveryProvider>(
        builder: (context, refreshProvider, child) {
          return Scaffold(
      resizeToAvoidBottomInset: false,
    bottomNavigationBar: CurvedNavigationBar (
      height: 70,
      backgroundColor: HotFlavourColors.surface,
      color: HotFlavourColors.deepRed,
      animationDuration: Duration(milliseconds: 300),
      onTap: (int index) {
        _foodDeliveryProvider.selectTab(index);

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
      body: pages[refreshProvider.selectedTab],
    );
        },
      ),
    );




  }
}
