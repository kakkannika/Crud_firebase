import 'package:week8_firebase/week8_firebase/model/fruit.dart';

abstract class FruitRepository {
  Future<Fruit> addFruit({required String name, required int quantity, required double price });
  Future<List<Fruit>> getFruits();
  Future<void> deleteFruit(String id);
  Future<Fruit> updateFruit({required String id, required String name, required int quantity, required double price });
}