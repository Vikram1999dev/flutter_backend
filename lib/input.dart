import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  Future<void>? _sendData() async {
    FocusScope.of(context).unfocus();
    final url = Uri.parse(
        'https://flutter-backend-xxx-xxxxx-default-rtdb.firebaseio.com/products.json');
    final formState = _formKey.currentState;

    if (formState != null && formState.validate()) {
      formState.save();

      final response = await http.post(url,
          body: json.encode({
            'title': _title,
            'description': _description,
            'price': _price,
          }));

      if (response.statusCode == 200) {
        // Data successfully sent
        print('Data sent successfully');
      } else {
        // Error sending data
        print('Error sending data');
      }
    }
  }

  String? _title, _description, _price;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          children: <Widget>[
            Flexible(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Please enter the title of product';
                        }
                        return null;
                      },
                      onSaved: (input) => _title = input,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Please enter Description';
                        }
                        return null;
                      },
                      onSaved: (input) => _description = input,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                    ),
                    TextFormField(
                      validator: (input) {
                        if (input!.isEmpty) {
                          return 'Please the price of the product';
                        }
                        return null;
                      },
                      onSaved: (input) => _price = input,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _sendData,
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
