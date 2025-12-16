import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tp_5_part2/models/product.dart';
import 'package:tp_5_part2/store/cart_state.dart';

class ProductCard extends ConsumerWidget {
  final Product product;
  final bool isInHome;
  const ProductCard({super.key, required this.product, this.isInHome = true});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartStateProvider);
    final isInCart = cart.any((p) => p.id == product.id);
    final quantityController = TextEditingController(
      text: isInCart ? cart.firstWhere((p) => p.id == product.id).quantity.toString() : '1',
    );
    return Card(
      child: Padding(padding: const EdgeInsets.all(8.0), child: Column(
        children: [
         Image.asset('assets/cat.jpeg', height: 100, width: double.infinity, fit: BoxFit.cover,),
          Text(product.name),
          const SizedBox(height: 10),
          Text('${product.price}'),
          const SizedBox(height: 10),
          if (!isInHome) 
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                final quantity = int.tryParse(value) ?? 1;
                ref.read(cartStateProvider.notifier).updateQuantity(product.id, quantity);
              }
            ),
          ElevatedButton(onPressed: () {
            if (isInHome) {
              if (isInCart) {
              ref.read(cartStateProvider.notifier).increaseQuantity(product.id);
              } else {
              ref.read(cartStateProvider.notifier).addProduct(product);
              }
            } else {
              ref.read(cartStateProvider.notifier).removeProduct(product.id);
            }
          
          }, child: Text(isInHome ? 'Add to Cart' : 'Remove from Cart')),
        ],
      ),
    ));
  }

}