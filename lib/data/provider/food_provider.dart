import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/food_datasource.dart';
import 'package:foodie/data/model/food_response.dart';

class FoodProvider extends ChangeNotifier{

  List<Categories> categoryList = [];
  // int totalCartItemCount = 0;
  List<Dishes> cartDishes = [];

  Future<void> getCategoryList() async {
    categoryList = await FoodDataSource().getFoodDataFromRemote() ?? [];
    notifyListeners();
  }

  void addToCart(Dishes dish){
    // totalCartItemCount++;
    cartDishes.add(dish);
    notifyListeners();
  }

  void removeFromCart(Dishes dish){
    // if (totalCartItemCount > 0) totalCartItemCount--;
    cartDishes.remove(dish);
    notifyListeners();
  }

}