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

class Coupon {
  final String code;
  final String discountText;
  final double percentageDiscount;
  final double flatDiscount;

  const Coupon({
    required this.code,
    required this.discountText,
    this.percentageDiscount = 0.0,
    this.flatDiscount = 0.0,
  });
}

class CartState {
  final List<CartItem> items;
  final Coupon? appliedCoupon;

  CartState({
    required this.items,
    this.appliedCoupon,
  });

  CartState copyWith({
    List<CartItem>? items,
    Coupon? appliedCoupon,
    bool clearCoupon = false,
  }) {
    return CartState(
      items: items ?? this.items,
      appliedCoupon: clearCoupon ? null : (appliedCoupon ?? this.appliedCoupon),
    );
  }

  double get subtotal {
    return items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }

  double get discountAmount {
    if (appliedCoupon == null) return 0.0;
    if (appliedCoupon!.percentageDiscount > 0) {
      return subtotal * (appliedCoupon!.percentageDiscount / 100);
    }
    return appliedCoupon!.flatDiscount;
  }

  double get finalTotal {
    final result = subtotal - discountAmount;
    return result < 0 ? 0.0 : result;
  }

  int get totalItemCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier()
      : super(
          CartState(
            items: [
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
            ],
          ),
        );

  void addItem({
    required String title,
    required double price,
    required String image,
    String size = 'M',
  }) {
    final existingIndex = state.items.indexWhere((item) => item.title == title && item.size == size);
    if (existingIndex >= 0) {
      final updated = [...state.items];
      updated[existingIndex] = updated[existingIndex].copyWith(
        quantity: updated[existingIndex].quantity + 1,
      );
      state = state.copyWith(items: updated);
    } else {
      state = state.copyWith(
        items: [
          ...state.items,
          CartItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: title,
            price: price,
            size: size,
            image: image,
            quantity: 1,
          ),
        ],
      );
    }
  }

  void incrementQuantity(String id) {
    state = state.copyWith(
      items: state.items.map((item) {
        if (item.id == id) {
          return item.copyWith(quantity: item.quantity + 1);
        }
        return item;
      }).toList(),
    );
  }

  void decrementQuantity(String id) {
    state = state.copyWith(
      items: state.items
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
          .toList(),
    );
  }

  void removeItem(String id) {
    state = state.copyWith(
      items: state.items.where((item) => item.id != id).toList(),
    );
  }

  bool applyCouponCode(String code) {
    final cleaned = code.trim().toUpperCase();
    if (cleaned == 'COLLECTIONS20') {
      state = state.copyWith(
        appliedCoupon: const Coupon(
          code: 'COLLECTIONS20',
          discountText: '20% Off Entire Order',
          percentageDiscount: 20.0,
        ),
      );
      return true;
    } else if (cleaned == 'LUXE100') {
      state = state.copyWith(
        appliedCoupon: const Coupon(
          code: 'LUXE100',
          discountText: '\$100 Off VIP Member Discount',
          flatDiscount: 100.0,
        ),
      );
      return true;
    }
    return false;
  }

  void removeCoupon() {
    state = state.copyWith(clearCoupon: true);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

final cartCountProvider = Provider<int>((ref) {
  final cartState = ref.watch(cartProvider);
  return cartState.totalItemCount;
});
