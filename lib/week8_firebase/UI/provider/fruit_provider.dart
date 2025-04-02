import 'package:flutter/material.dart';
import 'package:week8_firebase/week8_firebase/Repository/fruit_repository.dart';
import 'package:week8_firebase/week8_firebase/async_value.dart';
import 'package:week8_firebase/week8_firebase/model/fruit.dart';

class FruitProvider extends ChangeNotifier {
  final FruitRepository _repository;
  AsyncValue<List<Fruit>>? fruitsState;

  FruitProvider(this._repository) {
    fetchFruits();
  }

  bool get isLoading => fruitsState?.state == AsyncValueState.loading;
  bool get hasData => fruitsState?.state == AsyncValueState.success;
 
  void fetchFruits() async {
    try {
      fruitsState = AsyncValue.loading();
      notifyListeners();

      fruitsState = AsyncValue.success(await _repository.getFruits());
    } catch (error) {
      fruitsState = AsyncValue.error(error);
    }
    notifyListeners();
  }

  Future<void> addFruit(String name, int quantity, double price) async {
    await _repository.addFruit(name: name, quantity: quantity, price: price);
    fetchFruits();
  }
  
  // function remove 

  Future<void> removeFruit(String id) async {
    await _repository.deleteFruit(id);
    fetchFruits();
 }
  // function update 
  Future<void> updateFruit(String id, String name, int quantity, double price) async {
    await _repository.updateFruit(id: id, name: name, quantity: quantity, price: price);
    fetchFruits();
    
  }
}