import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodie/data/provider/food_provider.dart';
import 'package:foodie/pages/home_page.dart';
import 'package:foodie/pages/login_page.dart';
import 'package:foodie/pages/phone_number_page.dart';
import 'package:foodie/pages/splash_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FoodProvider())
      ],
      child: MaterialApp(
        title: 'Foodie',
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: ThemeData(
          primaryColor: Colors.green,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
