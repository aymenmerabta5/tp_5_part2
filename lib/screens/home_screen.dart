import 'package:flutter/material.dart';
import 'package:tp_5_part2/models/product.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tp_5_part2/screens/cart_drawer.dart';
import 'package:tp_5_part2/widgets/ProductCard.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Product> products = [
    Product(name: 'Product 1', price: 100),
    Product(name: 'Product 2', price: 200),
    Product(name: 'Product 3', price: 300),
    Product(name: 'Product 4', price: 400),
    Product(name: 'Product 5', price: 500),
    Product(name: 'Product 6', price: 600),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        // actions: [
        //   IconButton(onPressed: () {
        //     Scaffold.of(context).openDrawer();
        //   }, icon: Icon(Icons.shopping_cart))
        // ]
      ),
      drawer: CartDrawer(),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
        ),
        children: products.map((product) => ProductCard(product: product)).toList(),
      )
    );
  }
}