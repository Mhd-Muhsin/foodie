import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/food_datasource.dart';
import 'package:foodie/data/model/food_response.dart';

class FoodProvider extends ChangeNotifier{

  List<Categories> categoryList = [];
  List<Dishes> cartDishes = [];
  bool isLoading = true;

  Future<void> getCategoryList() async {
    categoryList = await FoodDataSource().getFoodDataFromRemote() ?? [];
    isLoading = false;
    notifyListeners();
  }

  void addToCart(Dishes dish){
    cartDishes.add(dish);
    notifyListeners();
  }

  void removeFromCart(Dishes dish){
    cartDishes.remove(dish);
    notifyListeners();
  }

  void clearCart(){
    cartDishes.clear();
    notifyListeners();
  }

}