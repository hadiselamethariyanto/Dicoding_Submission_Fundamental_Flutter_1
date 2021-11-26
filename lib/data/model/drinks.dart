class Drinks {
  late String name;

  Drinks({required this.name});

  factory Drinks.fromJson(Map<String,dynamic> drink)=>Drinks(
    name: drink["name"]
  );
}
