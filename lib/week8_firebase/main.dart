import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_firebase/week8_firebase/Repository/firebase_fruit_repo.dart';
import 'package:week8_firebase/week8_firebase/Repository/fruit_repository.dart';
import 'package:week8_firebase/week8_firebase/UI/provider/fruit_provider.dart';
import 'package:week8_firebase/week8_firebase/UI/screen/fruit_list.dart';

void main() async {
  final FruitRepository fruitRepository = FirebaseFruitRepo();

  runApp(
    ChangeNotifierProvider(
      create: (_) => FruitProvider(fruitRepository),
      child: const MaterialApp(debugShowCheckedModeBanner: false, home:FruitListScreen()),
    ),
  );
}