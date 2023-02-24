import 'package:flutter/material.dart';
import './display.dart';
import './input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // To ensure that the keyboard appears above all elements when
        // it is opened, you can wrap the contents of the scaffold in
        // a SingleChildScrollView and set the resizeToAvoidBottomInset
        //  property of the scaffold to false.
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Flutter connecting to firebase server'),
        ),
        body: Column(
          children: [
            Input(),
            Display(),
          ],
        ));
  }
}
