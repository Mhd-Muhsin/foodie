import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/data/model/food_response.dart';
import 'package:foodie/data/provider/food_provider.dart';
import 'package:provider/provider.dart';

class OderSummaryFoodCard extends StatefulWidget {
  const OderSummaryFoodCard({super.key, required this.dish});

  final Dishes dish;

  @override
  _OderSummaryFoodCardState createState() => _OderSummaryFoodCardState();
}

class _OderSummaryFoodCardState extends State<OderSummaryFoodCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text("INR ${widget.dish.price ?? '0'}", style: const TextStyle(fontSize: 14)),
                Text("${widget.dish.calories ?? '0'} calories", style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 4),
              ],
            ),
          ),
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
                  icon: Provider.of<FoodProvider>(context, listen: false).cartDishes.length > 1 ? const Icon(Icons.remove, color: Colors.white) : const Icon(Icons.delete, color: Colors.white),
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
          const SizedBox(width: 10),
          SizedBox(width: 70, child: Text("INR ${widget.dish.price ?? '0'}", style: const TextStyle(fontSize: 14, ))),
        ],
      ),
    );
  }

  String getCount(int? dishId){
    List<Dishes> cartDishes = Provider.of<FoodProvider>(context, listen: true).cartDishes;
    return cartDishes.where((dish) => dish.id == dishId).toList().length.toString();
  }

}