import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                title: 'SETTINGS',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildSettingTile(Icons.security_outlined, 'Account & Security', () => context.push('/settings/security')),
              const SizedBox(height: AppSpacing.sm),
              _buildSettingTile(Icons.language_outlined, 'Language & Region', () => context.push('/settings/language')),
              const SizedBox(height: AppSpacing.sm),
              _buildSettingTile(Icons.notifications_none_outlined, 'Push Notifications', () => context.push('/notifications')),
              const SizedBox(height: AppSpacing.sm),
              _buildSettingTile(Icons.lock_reset_outlined, 'Reset Password & OTP', () => context.push('/forgot-password')),
              const SizedBox(height: AppSpacing.sm),
              _buildSettingTile(Icons.help_outline_rounded, 'Help & Support', () => context.push('/help')),
              const SizedBox(height: AppSpacing.sm),
              _buildSettingTile(Icons.logout_rounded, 'Sign In / Switch Account', () => context.push('/login')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, VoidCallback onTap) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: AppSpacing.md),
          Text(title, style: AppTextStyles.body),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.outline, size: 16),
        ],
      ),
    ).animate().fadeIn();
  }
}
