import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/add_review_response.dart';
import 'package:restaurant_app/data/model/detailRestaurantResponse.dart';
import 'package:restaurant_app/data/model/restaurants.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/data/model/searchResponse.dart';

void main() async {
  group('App service test', () {

    test('test get list restaurant', () async {
        final apiService = ApiService();
        apiService.client = MockClient((request) async {
          final mapJson = {
            "error": false,
            "message": "success",
            "count": 20,
            "restaurants": [
              {
                "id": "rqdv5juczeskfw1e867",
                "name": "Melting Pot",
                "description":
                "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
                "pictureId": "14",
                "city": "Medan",
                "rating": 4.2
              }
            ]
          };
          return Response(json.encode(mapJson),200);
        });
        final item = await apiService.getListRestaurant();
        expect(item, isA<Restaurants>());
    });

    test('test get detail restaurant',() async{
      final apiService = ApiService();
      apiService.client = MockClient((request) async {
        final mapJson = {
          "error": false,
          "message": "success",
          "restaurant": {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
            "city": "Medan",
            "address": "Jln. Pandeglang no 19",
            "pictureId": "14",
            "categories": [
              {
                "name": "Italia"
              },
              {
                "name": "Modern"
              }
            ],
            "menus": {
              "foods": [
                {
                  "name": "Paket rosemary"
                },
                {
                  "name": "Toastie salmon"
                }
              ],
              "drinks": [
                {
                  "name": "Es krim"
                },
                {
                  "name": "Sirup"
                }
              ]
            },
            "rating": 4.2,
            "customerReviews": [
              {
                "name": "Ahmad",
                "review": "Tidak rekomendasi untuk pelajar!",
                "date": "13 November 2019"
              }
            ]
          }
        };
        return Response(json.encode(mapJson),200);
      });
      final item = await apiService.detailRestaurant("");
      expect(item, isA<DetailRestaurantResponse>());
    });

    test('test searach restaurant',() async{
      final apiService = ApiService();
      apiService.client = MockClient((request) async {
        final mapJson = {
          "error": false,
          "founded": 1,
          "restaurants": [
            {
              "id": "fnfn8mytkpmkfw1e867",
              "name": "Makan mudah",
              "description": "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
              "pictureId": "22",
              "city": "Medan",
              "rating": 3.7
            }
          ]
        };

        return Response(json.encode(mapJson),200);
      });
      final item = await apiService.searchRestaurant("");
      expect(item, isA<SearchResponse>());
    });

    test('test add review',() async{
      final apiService = ApiService();
      apiService.client = MockClient((request) async {
        final mapJson = {
          "error": false,
          "message": "success",
          "customerReviews": [
            {
              "name": "Ahmad",
              "review": "Tidak rekomendasi untuk pelajar!",
              "date": "13 November 2019"
            },
            {
              "name": "test",
              "review": "makanannya lezat",
              "date": "29 Oktober 2020"
            }
          ]
        };

        return Response(json.encode(mapJson),200);
      });

      Review review = Review(
        id: "",
        name: "",
        review: "",
      );

      final item = await apiService.addReview(review);
      expect(item, isA<AddReviewResponse>());
    });


  });
}
