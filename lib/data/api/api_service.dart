import 'dart:convert';
import 'package:http/http.dart';
import 'package:restaurant_app/data/model/add_review_response.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/data/model/detailRestaurantResponse.dart';
import 'package:restaurant_app/data/model/restaurants.dart';
import 'package:restaurant_app/data/model/searchResponse.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Client client = Client();

  Future<Restaurants> getListRestaurant() async {
    final response = await client.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return Restaurants.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<SearchResponse> searchRestaurant(String query) async {
    final response = await client.get(Uri.parse(_baseUrl + "search?q=" + query));
    if (response.statusCode == 200) {
      return SearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<DetailRestaurantResponse> detailRestaurant(String id) async {
    final response = await client.get(Uri.parse(_baseUrl + "detail/" + id));
    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<AddReviewResponse> addReview(Review review) async {
    var _review = jsonEncode(review.toJson());
    final response = await client.post(Uri.parse(_baseUrl + "review"),
        body: _review,
        headers: <String, String>{
          "Content-Type": "application/json",
          "X-Auth-Token": "12345",
        });
    if (response.statusCode == 200) {
      return AddReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
