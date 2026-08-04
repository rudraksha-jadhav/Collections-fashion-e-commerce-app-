import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/glass_button.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';

import '../../../../core/widgets/chips/size_chip.dart';
import '../../../../core/widgets/notifications/glass_toast.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  String _selectedSize = 'M';
  final List<String> _sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () => context.push('/products/image-viewer'),
                      child: Container(
                        height: 480,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: AppColors.surfaceContainerLow,
                            highlightColor: AppColors.surfaceContainerHigh,
                            child: Container(color: AppColors.surfaceContainerLow),
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GlassCard(
                              borderRadius: AppRadius.radiusFull,
                              padding: const EdgeInsets.all(AppSpacing.sm + 2),
                              onTap: () => context.pop(),
                              child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                            ),
                            GlassCard(
                              borderRadius: AppRadius.radiusFull,
                              padding: const EdgeInsets.all(AppSpacing.sm + 2),
                              onTap: () {
                                GlassToast.show(
                                  context,
                                  message: 'Saved Revival Hoodie to Wishlist!',
                                  icon: Icons.favorite_rounded,
                                );
                                context.push('/wishlist');
                              },
                              child: const Icon(Icons.favorite_border_rounded, size: 20, color: AppColors.primary),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LIMITED EDITION DROP',
                        style: AppTextStyles.caption,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Revival Hoodies',
                            style: AppTextStyles.headline.copyWith(fontSize: 26),
                          ),
                          Text(
                            '\$320.99',
                            style: AppTextStyles.headline.copyWith(
                              fontSize: 22,
                              color: AppColors.primaryContainer,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Heavyweight organic cotton hoodie featuring high-density archival graphics and a signature relaxed streetwear silhouette.',
                        style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SELECT SIZE', style: AppTextStyles.caption),
                          GestureDetector(
                            onTap: () => context.push('/products/size-guide'),
                            child: Text(
                              'Size Guide →',
                              style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: _sizes.map((size) {
                          final isSelected = _selectedSize == size;
                          return Padding(
                            padding: const EdgeInsets.only(right: AppSpacing.sm),
                            child: SizeChip(
                              label: size,
                              isSelected: isSelected,
                              onTap: () {
                                setState(() {
                                  _selectedSize = size;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      GlassCard(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        onTap: () => context.push('/products/reviews'),
                        child: Row(
                          children: [
                            const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '4.9 (128 Community Reviews)',
                                style: AppTextStyles.body.copyWith(fontSize: 14),
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.outline, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 48,
                      child: GlassButton(
                        label: 'BUY NOW',
                        onPressed: () {
                          ref.read(cartProvider.notifier).addItem(
                            title: 'Revival Hoodies',
                            price: 320.99,
                            image: 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
                            size: _selectedSize,
                          );
                          HapticFeedback.mediumImpact();
                          context.push('/checkout');
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 48,
                      child: PrimaryButton(
                        label: 'Add To Bag',
                        icon: Icons.shopping_bag_outlined,
                        onPressed: () {
                          ref.read(cartProvider.notifier).addItem(
                            title: 'Revival Hoodies',
                            price: 320.99,
                            image: 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
                            size: _selectedSize,
                          );
                          HapticFeedback.mediumImpact();
                          GlassToast.show(
                            context,
                            message: 'Added Revival Hoodie (Size $_selectedSize) to Bag!',
                            icon: Icons.shopping_bag_outlined,
                          );
                          context.push('/cart');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
