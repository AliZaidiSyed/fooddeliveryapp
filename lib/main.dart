
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:fooddeliveryapp/core/config/constant.dart';
import 'package:fooddeliveryapp/core/theme/hot_flavour_theme.dart';
import 'package:fooddeliveryapp/features/auth/screens/authwrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = publishedkey;

  await Firebase.initializeApp();

  await Supabase.initialize(
    url: 'https://lskgqgjgyoceehbcacpm.supabase.co',
    publishableKey:
    'sb_publishable_VF8Y0nN_wNjUivvemuchKQ_n-XDJ_1j',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: HotFlavourTheme.light,
      home: Authwrapper(),
    );
  }
}
