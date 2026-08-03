import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/cards/glass_card.dart';

class FullscreenProductImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullscreenProductImageViewer({
    super.key,
    this.imageUrl = 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: GlassCard(
                borderRadius: AppRadius.radiusFull,
                padding: const EdgeInsets.all(AppSpacing.sm + 2),
                onTap: () => context.pop(),
                child: const Icon(Icons.close_rounded, size: 22, color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
