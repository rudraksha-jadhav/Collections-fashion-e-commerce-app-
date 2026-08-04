import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  color: AppColors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 48,
                  color: AppColors.onPrimaryContainer,
                ),
              ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'ORDER CONFIRMED',
                style: AppTextStyles.displayLarge.copyWith(fontSize: 26),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Thank you for your purchase. Order #ORD-98421 has been placed successfully and is being prepared for express delivery.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall,
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: AppSpacing.xxl),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ESTIMATED DELIVERY', style: AppTextStyles.caption),
                    Text('Aug 05, 2026', style: AppTextStyles.title.copyWith(fontSize: 15)),
                  ],
                ),
              ).animate().fadeIn(delay: 400.ms),
              const Spacer(),
              PrimaryButton(
                label: 'Track Order Status',
                icon: Icons.local_shipping_outlined,
                width: double.infinity,
                onPressed: () => context.go('/orders/track'),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextButton(
                onPressed: () => context.go('/home'),
                child: Text('Return to Home →', style: AppTextStyles.bodySmall.copyWith(color: AppColors.outline)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
