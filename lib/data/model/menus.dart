import 'drinks.dart';
import 'foods.dart';

class Menus {
  late List<Foods> foods;
  late List<Drinks> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> menus)=>
      Menus(
          foods: List<Foods>.from(
              menus["foods"].map((food) => Foods.fromJson(food))),
          drinks: List<Drinks>.from(
              menus["drinks"].map((drink) => Drinks.fromJson(drink)))
      );
}
