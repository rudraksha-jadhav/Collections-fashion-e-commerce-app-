import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';
import '../../../../core/widgets/notifications/glass_toast.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

import '../widgets/filter_sort_sheets.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  final List<Map<String, String>> _products = const [
    {
      'title': 'Tokyo Oversized Tee',
      'price': '180.00',
      'image': 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Cyberpunk Denim Jacket',
      'price': '420.00',
      'image': 'https://images.unsplash.com/photo-1543076447-215ad9ba6923?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Revival Hoodies',
      'price': '320.99',
      'image': 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Solid Hoodies',
      'price': '290.00',
      'image': 'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&q=80',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(
                title: 'ALL PRODUCTS',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GlassCard(
                      borderRadius: AppRadius.radiusFull,
                      padding: const EdgeInsets.all(AppSpacing.sm + 2),
                      onTap: () => FilterSortSheets.showFilterSheet(context),
                      child: const Icon(Icons.tune_rounded, size: 20, color: AppColors.primary),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    GlassCard(
                      borderRadius: AppRadius.radiusFull,
                      padding: const EdgeInsets.all(AppSpacing.sm + 2),
                      onTap: () => FilterSortSheets.showSortSheet(context),
                      child: const Icon(Icons.sort_rounded, size: 20, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final item = _products[index];
                    final priceDouble = double.tryParse(item['price']!) ?? 200.0;

                    return ProductCard(
                      title: item['title']!,
                      price: '\$${item['price']}',
                      imageUrl: item['image']!,
                      onTap: () => context.push('/product-details'),
                      onAddToCart: () {
                        ref.read(cartProvider.notifier).addItem(
                          title: item['title']!,
                          price: priceDouble,
                          image: item['image']!,
                        );
                        HapticFeedback.mediumImpact();
                        GlassToast.show(
                          context,
                          message: 'Added ${item['title']} to Bag!',
                          icon: Icons.shopping_bag_outlined,
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
    );
  }
}
