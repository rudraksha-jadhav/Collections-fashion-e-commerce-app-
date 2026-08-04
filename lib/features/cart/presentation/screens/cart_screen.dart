import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartProvider);
    final cartItems = cartState.items;
    final totalPrice = cartState.finalTotal;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: cartItems.isNotEmpty ? 190 : 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(
                title: 'YOUR BAG',
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
                trailing: GestureDetector(
                  onTap: () => context.push('/cart/coupons'),
                  child: Text(
                    cartState.appliedCoupon != null ? 'Promo: ${cartState.appliedCoupon!.code} ✓' : 'Coupons & Promos →',
                    style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: cartItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shopping_bag_outlined, size: 64, color: AppColors.outline),
                            const SizedBox(height: AppSpacing.md),
                            Text('YOUR BAG IS EMPTY', style: AppTextStyles.title),
                            const SizedBox(height: AppSpacing.xs),
                            Text('Discover drops and add pieces to your bag', style: AppTextStyles.bodySmall),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: cartItems.length,
                        separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
                          return GlassCard(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: AppRadius.radiusSm,
                                  child: CachedNetworkImage(
                                    imageUrl: item.image,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.title, style: AppTextStyles.title.copyWith(fontSize: 16)),
                                      const SizedBox(height: 2),
                                      Text('Size: ${item.size}', style: AppTextStyles.bodySmall),
                                      const SizedBox(height: 6),
                                      Text('\$${item.price.toStringAsFixed(2)}', style: AppTextStyles.headline.copyWith(fontSize: 16)),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline, color: AppColors.outline, size: 20),
                                      onPressed: () {
                                        ref.read(cartProvider.notifier).decrementQuantity(item.id);
                                      },
                                    ),
                                    Text('${item.quantity}', style: AppTextStyles.title),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline, color: AppColors.primaryContainer, size: 20),
                                      onPressed: () {
                                        ref.read(cartProvider.notifier).incrementQuantity(item.id);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ).animate().fadeIn(delay: (index * 100).ms);
                        },
                      ),
              ),
              if (cartItems.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.md),
                if (cartState.appliedCoupon != null)
                  GlassCard(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount (${cartState.appliedCoupon!.code}):', style: AppTextStyles.bodySmall),
                        Text('-\$${cartState.discountAmount.toStringAsFixed(2)}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryContainer, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                const SizedBox(height: AppSpacing.xs),
                GlassCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('TOTAL', style: AppTextStyles.caption.copyWith(fontSize: 10)),
                          Text('\$${totalPrice.toStringAsFixed(2)}', style: AppTextStyles.headline.copyWith(fontSize: 20)),
                        ],
                      ),
                      const Spacer(),
                      PrimaryButton(
                        label: 'Checkout',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: () => context.push('/checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
