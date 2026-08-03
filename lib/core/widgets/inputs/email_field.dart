import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../cards/glass_card.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const EmailField({
    super.key,
    required this.controller,
    this.hintText = 'Email Address',
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: AppTextStyles.body.copyWith(color: AppColors.primary),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.outline),
          border: InputBorder.none,
          icon: const Icon(Icons.email_outlined, color: AppColors.outline),
        ),
      ),
    );
  }
}
