

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DetailRestaurantProvider extends ChangeNotifier{
  final ApiService apiService = ApiService();

  late Restaurant _restaurant;
  ResultState _state = ResultState.Loading;
  String _message = '';

  String get message => _message;
  Restaurant get restarant => _restaurant;
  ResultState get state => _state;

  Future<void> detailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.detailRestaurant(id);
      if (restaurant.restaurant.menus == null) {
        _state = ResultState.NoData;
        _message = 'Empty Data';
        notifyListeners();
      } else {
        _state = ResultState.HasData;
        _restaurant = restaurant.restaurant;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }

  Future<dynamic> addReview(Review review) async {
    try {
      final response = await apiService.addReview(review);
      if (!response.error) {
        detailRestaurant(review.id);
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }
}