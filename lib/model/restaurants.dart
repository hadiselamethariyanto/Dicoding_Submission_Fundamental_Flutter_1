import 'dart:convert';

import 'restaurant.dart';

class Restaurants {
  late List<Restaurant> listRestaurant;

  Restaurants({required this.listRestaurant});

  factory Restaurants.fromJson(Map<String, dynamic> restaurants) => Restaurants(
      listRestaurant: List<Restaurant>.from(
          restaurants['restaurants'].map((x) => Restaurant.fromJson(x))));
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }
  return Restaurants.fromJson(jsonDecode(json)).listRestaurant;
}
