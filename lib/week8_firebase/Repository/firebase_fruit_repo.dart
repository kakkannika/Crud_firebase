import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:week8_firebase/week8_firebase/Repository/fruit_repository.dart';
import 'package:week8_firebase/week8_firebase/dto/fruit_dto.dart';
import 'package:week8_firebase/week8_firebase/model/fruit.dart';
import 'dart:io';

class FirebaseFruitRepo extends FruitRepository {
  static const String baseUrl = 'https://crud-fruit-default-rtdb.asia-southeast1.firebasedatabase.app/';
  static const String fruitsCollection = "fruits";
  static const String allFruitsUrl = '$baseUrl/$fruitsCollection.json';

  @override
  Future<Fruit> addFruit({required String name, required double price, required int quantity}) async {
    Uri uri = Uri.parse(allFruitsUrl);

    final newFruitData = {'name': name, 'quantity': quantity, 'price': price};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newFruitData),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add fruit');
    }

    final newId = json.decode(response.body)['name'];
    return Fruit(id: newId, name: name, quantity: quantity, price: price);
  }

  @override
  Future<List<Fruit>> getFruits() async {
    Uri uri = Uri.parse(allFruitsUrl);
    final http.Response response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to load fruits');
    }

    final data = json.decode(response.body) as Map<String, dynamic>?;
    if (data == null) return [];

    return data.entries.map((entry) => FruitDto.fromJson(entry.key, entry.value)).toList();
  }
  // delete
  @override
  Future<void> deleteFruit(String id) async {
    final Uri uri = Uri.parse('$baseUrl/$fruitsCollection/$id.json');
    final response = await http.delete(uri);

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to delete fruit');
    }
  }
  
  // function edit fruit 

  @override
  Future<Fruit> updateFruit({required String id, required String name, required double price, required int quantity}) async {
    final Uri uri = Uri.parse('$baseUrl/$fruitsCollection/$id.json');

    final updatedFruitData = {'name': name, 'quantity': quantity, 'price': price};
    final http.Response response = await http.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedFruitData),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to update fruit');
    }

    return Fruit(id: id, name: name, quantity: quantity, price: price);
  }
}