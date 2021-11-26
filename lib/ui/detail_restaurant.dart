import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/resources/colors.dart';
import 'package:restaurant_app/resources/strings.dart';
import 'package:restaurant_app/resources/styles.dart';
import 'package:restaurant_app/ui/review_dialog.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/PlatformWidget.dart';
import 'package:restaurant_app/widgets/review_card_list.dart';

class DetailRestaurant extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const DetailRestaurant({required this.restaurant});

  @override
  State<DetailRestaurant> createState() => _DetailRestaurantState();
}

class _DetailRestaurantState extends State<DetailRestaurant> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<DetailRestaurantProvider>(context, listen: false)
            .detailRestaurant(widget.restaurant.id));
  }

  Widget _buildRestaurant(BuildContext context) {
    return Consumer<DetailRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          var restaurant = state.restarant;
          return ListView(children: [
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
                      children: [
                        RatingBarIndicator(
                          rating: restaurant.rating,
                          itemCount: 5,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: yellow,
                          ),
                          itemSize: 24,
                        ),
                        Text('${restaurant.rating}')
                      ],
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
                    Text(restaurant.description),
                    SizedBox(height: 16),
                    Text(label_foods, style: myTextTheme.subtitle1),
                    SizedBox(height: 8),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: restaurant.menus?.foods.length,
                        itemBuilder: (context, index) {
                          final food = restaurant.menus?.foods[index];
                          return Text("\u2022 " + food!.name);
                        }),
                    SizedBox(height: 16),
                    Text(label_drinks, style: myTextTheme.subtitle1),
                    SizedBox(height: 8),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: restaurant.menus?.drinks.length,
                        itemBuilder: (context, index) {
                          final drink = restaurant.menus?.drinks[index];
                          return Text("\u2022 " + drink!.name);
                        }),
                    SizedBox(height: 16),
                    Text(label_reviews, style: myTextTheme.subtitle1),
                    SizedBox(height: 8),
                    Container(
                      height: 120,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: restaurant.customerReviews?.length,
                          itemBuilder: (context, index) {
                            final review = restaurant.customerReviews![index];
                            return ReviewCard(review);
                          }),
                    )
                  ],
                ) //ss,
                )
          ]);
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
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              backgroundColor: primaryColor,
              pinned: true,
              expandedHeight: 200,
              actions: [
                Consumer<DatabaseProvider>(
                  builder: (context, provider, child) {
                    return FutureBuilder<bool>(
                        future: provider.isFavorite(widget.restaurant.id),
                        builder: (context, snapshot) {
                          var isFavorite = snapshot.data ?? false;
                          return isFavorite
                              ? IconButton(
                                  icon: Icon(Icons.favorite),
                                  onPressed: () => provider.removeRestaurant(widget.restaurant.id),
                                )
                              : IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: () => provider
                                      .addRestaurant(widget.restaurant));
                        });
                  },
                )
              ],
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                return FlexibleSpaceBar(
                    title: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: top > 71 && top < 91 ? 1.0 : 0.0,
                        child: Text(
                          top > 71 && top < 91
                              ? widget.restaurant.name
                              : "Expanded",
                          style: myTextTheme.headline6,
                        )),
                    background: Image.network(
                      'https://restaurant-api.dicoding.dev/images/small/'+widget.restaurant.pictureId,
                      fit: BoxFit.cover,
                    ));
              }),
            )
          ];
        },
        body: _buildRestaurant(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => ReviewDialog(id: widget.restaurant.id));
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.restaurant.name),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                child: Image.network('https://restaurant-api.dicoding.dev/images/small/'+widget.restaurant.pictureId),
              ),
              _buildRestaurant(context)
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}
