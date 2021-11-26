import 'package:restaurant_app/data/model/customerReviews.dart';

import 'menus.dart';

class Restaurant {
  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;
  late Menus? menus;
  late List<CustomerReviews>? customerReviews;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.menus,
      required this.customerReviews});

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating
      };

  factory Restaurant.fromJson(Map<String, dynamic> restaurant) => Restaurant(
      id: restaurant['id'],
      name: restaurant['name'],
      description: restaurant['description'],
      pictureId:restaurant['pictureId'],
      city: restaurant['city'],
      rating: (restaurant['rating'] as num).toDouble(),
      menus: restaurant['menus'] != null
          ? Menus.fromJson(restaurant['menus'])
          : null,
      customerReviews: restaurant['customerReviews'] != null
          ? List<CustomerReviews>.from(restaurant['customerReviews']
              .map((x) => CustomerReviews.fromJson(x)))
          : null);
}
