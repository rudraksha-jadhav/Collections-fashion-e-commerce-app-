import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final String size;
  final String image;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.size,
    required this.image,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      title: title,
      price: price,
      size: size,
      image: image,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier()
      : super([
          CartItem(
            id: '1',
            title: 'Revival Hoodies',
            price: 320.99,
            size: 'M',
            image: 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
            quantity: 1,
          ),
          CartItem(
            id: '2',
            title: 'Solid Hoodies',
            price: 290.00,
            size: 'L',
            image: 'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&q=80',
            quantity: 1,
          ),
        ]);

  void addItem({
    required String title,
    required double price,
    required String image,
    String size = 'M',
  }) {
    final existingIndex = state.indexWhere((item) => item.title == title && item.size == size);
    if (existingIndex >= 0) {
      final updated = [...state];
      updated[existingIndex] = updated[existingIndex].copyWith(
        quantity: updated[existingIndex].quantity + 1,
      );
      state = updated;
    } else {
      state = [
        ...state,
        CartItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          price: price,
          size: size,
          image: image,
          quantity: 1,
        ),
      ];
    }
  }

  void incrementQuantity(String id) {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(quantity: item.quantity + 1);
      }
      return item;
    }).toList();
  }

  void decrementQuantity(String id) {
    state = state
        .map((item) {
          if (item.id == id) {
            if (item.quantity > 1) {
              return item.copyWith(quantity: item.quantity - 1);
            }
            return null;
          }
          return item;
        })
        .whereType<CartItem>()
        .toList();
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  double get totalPrice {
    return state.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get itemCount {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final cartTotalProvider = Provider<double>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
});

final cartCountProvider = Provider<int>((ref) {
  final items = ref.watch(cartProvider);
  return items.fold(0, (sum, item) => sum + item.quantity);
});
