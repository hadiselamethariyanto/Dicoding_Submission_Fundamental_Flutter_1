import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/review.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';

class ReviewDialog extends StatelessWidget {
  final String id;
  final DetailRestaurantProvider provider = DetailRestaurantProvider();

  ReviewDialog({required this.id});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var reviewController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      title: Text("Add Review"),
      content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) return "Name Required";
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: reviewController,
                  validator: (value) {
                    if (value!.isEmpty) return "Review Required";
                    return null;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Review",
                      prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Icon(Icons.rate_review)),
                      contentPadding: EdgeInsets.only(left: 10, top: 15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)))),
                )
              ],
            ),
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Sending...")));
                Review review = Review(
                  id: id,
                  name: nameController.text,
                  review: reviewController.text,
                );
                provider.addReview(review).then((value) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Success!")));
                  Navigator.pop(context);
                });
              }
            },
            child: Text("Save"))
      ],
    );
  }
}
