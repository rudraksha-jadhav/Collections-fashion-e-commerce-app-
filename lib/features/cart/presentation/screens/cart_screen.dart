import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../../../../core/widgets/notifications/glass_toast.dart';
import '../../../settings/presentation/providers/currency_provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  final _couponController = TextEditingController();

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final cartItems = cartState.items;
    final currencyNotifier = ref.watch(currencyProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: 120),
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
              ),
              const SizedBox(height: AppSpacing.lg),

              if (cartItems.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
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
                  ),
                )
              else ...[
                // Item List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
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
                                Text(currencyNotifier.formatPrice(item.price), style: AppTextStyles.headline.copyWith(fontSize: 16)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: AppColors.outline, size: 20),
                                onPressed: () {
                                  HapticFeedback.lightImpact();
                                  ref.read(cartProvider.notifier).decrementQuantity(item.id);
                                },
                              ),
                              Text('${item.quantity}', style: AppTextStyles.title),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline, color: AppColors.primaryContainer, size: 20),
                                onPressed: () {
                                  HapticFeedback.lightImpact();
                                  ref.read(cartProvider.notifier).incrementQuantity(item.id);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: (index * 80).ms);
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                // Coupon Code Entry Card
                GlassCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('PROMO / COUPON CODE', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                          GestureDetector(
                            onTap: () => context.push('/cart/coupons'),
                            child: Text('View Available →', style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer)),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      if (cartState.appliedCoupon == null)
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _couponController,
                                textCapitalization: TextCapitalization.characters,
                                style: AppTextStyles.body.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                                decoration: InputDecoration(
                                  hintText: 'Enter code (e.g. COLLECTIONS20)',
                                  hintStyle: AppTextStyles.bodySmall,
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  filled: true,
                                  fillColor: AppColors.surfaceContainerLow,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(AppRadius.sm),
                                    borderSide: const BorderSide(color: AppColors.outlineVariant),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            PrimaryButton(
                              label: 'Apply',
                              onPressed: () {
                                if (_couponController.text.trim().isEmpty) return;
                                final success = ref.read(cartProvider.notifier).applyCouponCode(_couponController.text);
                                if (success) {
                                  HapticFeedback.mediumImpact();
                                  GlassToast.show(
                                    context,
                                    message: 'Applied coupon ${_couponController.text.trim().toUpperCase()}!',
                                    icon: Icons.local_offer_outlined,
                                  );
                                  _couponController.clear();
                                } else {
                                  GlassToast.show(
                                    context,
                                    message: 'Invalid promo code. Try COLLECTIONS20 or LUXE100',
                                    icon: Icons.error_outline_rounded,
                                  );
                                }
                              },
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            const Icon(Icons.local_offer_rounded, color: AppColors.primaryContainer, size: 20),
                            const SizedBox(width: AppSpacing.xs),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${cartState.appliedCoupon!.code} APPLIED',
                                    style: AppTextStyles.title.copyWith(fontSize: 14, color: AppColors.primaryContainer),
                                  ),
                                  Text(
                                    cartState.appliedCoupon!.discountText,
                                    style: AppTextStyles.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                ref.read(cartProvider.notifier).removeCoupon();
                                GlassToast.show(
                                  context,
                                  message: 'Coupon removed',
                                  icon: Icons.remove_circle_outline,
                                );
                              },
                              child: const Text('Remove', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // Detailed Bill Summary Breakdown
                GlassCard(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BILL DETAILS', style: AppTextStyles.caption.copyWith(fontSize: 11, letterSpacing: 1.5)),
                      const SizedBox(height: AppSpacing.md),
                      _buildBillRow('Bag Subtotal', currencyNotifier.formatPrice(cartState.subtotal)),
                      const SizedBox(height: AppSpacing.xs),
                      if (cartState.appliedCoupon != null) ...[
                        _buildBillRow(
                          'Coupon Discount (${cartState.appliedCoupon!.code})',
                          '-${currencyNotifier.formatPrice(cartState.discountAmount)}',
                          isDiscount: true,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                      ],
                      _buildBillRow('Platform & Concierge Fee', currencyNotifier.formatPrice(cartState.platformFee)),
                      const SizedBox(height: AppSpacing.xs),
                      _buildBillRow(
                        'Express Shipping (DHL)',
                        cartState.shippingFee == 0 ? 'FREE' : currencyNotifier.formatPrice(cartState.shippingFee),
                        isHighlighted: cartState.shippingFee == 0,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        child: Divider(color: AppColors.outlineVariant),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('FINAL TOTAL', style: AppTextStyles.title.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            currencyNotifier.formatPrice(cartState.finalTotal),
                            style: AppTextStyles.headline.copyWith(fontSize: 22, color: AppColors.primaryContainer),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                PrimaryButton(
                  label: 'Proceed to Checkout (${currencyNotifier.formatPrice(cartState.finalTotal)})',
                  icon: Icons.arrow_forward_rounded,
                  width: double.infinity,
                  onPressed: () => context.push('/checkout'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBillRow(String label, String value, {bool isDiscount = false, bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodySmall),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            color: isDiscount
                ? AppColors.primaryContainer
                : isHighlighted
                    ? AppColors.primaryContainer
                    : AppColors.primary,
            fontWeight: isDiscount || isHighlighted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
