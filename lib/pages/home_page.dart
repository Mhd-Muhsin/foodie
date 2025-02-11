import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/pages/splash_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage(
      {super.key, this.userName, this.phone, required this.uid, this.photoUrl});

  final String? userName;
  final String? phone;
  final String? photoUrl;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (bContext) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(bContext).openDrawer();
            },
          );
        }),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width / 1.1,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 24, left: 20, right: 20),
                decoration: const BoxDecoration(
                  color: Colors.green,
                    borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: ClipOval(
                        child: Image.network(
                          photoUrl ?? '',
                          fit: BoxFit.cover, height: double.infinity, width: double.infinity,
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return const Center(
                                child: Icon(Icons.person, size: 40,));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      (userName != null && userName!.isNotEmpty) ? userName! : (phone != null && phone!.isNotEmpty) ? phone! : 'Name/Phone not found',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'UID: $uid',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.blueGrey,),
                title: const Text('Log out', style: TextStyle(color: Colors.blueGrey),),
                onTap: () async {
                  await GoogleSignIn().signOut();
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const SplashScreen()),
                      (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
