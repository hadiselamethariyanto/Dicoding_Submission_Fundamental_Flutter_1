import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/strings.dart';
import 'package:restaurant_app/styles.dart';
import 'package:restaurant_app/widgets/PlatformWidget.dart';

import '../model/restaurant.dart';

class DetailRestaurant extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const DetailRestaurant({required this.restaurant});

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: top > 71 && top < 91 ? 1.0 : 0.0,
                        child: Text(
                          top > 71 && top < 91 ? restaurant.name : "Expanded",
                          style: myTextTheme.headline6,
                        )),
                    background: Image.network(
                      restaurant.pictureId,
                      fit: BoxFit.cover,
                    ));
              }),
            )
          ];
        },
        body: ListView(children: [
          Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    restaurant.name,
                    style: myTextTheme.headline5,
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.location_on_outlined, size: 14),
                      SizedBox(width: 4.0),
                      Text(
                        restaurant.city,
                        style: myTextTheme.bodyText2,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(label_description, style: myTextTheme.subtitle1),
                  SizedBox(height: 8),
                  Text(restaurant.description, style: myTextTheme.bodyText2),
                  SizedBox(height: 16),
                  Text(label_foods, style: myTextTheme.subtitle1),
                  SizedBox(height: 8),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: restaurant.menus.foods.length,
                      itemBuilder: (context, index) {
                        final food = restaurant.menus.foods[index];
                        return Text("\u2022 "+food.name);
                      }),
                  SizedBox(height: 16),
                  Text(label_drinks, style: myTextTheme.subtitle1),
                  SizedBox(height: 8),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: restaurant.menus.drinks.length,
                      itemBuilder: (context, index) {
                        final drink = restaurant.menus.drinks[index];
                        return Text("\u2022 "+drink.name);
                      })
                ],
              ) //ss,
              )
        ]),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(restaurant.name),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                child: Image.network(restaurant.pictureId),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      restaurant.name,
                      style: CupertinoTheme.of(context)
                          .textTheme
                          .navLargeTitleTextStyle,
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(CupertinoIcons.location, size: 14),
                        SizedBox(width: 4.0),
                        Text(
                          restaurant.city,
                          style: CupertinoTheme.of(context).textTheme.textStyle,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(label_description,
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .tabLabelTextStyle),
                    SizedBox(height: 8),
                    Text(restaurant.description,
                        style: CupertinoTheme.of(context).textTheme.textStyle),
                    SizedBox(height: 16),
                    Text(label_menus,
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .tabLabelTextStyle),
                  ],
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
