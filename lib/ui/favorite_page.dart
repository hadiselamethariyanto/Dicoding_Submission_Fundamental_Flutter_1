import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/resources/colors.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/PlatformWidget.dart';
import 'package:restaurant_app/widgets/restaurant_card_list.dart';

class FavoritePage extends StatelessWidget {
  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.HasData) {
        return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: provider.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = provider.restaurants[index];
              return RestaurantCard(restaurant);
            });
      } else {
        return Center(
          child: Text(provider.message),
        );
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restaurant'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Daftar Restaurant'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
