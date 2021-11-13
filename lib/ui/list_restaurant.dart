import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:restaurant_app/model/restaurants.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/strings.dart';
import 'package:restaurant_app/widgets/PlatformWidget.dart';

class ListRestaurant extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _ListRestaurant createState() => new _ListRestaurant();
}

class _ListRestaurant extends State<ListRestaurant> {
  TextEditingController searchController = TextEditingController();

  List<Restaurant>? _restaurants;
  List<Restaurant>? _filteredRestaurant;

  @override
  void initState() {
    super.initState();
    loadData().then((value) {
      setState(() {
        _restaurants = value;
        _filteredRestaurant = _restaurants;
      });
    });
  }

  void searchData(String str) {
    var strExist = str.length > 0 ? true : false;

    if (strExist) {
      if (str.length > 2) {
        setState(() {
          _filteredRestaurant = _restaurants!
              .where((element) =>
                  element.name.toLowerCase().contains(str.toLowerCase()))
              .toList();
        });
      } else {
        setState(() {
          _filteredRestaurant = _restaurants;
        });
      }
    }
  }

  Future<String> _loadRestaurantAsset() async {
    return await rootBundle.loadString('assets/local_restaurant.json');
  }

  Future<List<Restaurant>> loadData() async {
    String jsonString = await _loadRestaurantAsset();
    final jsonResponse = json.decode(jsonString);
    return new Restaurants.fromJson(jsonResponse).listRestaurant;
  }

  Widget _buildList(BuildContext context) {
    if (_filteredRestaurant?.length == 0) {
      return Center(
        child: Text('Tidak ada data'),
      );
    } else {
      return ListView.builder(
          padding: EdgeInsets.only(top: 16.0),
          itemCount: _filteredRestaurant?.length ?? 0,
          itemBuilder: (context, index) {
            return _buildRestaurantItem(context, _filteredRestaurant![index]);
          });
    }
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailRestaurant.routeName,
            arguments: restaurant);
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Hero(
                  tag: restaurant,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(restaurant.pictureId))),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(restaurant.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.location_on_outlined, size: 14),
                          SizedBox(width: 4.0),
                          Text(restaurant.city),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.star, size: 14),
                          SizedBox(width: 4.0),
                          Text(restaurant.rating.toString())
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Daftar Restaurant')),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  onChanged: (value) {
                    searchData(value);
                  },
                  controller: searchController,
                  decoration: InputDecoration(
                      labelText: label_search,
                      hintText: label_search,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0)))),
                ),
                Expanded(
                  child: SizedBox(
                    height: 200.0,
                    child: _buildList(context),
                  ),
                )
              ],
            )));
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Daftar Restaurant'),
          transitionBetweenRoutes: false,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CupertinoTextField(
                onChanged: (value) {
                  searchData(value);
                },
                controller: searchController,
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: _buildList(context),
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
