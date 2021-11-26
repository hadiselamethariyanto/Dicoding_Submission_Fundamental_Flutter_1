import 'package:restaurant_app/data/model/restaurant.dart';

class DetailRestaurantResponse {
  late bool error;
  late String message;
  late Restaurant restaurant;

  DetailRestaurantResponse(
      {required this.error, required this.message, required this.restaurant});

  factory DetailRestaurantResponse.fromJson(json) => DetailRestaurantResponse(
      error: json['error'],
      message: json['message'],
      restaurant: Restaurant.fromJson(json['restaurant']));
}
