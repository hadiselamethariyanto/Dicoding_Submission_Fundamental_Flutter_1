class Review {
  late String id;
  late String name;
  late String review;

  Review({required this.id, required this.name, required this.review});

  Map<String, dynamic> toJson() => {"id": id, "name": name, "review": review};
}
