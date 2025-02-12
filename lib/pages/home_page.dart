import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/data/model/food_response.dart';
import 'package:foodie/data/provider/food_provider.dart';
import 'package:foodie/pages/splash_screen.dart';
import 'package:foodie/widgets/home_page_food_card.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, this.userName, this.phone, required this.uid, this.photoUrl});

  final String? userName;
  final String? phone;
  final String? photoUrl;
  final String uid;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with SingleTickerProviderStateMixin {
  // late TabController _tabController;

  @override
  void initState() {
    super.initState();
    Provider.of<FoodProvider>(context, listen: false).getCategoryList();
    // _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    // _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(
      builder: (context, foodProvider, child) {
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
                  badgeContent: Text(
                      Provider.of<FoodProvider>(context, listen: true).totalCartItemCount.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
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
          body: foodProvider.categoryList.isNotEmpty ? DefaultTabController(
            length: foodProvider.categoryList.length,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(
                  // controller: _tabController,
                  indicatorColor: Colors.red,
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  tabs: List.generate(
                      foodProvider.categoryList.length,
                      (index) => Tab(text: foodProvider.categoryList[index].name ?? '')
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    // controller: _tabController,
                    children: List.generate(foodProvider.categoryList.length, (index) => _buildItemList(foodProvider.categoryList[index].dishes)),
                  ),
                ),
              ],
            ),
          )
              : const Center(child: Text('No data to display'),),
        );
      }
    );
  }

  Widget _buildItemList(List<Dishes> dishes) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return HomePageFoodCard(dish: dishes[index]);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: dishes.length
    );
  }
}