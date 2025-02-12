import 'package:flutter/material.dart';
import 'package:foodie/data/datasource/food_datasource.dart';
import 'package:foodie/data/model/food_response.dart';

class FoodProvider extends ChangeNotifier{

  List<Categories> categoryList = [];
  int totalCartItemCount = 0;

  Future<void> getCategoryList() async {
    categoryList = await FoodDataSource().getFoodDataFromRemote() ?? [];
    notifyListeners();
  }

  void addToCart(){
    totalCartItemCount++;
    notifyListeners();
  }

  void removeFromCart(){
    if (totalCartItemCount > 0) totalCartItemCount--;
    notifyListeners();
  }

}