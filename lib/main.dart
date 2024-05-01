import 'package:fake_jam_pan/pages/AddFoodItem.dart';
import 'package:fake_jam_pan/pages/AddOrderPage.dart';
import 'package:fake_jam_pan/pages/FoodItemsPage.dart';
import 'package:fake_jam_pan/pages/HomePage.dart';
import 'package:fake_jam_pan/pages/OrderListPage.dart';
import 'package:fake_jam_pan/pages/SplashScreenPage.dart';
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
      initialRoute: '/splash-screen',
      routes: {
        '/splash-screen': (context) => const SplashScreenPage(),
        '/': (context) => const HomePage(),
        '/food-items': (context) => const FoodItemsPage(),
        '/add-food-item': (context) => AddFoodItemsPage(),
        '/add-order': (context) => AddOrderPage(),
        '/order-list': (context) => OrderListPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
