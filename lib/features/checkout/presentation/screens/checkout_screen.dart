import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../orders/presentation/providers/orders_provider.dart';
import '../../../settings/presentation/providers/currency_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int _selectedPayment = 0;
  final List<String> _paymentMethods = ['Apple Pay', 'Credit Card (•••• 9841)', 'Google Pay'];

  @override
  Widget build(BuildContext context) {
    final cartState = ref.watch(cartProvider);
    final currencyNotifier = ref.watch(currencyProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GlassCard(
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
                  Text(
                    'CHECKOUT',
                    style: GoogleFonts.libreCaslonText(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView(
                  children: [
                    Text('SHIPPING ADDRESS', style: AppTextStyles.caption),
                    const SizedBox(height: AppSpacing.xs),
                    GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      onTap: () => context.push('/checkout/saved-addresses'),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: AppColors.primary),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rudraksha Jadhav', style: AppTextStyles.title.copyWith(fontSize: 15)),
                                Text('742 Evergreen Terrace, Suite 4B\nNew York, NY 10001', style: AppTextStyles.bodySmall),
                              ],
                            ),
                          ),
                          const Icon(Icons.edit_outlined, color: AppColors.outline, size: 18),
                        ],
                      ),
                    ).animate().fadeIn(),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PAYMENT METHOD', style: AppTextStyles.caption),
                        GestureDetector(
                          onTap: () => context.push('/checkout/saved-payment'),
                          child: Text('Manage →', style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer)),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Column(
                      children: List.generate(_paymentMethods.length, (index) {
                        final isSelected = _selectedPayment == index;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: GlassCard(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            backgroundColor: isSelected ? AppColors.surfaceContainerHigh : AppColors.glassBackground,
                            onTap: () {
                              setState(() {
                                _selectedPayment = index;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                                  color: isSelected ? AppColors.primaryContainer : AppColors.outline,
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Text(_paymentMethods[index], style: AppTextStyles.body),
                              ],
                            ),
                          ),
                        );
                      }),
                    ).animate().fadeIn(delay: 200.ms),
                    const SizedBox(height: AppSpacing.lg),

                    // Bill Breakdown Section
                    GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ORDER SUMMARY BILL', style: AppTextStyles.caption.copyWith(fontSize: 11, letterSpacing: 1.5)),
                          const SizedBox(height: AppSpacing.md),
                          _buildBillRow('Subtotal (${cartState.totalItemCount} items)', currencyNotifier.formatPrice(cartState.subtotal)),
                          const SizedBox(height: AppSpacing.xs),
                          if (cartState.appliedCoupon != null) ...[
                            _buildBillRow(
                              'Coupon Discount (${cartState.appliedCoupon!.code})',
                              '-${currencyNotifier.formatPrice(cartState.discountAmount)}',
                              isDiscount: true,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                          ],
                          _buildBillRow('Platform Fee', currencyNotifier.formatPrice(cartState.platformFee)),
                          const SizedBox(height: AppSpacing.xs),
                          _buildBillRow(
                            'Shipping (DHL Express)',
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
                              Text('FINAL AMOUNT', style: AppTextStyles.title.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
                              Text(
                                currencyNotifier.formatPrice(cartState.finalTotal),
                                style: AppTextStyles.headline.copyWith(fontSize: 22, color: AppColors.primaryContainer),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TOTAL PAYABLE', style: AppTextStyles.caption.copyWith(fontSize: 10)),
                        Text(currencyNotifier.formatPrice(cartState.finalTotal), style: AppTextStyles.headline.copyWith(fontSize: 20)),
                      ],
                    ),
                    const Spacer(),
                    PrimaryButton(
                      label: 'Place Order',
                      icon: Icons.check_circle_outline_rounded,
                      onPressed: () {
                        HapticFeedback.heavyImpact();
                        final order = ref.read(ordersProvider.notifier).placeOrder(
                          items: cartState.items,
                          totalAmount: cartState.finalTotal,
                          deliveryAddress: '742 Evergreen Terrace, Suite 4B, New York, NY 10001',
                          paymentMethod: _paymentMethods[_selectedPayment],
                        );
                        context.go('/checkout/confirmation/success?orderId=${Uri.encodeComponent(order.orderId)}');
                      },
                    ),
                  ],
                ),
              ),
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
