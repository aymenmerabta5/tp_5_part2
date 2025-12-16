import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tp_5_part2/widgets/ProductCard.dart';
import 'package:tp_5_part2/store/cart_state.dart';

class CartDrawer extends ConsumerWidget {
  const CartDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartStateProvider);
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  ProductCard(product: cart[index], isInHome: false,),
              itemCount: cart.length,
            ),
          ),
        ],
      ),
    );
  }
}
