import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_firebase/week8_firebase/UI/provider/fruit_provider.dart';

class AddFruitScreen extends StatefulWidget {
  const AddFruitScreen({Key? key}) : super(key: key);

  @override
  _AddFruitScreenState createState() => _AddFruitScreenState();
}

class _AddFruitScreenState extends State<AddFruitScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _quantity;
  late double _price;

  @override
  void initState() {
    super.initState();
    // Initialize fields with default values
    _name = '';
    _quantity = 0;
    _price = 0.0;
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Call the provider to add the fruit
      Provider.of<FruitProvider>(context, listen: false).addFruit(
        _name,
        _quantity,
        _price,
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Fruit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
                onSaved: (value) {
                  _quantity = int.parse(value!);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Add Fruit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}