class Foods {
  late String name;

  Foods({required this.name});

  factory Foods.fromJson(Map<String, dynamic> food) =>
      Foods(name: food["name"]);
}
