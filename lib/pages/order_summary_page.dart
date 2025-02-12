import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie/data/model/food_response.dart';
import 'package:foodie/data/provider/food_provider.dart';
import 'package:foodie/widgets/order_summary_food_card.dart';
import 'package:provider/provider.dart';

class OrderSummaryPage extends StatelessWidget {
  const OrderSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Summary',
          style: TextStyle(fontSize: 20, color: Colors.black54),
        ),
        elevation: 4,
        shadowColor: Colors.black
      ),
      body: Provider.of<FoodProvider>(context, listen: true).cartDishes.isNotEmpty ? Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.black12)
                // color: Colors.yellow
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.green,
                    ),
                    height: 54,
                    child: Center(
                      child: Text(
                        '${Provider.of<FoodProvider>(context, listen: true).cartDishes.toSet().length} Dishes - ${Provider.of<FoodProvider>(context, listen: true).cartDishes.length} Items',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Expanded(
                      child: _buildItemList(Provider.of<FoodProvider>(context, listen: false).cartDishes, context)
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: (){
                showMyDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Place Order',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
                ),
              ),
            ),
          ),
          const SizedBox(height: 20,)
        ],
      ) :
      const Center(child: Text('Your cart is empty'),),
    );
  }

  Widget _buildItemList(List<Dishes> dishes, BuildContext context) {
    Set dishSet = {};
    dishSet.addAll(dishes);
    return ListView.separated(
        itemBuilder: (context, index) {
          return Column(
            children: [
              OderSummaryFoodCard(dish: dishSet.toList()[index]),
              if(index+1 == dishSet.length)...[
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                          'Total Amount',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      Text(
                        'INR ${getTotalAmount(context)}',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(),
              ]
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: dishSet.length
    );
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Order successfully placed"),
          content: const Text("Your order will be delivered soon."),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<FoodProvider>(context, listen: false).clearCart();
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Close the dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Go to Dashboard"),
              ),
            ),
          ],
        );
      },
    );
  }

  String getTotalAmount(BuildContext context){
    double totalAmount = 0;
    List<Dishes> cartDishes = Provider.of<FoodProvider>(context, listen: true).cartDishes;
    for (var dish in cartDishes) {
      totalAmount = totalAmount + double.parse(dish.price ?? '0');
    }
    return totalAmount.toStringAsFixed(2);
  }

}
