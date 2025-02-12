import 'package:flutter/material.dart';
import 'package:foodie/data/model/food_response.dart';
import 'package:foodie/data/provider/food_provider.dart';
import 'package:provider/provider.dart';

class HomePageFoodCard extends StatefulWidget {
  const HomePageFoodCard({super.key, required this.dish});

  final Dishes dish;

  @override
  _HomePageFoodCardState createState() => _HomePageFoodCardState();
}

class _HomePageFoodCardState extends State<HomePageFoodCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4),
            child: Icon(Icons.circle, color: Colors.red, size: 12),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.dish.name ?? 'Dish name',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("INR ${widget.dish.price ?? '0'}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    Text("${widget.dish.calories ?? '0'} calories", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.dish.description ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          Provider.of<FoodProvider>(context, listen: false).removeFromCart(widget.dish);
                        },
                      ),
                      const SizedBox(width: 4,),
                      Text(getCount(widget.dish.id),
                        style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4,),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          Provider.of<FoodProvider>(context, listen: false).addToCart(widget.dish);
                        },
                      ),
                    ],
                  ),
                ),
                if(widget.dish.customizationsAvailable != null && widget.dish.customizationsAvailable!) ...[
                  const SizedBox(height: 8),
                  const Text('Customizations Available', style: TextStyle(color: Colors.red),)
                ]
              ],
            ),
          ),
          const SizedBox(width: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.network(
                widget.dish.imageUrl ?? '',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return const Icon(Icons.fastfood, size: 60, color: Colors.orange,);
                }
            ),
          ),
        ],
      ),
    );
  }

  String getCount(int? dishId){
    List<Dishes> cartDishes = Provider.of<FoodProvider>(context, listen: true).cartDishes;
    return cartDishes.where((dish) => dish.id == dishId).toList().length.toString();
  }

}