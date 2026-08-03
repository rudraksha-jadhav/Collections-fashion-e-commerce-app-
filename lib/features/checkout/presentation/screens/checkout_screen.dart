import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPayment = 0;
  final List<String> _paymentMethods = ['Apple Pay', 'Credit Card (•••• 9841)', 'Google Pay'];

  @override
  Widget build(BuildContext context) {
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
                    onTap: () => context.pop(),
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
                    GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      onTap: () => context.push('/cart/coupons'),
                      child: Row(
                        children: [
                          const Icon(Icons.local_offer_outlined, color: AppColors.primaryContainer),
                          const SizedBox(width: AppSpacing.sm),
                          Text('Apply Promo Code / Coupon', style: AppTextStyles.body),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.outline, size: 16),
                        ],
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                  ],
                ),
              ),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Amount', style: AppTextStyles.bodySmall),
                        Text('\$610.99', style: AppTextStyles.displayLarge.copyWith(fontSize: 22)),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    PrimaryButton(
                      label: 'Pay & Confirm Order',
                      icon: Icons.check_circle_outline_rounded,
                      width: double.infinity,
                      onPressed: () => context.go('/checkout/confirmation/success'),
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
}
