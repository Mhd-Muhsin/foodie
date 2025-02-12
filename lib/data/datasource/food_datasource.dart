import 'dart:convert';

import 'package:foodie/data/model/food_response.dart';
import 'package:http/http.dart' as http;

class FoodDataSource{

  final client = http.Client();

  Future<List<Categories>?> getFoodDataFromRemote() async {

    final response = await client.get(
      Uri.parse('https://faheemkodi.github.io/mock-menu-api/menu.json'),
    );

    if (response.statusCode == 200) {
      print(response.body);

      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      final FoodResponse foodResponse = FoodResponse.fromJson(responseBody);

      return foodResponse.categories;
    }
    return null;
  }

}