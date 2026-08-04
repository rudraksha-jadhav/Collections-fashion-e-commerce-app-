import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../cards/glass_card.dart';

class GlassToast {
  static void show(
    BuildContext context, {
    required String message,
    IconData icon = Icons.check_circle_outline_rounded,
  }) {
    HapticFeedback.lightImpact();

    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).padding.top + 12,
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          child: Material(
            color: Colors.transparent,
            child: GlassCard(
              borderRadius: AppRadius.radiusFull,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
              backgroundColor: AppColors.surfaceContainerHigh.withValues(alpha: 0.95),
              borderColor: AppColors.primaryContainer.withValues(alpha: 0.3),
              child: Row(
                children: [
                  Icon(icon, color: AppColors.primaryContainer, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      message,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 250.ms).slideY(begin: -0.3, end: 0, curve: Curves.easeOutCubic),
          ),
        );
      },
    );

    overlay.insert(entry);

    Future.delayed(const Duration(milliseconds: 2200), () {
      entry.remove();
    });
  }
}
