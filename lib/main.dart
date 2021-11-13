import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:restaurant_app/ui/list_restaurant.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/styles.dart';
import 'package:restaurant_app/ui/splash_screen.dart';

import 'colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          primarySwatch: Colors.blue,
          textTheme: myTextTheme),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        ListRestaurant.routeName: (context) => ListRestaurant(),
        DetailRestaurant.routeName: (context) => DetailRestaurant(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}
