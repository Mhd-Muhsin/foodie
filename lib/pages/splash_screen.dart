import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.active){
              if(snapshot.data == null) {
                return const LoginPage();
              } else {
                return HomePage(userName: snapshot.data?.displayName, phone: snapshot.data?.phoneNumber, uid: snapshot.data?.uid ?? '', photoUrl: snapshot.data?.photoURL,);
              }
            }
            return const Center(child: CircularProgressIndicator());
          }
      ),
    );
  }
}
