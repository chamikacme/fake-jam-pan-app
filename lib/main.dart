import 'package:fake_jam_pan/pages/AddOrderPage.dart';
import 'package:fake_jam_pan/pages/FoodItemsPage.dart';
import 'package:fake_jam_pan/pages/HomePage.dart';
import 'package:fake_jam_pan/pages/OrderListPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fake Jam Pan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/food-items': (context) => const FoodItemsPage(),
        '/add-order': (context) => const AddOrderPage(),
        '/order-list': (context) => const OrderListPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
