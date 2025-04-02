import 'package:week8_firebase/week8_firebase/model/fruit.dart';

class FruitDto {
  static Fruit fromJson(String id, Map<String, dynamic> json) {
    return 
    Fruit(
         id: id, name: json['name'],
          quantity: json['quantity'],
          price: json['price'] ?? 0.0, 
          );
  }

  static Map<String, dynamic> toJson(Fruit fruit) {
    return {'name': fruit.name, 'quantity': fruit.quantity};
  }
}