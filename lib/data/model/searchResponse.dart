import 'package:restaurant_app/data/model/restaurant.dart';

class SearchResponse {
  late bool error;
  late int founded;
  late List<Restaurant> restaurants;

  SearchResponse(
      {required this.error, required this.founded, required this.restaurants});

  factory SearchResponse.fromJson(json) => SearchResponse(
      error: json['error'],
      founded: json['founded'],
      restaurants: List<Restaurant>.from(
          json['restaurants'].map((x) => Restaurant.fromJson(x))));
}
