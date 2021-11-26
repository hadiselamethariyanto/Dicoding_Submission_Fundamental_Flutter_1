import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/result_state.dart';

class AppProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Restaurant> _restaurantResult = [];
  ResultState _state = ResultState.Loading;
  String _message = '';

  String get message => _message;
  List<Restaurant> get result => _restaurantResult;
  ResultState get state => _state;

  Future<void> fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.getListRestaurant();
      if (restaurants.listRestaurant.isEmpty) {
        _state = ResultState.NoData;
        _message = 'Empty Data';
        notifyListeners();
      } else {
        _state = ResultState.HasData;
        _restaurantResult = restaurants.listRestaurant;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }

  Future<void> searchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurants = await apiService.searchRestaurant(query);
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.NoData;
        _message = 'Empty Data';
        notifyListeners();
      } else {
        _state = ResultState.HasData;
        _restaurantResult = restaurants.restaurants;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error --> $e';
      notifyListeners();
    }
  }

}
