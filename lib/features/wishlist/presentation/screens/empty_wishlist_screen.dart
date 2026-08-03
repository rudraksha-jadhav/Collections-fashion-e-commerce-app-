import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class EmptyWishlistScreen extends StatelessWidget {
  const EmptyWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Column(
            children: [
              TopHeader(
                title: 'WISHLIST',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const Spacer(),
              const Icon(Icons.favorite_border_rounded, size: 72, color: AppColors.outline),
              const SizedBox(height: AppSpacing.lg),
              Text('YOUR WISHLIST IS EMPTY', style: AppTextStyles.displayLarge.copyWith(fontSize: 22)),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Explore upcoming limited drops and tap the heart icon to save your favorites.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: 'Explore Drops',
                onPressed: () => context.go('/home'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
