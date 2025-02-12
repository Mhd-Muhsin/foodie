import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodie/data/model/food_response.dart';
import 'package:foodie/main.dart';
import 'package:http/http.dart' as http;

class FoodDataSource{

  final client = http.Client();

  Future<List<Categories>?> getFoodDataFromRemote() async {

    try {
      final response = await client.get(
            Uri.parse('https://faheemkodi.github.io/mock-menu-api/menuv.json'),
          );

      if (response.statusCode == 200) {

            final Map<String, dynamic> responseBody = jsonDecode(response.body);

            final FoodResponse foodResponse = FoodResponse.fromJson(responseBody);

            return foodResponse.categories;
          } else {
        scaffoldMessengerKey.currentState?.showSnackBar(
              const SnackBar(content: Text('Something went wrong')),
            );
          }
    } catch (e) {
      scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('Something went wrong')),
      );
    }
    return null;
  }

}