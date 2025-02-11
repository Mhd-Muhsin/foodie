import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/pages/splash_screen.dart';
import 'package:foodie/widgets/home_page_food_card.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  HomePage(
      {super.key, this.userName, this.phone, required this.uid, this.photoUrl});

  final String? userName;
  final String? phone;
  final String? photoUrl;
  final String uid;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this); // 3 Tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
        },),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 3),
              badgeContent: const Text(
                '3', // Dynamic cart count
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navigate to cart page
                },
              ),
            ),
          ),
        ],
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
                          widget.photoUrl ?? '',
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
                      (widget.userName != null && widget.userName!.isNotEmpty) ? widget.userName! : (widget.phone != null && widget.phone!.isNotEmpty) ? widget.phone! : 'Name/Phone not found',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'UID: ${widget.uid}',
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
      body: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.red,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              tabs: const [
                Tab(text: "Breakfast"),
                Tab(text: "Lunch"),
                Tab(text: "Dinner"),
                Tab(text: "Breakfast"),
                Tab(text: "Lunch"),
                Tab(text: "Dinner"),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildItemList(["Pancakes", "Omelette", "Toast"]),
                  _buildItemList(["Pancakes", "Omelette", "Toast"]),
                  _buildItemList(["Pancakes", "Omelette", "Toast"]),
                  _buildItemList(["Pancakes", "Omelette", "Toast"]),
                  _buildItemList(["Pancakes", "Omelette", "Toast"]),
                  _buildItemList(["Pancakes", "Omelette", "Toast"]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemList(List<String> items) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return HomePageFoodCard();
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: items.length
    );
  }
}