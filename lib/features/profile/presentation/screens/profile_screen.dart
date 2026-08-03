import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(
                title: 'MEMBERSHIP HUB',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryContainer, width: 2),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rudraksha Jadhav', style: AppTextStyles.title.copyWith(fontSize: 18)),
                          const SizedBox(height: 2),
                          Text('Level 3 VIP Member', style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer)),
                          const SizedBox(height: 4),
                          Text('rudraksha@example.com', style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(),
              const SizedBox(height: AppSpacing.xl),
              Text('MY ORDERS & DROPS', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.xs),
              _buildMenuItem(
                icon: Icons.local_shipping_outlined,
                title: 'Your Order History',
                subtitle: 'Track active drops & past shipments',
                onTap: () => context.push('/orders'),
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildMenuItem(
                icon: Icons.favorite_border_rounded,
                title: 'Saved Wishlist',
                subtitle: 'View saved street items & capsules',
                onTap: () => context.push('/wishlist'),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('PREFERENCES & SECURITY', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.xs),
              _buildMenuItem(
                icon: Icons.person_outline_rounded,
                title: 'Edit Profile Information',
                subtitle: 'Update name, avatar & email',
                onTap: () => context.push('/profile/edit'),
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildMenuItem(
                icon: Icons.settings_outlined,
                title: 'App Settings & Security',
                subtitle: '2FA, Biometrics, Language & Region',
                onTap: () => context.push('/settings'),
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildMenuItem(
                icon: Icons.help_outline_rounded,
                title: 'Concierge Help & Support',
                subtitle: '24/7 Priority support channel',
                onTap: () => context.push('/help'),
              ),
              const SizedBox(height: AppSpacing.xxl),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                onTap: () => context.go('/login'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.logout_rounded, color: AppColors.error, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Sign Out Account', style: AppTextStyles.buttonText.copyWith(color: AppColors.error)),
                  ],
                ),
              ).animate().fadeIn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.title.copyWith(fontSize: 15)),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.bodySmall),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.outline, size: 16),
        ],
      ),
    ).animate().fadeIn();
  }
}
