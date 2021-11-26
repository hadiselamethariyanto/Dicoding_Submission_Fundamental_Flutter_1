import 'package:restaurant_app/data/model/customerReviews.dart';

class AddReviewResponse {
  late bool error;
  late String message;
  late List<CustomerReviews> customerReviews;

  AddReviewResponse(
      {required this.error,
      required this.message,
      required this.customerReviews});

  factory AddReviewResponse.fromJson(json) => AddReviewResponse(
      error: json['error'],
      message: json['message'],
      customerReviews: List<CustomerReviews>.from(
          json['customerReviews'].map((x) => CustomerReviews.fromJson(x))));
}
