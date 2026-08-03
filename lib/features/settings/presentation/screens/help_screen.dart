import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

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
              TopHeader(
                title: 'HELP & SUPPORT',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildFaqItem('How do limited drops work?', 'Drops are released in strict limited quantities. Crew members receive early access notifications 15 minutes before public drops.'),
              const SizedBox(height: AppSpacing.sm),
              _buildFaqItem('What is your shipping policy?', 'Express worldwide shipping is included for all orders over \$200. Delivery typically takes 2-4 business days.'),
              const SizedBox(height: AppSpacing.sm),
              _buildFaqItem('How can I request a return?', 'Returns are accepted within 14 days of delivery for unworn items in original packaging with security tags intact.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question, style: AppTextStyles.title.copyWith(fontSize: 16)),
          const SizedBox(height: AppSpacing.xs),
          Text(answer, style: AppTextStyles.bodySmall),
        ],
      ),
    ).animate().fadeIn();
  }
}
