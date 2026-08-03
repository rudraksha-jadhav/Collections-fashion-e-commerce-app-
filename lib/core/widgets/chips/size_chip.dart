import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../cards/glass_card.dart';

class SizeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SizeChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        borderRadius: AppRadius.radiusSm,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm + 4,
        ),
        backgroundColor: isSelected ? AppColors.primaryContainer : AppColors.glassBackground,
        child: Text(
          label,
          style: AppTextStyles.buttonText.copyWith(
            color: isSelected ? AppColors.onPrimaryContainer : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
