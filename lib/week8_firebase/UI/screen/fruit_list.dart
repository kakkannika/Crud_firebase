import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_firebase/week8_firebase/UI/provider/fruit_provider.dart';
import 'package:week8_firebase/week8_firebase/UI/screen/add_edit.dart';
import 'package:week8_firebase/week8_firebase/UI/screen/edit.dart';
import 'package:week8_firebase/week8_firebase/model/fruit.dart';

class FruitListScreen extends StatelessWidget {
  const FruitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FruitProvider>(context);

    Widget content = const Center(child: Text(''));
    if (provider.isLoading) {
      content = const CircularProgressIndicator();
    } else if (provider.hasData) {
      List<Fruit> fruits = provider.fruitsState!.data!;
      content = ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          final fruit = fruits[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.pink[50],
            child: ListTile(
              title: Text(fruit.name),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Quantity: ${fruit.quantity}"),
                  Text("Price: \$${fruit.price.toStringAsFixed(2)}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                     
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditFruitScreen(fruit: fruit),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => provider.removeFruit(fruit.id),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fruits"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => AddFruitScreen(),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
      // body: Padding(padding: const EdgeInsets.all(8), child: content),
    );
  }
}