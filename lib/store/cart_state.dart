import 'package:riverpod/riverpod.dart';
import 'package:tp_5_part2/models/product.dart';

class ProductCart extends Product {
  final int quantity;

  ProductCart({required String id, required super.name, required super.price, required this.quantity}) : super(id: id);

  ProductCart copyWith({int? quantity}) {
    return ProductCart(id: id, name: name, price: price, quantity: quantity ?? this.quantity);
  }
}


final cartStateProvider = NotifierProvider<CartStateNotifier, List<ProductCart>>(CartStateNotifier.new);

class CartStateNotifier extends Notifier<List<ProductCart>> {
  List<ProductCart> products = [];
  @override
  List<ProductCart> build() {
    return [];
  }

  void addProduct(Product product) {
    state = [...state, ProductCart(id: product.id, name: product.name, price: product.price, quantity: 1)];
  }

  void removeProduct(String id) {
    state = state.where((product) => product.id != id).toList();
  }

  void increaseQuantity(String id) {
    state = state.map((product) => product.id == id ? product.copyWith(quantity: product.quantity + 1) : product).toList();
  }

  void decreaseQuantity(String id) {
    state = state.map((product) => product.id == id ? product.copyWith(quantity: product.quantity - 1) : product).toList();
  }

  void updateQuantity(String id, int quantity) {
    state = state.map((product) => product.id == id ? product.copyWith(quantity: quantity) : product).toList();
  }
}

