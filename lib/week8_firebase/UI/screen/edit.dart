import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week8_firebase/week8_firebase/UI/provider/fruit_provider.dart';
import 'package:week8_firebase/week8_firebase/model/fruit.dart';

class EditFruitScreen extends StatefulWidget {
  final Fruit fruit;

  const EditFruitScreen({Key? key, required this.fruit}) : super(key: key);

  @override
  _EditFruitScreenState createState() => _EditFruitScreenState();
}

class _EditFruitScreenState extends State<EditFruitScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late int _quantity;
  late double _price;

  @override
  void initState() {
    super.initState();
    _name = widget.fruit.name;
    _quantity = widget.fruit.quantity;
    _price = widget.fruit.price;
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Call the provider to update the fruit
      Provider.of<FruitProvider>(context, listen: false).updateFruit(
        widget.fruit.id,
        _name,
        _quantity,
        _price,
      );

    
      Navigator.of(context).pop();
    }
  }
  // for edit 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Edit Fruit', style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
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
                initialValue: _quantity.toString(),
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
                initialValue: _price.toString(),
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
                child: const Text('Updates')
              ),
            ],
          ),
        ),
      ),
    );
  }
}