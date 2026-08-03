import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class SavedPaymentMethodsScreen extends StatelessWidget {
  const SavedPaymentMethodsScreen({super.key});

  final List<Map<String, String>> _methods = const [
    {'title': 'Apple Pay', 'desc': 'Default quick pay method', 'icon': 'apple'},
    {'title': 'Mastercard ending in 9841', 'desc': 'Expires 08/29', 'icon': 'card'},
    {'title': 'Google Pay', 'desc': 'Connected via Google Account', 'icon': 'google'},
  ];

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
                title: 'PAYMENT METHODS',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView.separated(
                  itemCount: _methods.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final item = _methods[index];
                    return GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          const Icon(Icons.credit_card_rounded, color: AppColors.primaryContainer, size: 24),
                          const SizedBox(width: AppSpacing.md),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['title']!, style: AppTextStyles.title.copyWith(fontSize: 15)),
                              Text(item['desc']!, style: AppTextStyles.bodySmall),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.check_circle_rounded, color: AppColors.primaryContainer, size: 20),
                        ],
                      ),
                    ).animate().fadeIn(delay: (index * 100).ms);
                  },
                ),
              ),
              PrimaryButton(
                label: 'Add Payment Card',
                icon: Icons.add_rounded,
                width: double.infinity,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment card scanner opened!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
