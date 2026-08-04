import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistItem {
  final String id;
  final String title;
  final String price;
  final String image;

  WishlistItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });
}

class WishlistNotifier extends StateNotifier<List<WishlistItem>> {
  WishlistNotifier()
      : super([
          WishlistItem(
            id: '1',
            title: 'Revival Hoodies',
            price: '\$320.99',
            image: 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
          ),
          WishlistItem(
            id: '2',
            title: 'Neon Puffer Jacket',
            price: '\$450.00',
            image: 'https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&q=80',
          ),
        ]);

  bool isFavorite(String title) {
    return state.any((item) => item.title == title);
  }

  void toggleFavorite({
    required String title,
    required String price,
    required String image,
  }) {
    if (isFavorite(title)) {
      state = state.where((item) => item.title != title).toList();
    } else {
      state = [
        ...state,
        WishlistItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          price: price,
          image: image,
        ),
      ];
    }
  }

  void removeFavorite(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

final wishlistProvider = StateNotifierProvider<WishlistNotifier, List<WishlistItem>>((ref) {
  return WishlistNotifier();
});
