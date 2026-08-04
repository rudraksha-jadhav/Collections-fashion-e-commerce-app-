import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/collections_bottom_nav.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopHeader(
                    title: 'SETTINGS',
                    leading: GlassCard(
                      borderRadius: AppRadius.radiusFull,
                      padding: const EdgeInsets.all(AppSpacing.sm + 2),
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/home');
                        }
                      },
                      child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSettingTile(Icons.security_outlined, 'Account & Security', () => context.push('/settings/security')),
                  const SizedBox(height: AppSpacing.sm),
                  _buildSettingTile(Icons.language_outlined, 'Language & Region', () => context.push('/settings/language-region')),
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
          CollectionsBottomNav(
            currentIndex: 3,
            onTap: (index) {
              if (index == 0) context.go('/home');
              if (index == 1) context.go('/discover');
              if (index == 2) context.go('/cart');
            },
          ),
        ],
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
          Text(title, style: AppTextStyles.title.copyWith(fontSize: 15)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.outline, size: 16),
        ],
      ),
    ).animate().fadeIn();
  }
}
