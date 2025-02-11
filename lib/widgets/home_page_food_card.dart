import 'package:flutter/material.dart';

class HomePageFoodCard extends StatefulWidget {
  const HomePageFoodCard({super.key});

  @override
  _HomePageFoodCardState createState() => _HomePageFoodCardState();
}

class _HomePageFoodCardState extends State<HomePageFoodCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, color: Colors.red, size: 12), // Food type indicator
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Seafood Chowder",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("INR 12.00", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Text("30 calories", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "With clams, scallops, and shrimp, Fresh spanish, mushrooms and hard-bolled eggs ",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30), // Rounded edges
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (quantity > 0) quantity--;
                          });
                        },
                      ),
                      const SizedBox(width: 4,),
                      Text(
                        "$quantity",
                        style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4,),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Customizations Available', style: TextStyle(color: Colors.red),)
              ],
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrBwq1RrWCvEBjqWcXcvMGzk_4WBRFx2JRyg&s", // Replace with actual image URL
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return const Icon(Icons.fastfood, size: 60, color: Colors.green,);
                }
            ),
          ),
        ],
      ),
    );
  }
}