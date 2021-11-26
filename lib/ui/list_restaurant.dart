import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/app_provider.dart';
import 'package:restaurant_app/resources/strings.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/PlatformWidget.dart';
import 'package:restaurant_app/widgets/restaurant_card_list.dart';

class ListRestaurant extends StatefulWidget {
  static const routeName = '/list_restaurant';

  @override
  _ListRestaurant createState() => new _ListRestaurant();
}

class _ListRestaurant extends State<ListRestaurant> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AppProvider>(context, listen: false).fetchAllRestaurant());
  }

  void searchData(String str) {
    var strExist = str.length > 0 ? true : false;

    if (strExist) {
      if (str.length > 2) {
        Provider.of<AppProvider>(context, listen: false).searchRestaurant(str);
      } else {
        Provider.of<AppProvider>(context, listen: false).fetchAllRestaurant();
      }
    }
  }

  Widget _buildList(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
            padding: EdgeInsets.only(top: 16.0),
            itemCount: state.result.length,
            itemBuilder: (context, index) {
              var restaurant = state.result[index];
              return RestaurantCard(restaurant);
            });
      } else if (state.state == ResultState.NoData) {
        return Center(
          child: Text('Tidak ada data'),
        );
      } else if (state.state == ResultState.Error) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Lottie.asset('assets/no_internet.json'),
              ),
              Text('Tidak ada koneksi internet')
            ],
          ),
        );
      } else {
        return Text('');
      }
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Restaurant'),
      ),
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
                      borderRadius: BorderRadius.all(Radius.circular(12.0)))),
            ),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: _buildList(context),
              ),
            )
          ],
        ),
      ),
    );
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
