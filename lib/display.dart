import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Display extends StatefulWidget {
  const Display({super.key});

  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  Stream<List<dynamic>>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = _fetchData();
  }

  Stream<List<dynamic>> _fetchData() async* {
    while (true) {
      final response = await http.get(Uri.parse(
          'https://flutter-backend-xxx-xxxxx-default-rtdb.firebaseio.com/products.json'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final products = data.values.toList();
        yield products;
      }

      await Future.delayed(const Duration(seconds: 5));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data!;
          return Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product['title']),
                  subtitle: Text(product['description']),
                  trailing: Text('\$${product['price']}'),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
