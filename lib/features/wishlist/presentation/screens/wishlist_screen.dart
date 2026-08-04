import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/collections_bottom_nav.dart';
import '../../../../core/widgets/navigation/top_header.dart';
import '../../../../core/widgets/notifications/glass_toast.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistItems = ref.watch(wishlistProvider);
    final cartCount = ref.watch(cartCountProvider);

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
                      '${wishlistItems.length} Items',
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Expanded(
                    child: wishlistItems.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.favorite_border_rounded, size: 64, color: AppColors.outline),
                                const SizedBox(height: AppSpacing.md),
                                Text('YOUR WISHLIST IS EMPTY', style: AppTextStyles.title),
                                const SizedBox(height: AppSpacing.xs),
                                Text('Save pieces to track upcoming drops', style: AppTextStyles.bodySmall),
                              ],
                            ),
                          )
                        : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.62,
                              crossAxisSpacing: AppSpacing.md,
                              mainAxisSpacing: AppSpacing.lg,
                            ),
                            itemCount: wishlistItems.length,
                            itemBuilder: (context, index) {
                              final item = wishlistItems[index];
                              return ProductCard(
                                title: item.title,
                                price: item.price,
                                imageUrl: item.image,
                                onTap: () => context.push('/product-details'),
                                onAddToCart: () {
                                  final numPrice = double.tryParse(item.price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 290.00;
                                  ref.read(cartProvider.notifier).addItem(
                                        title: item.title,
                                        price: numPrice,
                                        image: item.image,
                                      );
                                  GlassToast.show(
                                    context,
                                    message: 'Added ${item.title} to Bag!',
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
          CollectionsBottomNav(
            currentIndex: 1,
            cartItemCount: cartCount,
            onTap: (index) {
              if (index == 0) context.go('/home');
              if (index == 2) context.go('/cart');
              if (index == 3) context.go('/settings');
            },
          ),
        ],
      ),
    );
  }
}
