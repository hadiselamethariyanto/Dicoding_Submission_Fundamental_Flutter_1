import 'dart:convert';

import 'restaurant.dart';

class Restaurants {
  late List<Restaurant> listRestaurant;
  late bool error;
  late String message;
  late int count;

  Restaurants(
      {required this.listRestaurant,
      required this.error,
      required this.message,
      required this.count});

  factory Restaurants.fromJson(Map<String, dynamic> restaurants) => Restaurants(
      error: restaurants['error'],
      message: restaurants['message'],
      count: restaurants['count'],
      listRestaurant: List<Restaurant>.from(
          restaurants['restaurants'].map((x) => Restaurant.fromJson(x))));

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(listRestaurant.map((x) => x.toJson())),
  };
}

List<Restaurant> parseRestaurants(String? json) {
  if (json == null) {
    return [];
  }
  return Restaurants.fromJson(jsonDecode(json)).listRestaurant;
}
