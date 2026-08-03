import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';

class FashionStoryDetailScreen extends StatelessWidget {
  const FashionStoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 480,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: 'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&q=80',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                        child: GlassCard(
                          borderRadius: AppRadius.radiusFull,
                          padding: const EdgeInsets.all(AppSpacing.sm + 2),
                          onTap: () => context.pop(),
                          child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EDITORIAL FEATURE', style: AppTextStyles.caption),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'THE NEON NOIR MANIFESTO',
                        style: GoogleFonts.libreCaslonText(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: AppColors.primary,
                        ),
                      ).animate().fadeIn().slideY(begin: 0.1),
                      const SizedBox(height: AppSpacing.sm),
                      Text('By Editorial Guild — Aug 02, 2026', style: AppTextStyles.bodySmall),
                      const Divider(color: AppColors.outlineVariant, height: 32),
                      Text(
                        'Luxury streetwear is no longer defined by traditional heritage ateliers alone. The convergence of cyberpunk aesthetics, heavy organic cotton fabrics, and dark glassmorphic UI represents a new era in global fashion.',
                        style: AppTextStyles.body.copyWith(fontSize: 16, height: 1.6),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Limited release drops ensure every garment carries true scarcity and cultural value.',
                        style: AppTextStyles.body.copyWith(fontSize: 16, height: 1.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
