import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/customerReviews.dart';
import 'package:restaurant_app/resources/colors.dart';
import 'package:restaurant_app/resources/styles.dart';

class ReviewCard extends StatelessWidget {
  final CustomerReviews review;

  ReviewCard(this.review);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: grey,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review.name,style: myTextTheme.headline6),
            SizedBox(height: 4),
            Text(review.date,style: myTextTheme.bodyText2),
            SizedBox(height: 4),
            Text(review.review)
          ],
        ),
      ),
    );
  }
}
