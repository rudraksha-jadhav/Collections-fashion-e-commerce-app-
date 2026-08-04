import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/collections_bottom_nav.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  final List<Map<String, String>> _wishlistItems = const [
    {
      'title': 'Revival Hoodies',
      'price': '\$320.99',
      'image': 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Solid Hoodies',
      'price': '\$290.00',
      'image': 'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Neon Puffer Jacket',
      'price': '\$450.00',
      'image': 'https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopHeader(
                    title: 'WISHLIST',
                    leading: GlassCard(
                      borderRadius: AppRadius.radiusFull,
                      padding: const EdgeInsets.all(AppSpacing.sm + 2),
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/home');
                        }
                      },
                      child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                    ),
                    trailing: Text(
                      '${_wishlistItems.length} Items',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.62,
                        crossAxisSpacing: AppSpacing.md,
                        mainAxisSpacing: AppSpacing.lg,
                      ),
                      itemCount: _wishlistItems.length,
                      itemBuilder: (context, index) {
                        final item = _wishlistItems[index];
                        return ProductCard(
                          title: item['title']!,
                          price: item['price']!,
                          imageUrl: item['image']!,
                          onTap: () => context.push('/product-details'),
                          onAddToCart: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added ${item['title']} to Bag!')),
                            );
                          },
                        ).animate().fadeIn(delay: (index * 100).ms);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          CollectionsBottomNav(
            currentIndex: 1,
            onTap: (index) {
              if (index == 0) context.go('/home');
              if (index == 2) context.go('/cart');
              if (index == 3) context.go('/profile');
            },
          ),
        ],
      ),
    );
  }
}
