import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/app_text_styles.dart';
import '../buttons/primary_button.dart';
import '../notifications/glass_toast.dart';

class BiometricAuthSheet {
  static void show(
    BuildContext context, {
    required VoidCallback onSuccess,
  }) {
    HapticFeedback.mediumImpact();
    bool isAuthenticating = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surfaceContainerHigh,
                      border: Border.all(color: AppColors.primaryContainer.withValues(alpha: 0.4), width: 1.5),
                    ),
                    child: Icon(
                      isAuthenticating ? Icons.lock_clock_rounded : Icons.fingerprint_rounded,
                      color: AppColors.primaryContainer,
                      size: 40,
                    ),
                  ).animate().scale(begin: const Offset(0.9, 0.9)),
                  const SizedBox(height: AppSpacing.md),
                  Text('BIOMETRIC SECURITY', style: AppTextStyles.caption.copyWith(fontSize: 12, letterSpacing: 2.0)),
                  const SizedBox(height: 4),
                  Text(
                    'Touch Fingerprint Sensor to Verify',
                    style: AppTextStyles.headline.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Confirming identity for high-security access & drops',
                    style: AppTextStyles.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  PrimaryButton(
                    label: isAuthenticating ? 'Verifying...' : 'Verify Biometrics',
                    isLoading: isAuthenticating,
                    width: double.infinity,
                    onPressed: () async {
                      HapticFeedback.selectionClick();
                      setState(() {
                        isAuthenticating = true;
                      });

                      await Future.delayed(const Duration(milliseconds: 1200));

                      if (context.mounted) {
                        Navigator.pop(context);
                        HapticFeedback.lightImpact();
                        GlassToast.show(
                          context,
                          message: 'Biometric Authentication Successful!',
                          icon: Icons.verified_user_outlined,
                        );
                        onSuccess();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
