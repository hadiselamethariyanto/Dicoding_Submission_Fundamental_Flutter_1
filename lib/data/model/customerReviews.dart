class CustomerReviews {
  late String name;
  late String review;
  late String date;

  CustomerReviews(
      {required this.name, required this.review, required this.date});

  factory CustomerReviews.fromJson(Map<String, dynamic> json)=>
      CustomerReviews(
          name: json['name'], review: json['review'], date: json['date']);
}