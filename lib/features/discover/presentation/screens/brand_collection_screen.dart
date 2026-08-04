import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class BrandCollectionScreen extends StatelessWidget {
  const BrandCollectionScreen({super.key});

  final List<Map<String, String>> _brandProducts = const [
    {
      'title': 'Tokyo Cyber Overcoat',
      'price': '\$520.00',
      'image': 'https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Neon Matrix Hoodie',
      'price': '\$340.00',
      'image': 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
    },
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
                title: 'BRAND CAPSULE',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('HYPEOS LABS x TOKYO', style: AppTextStyles.displayLarge.copyWith(fontSize: 24)),
              const SizedBox(height: 4),
              Text('Official limited drop collab with Tokyo Streetwear Guild.', style: AppTextStyles.bodySmall),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.lg,
                  ),
                  itemCount: _brandProducts.length,
                  itemBuilder: (context, index) {
                    final item = _brandProducts[index];
                    return ProductCard(
                      title: item['title']!,
                      price: item['price']!,
                      imageUrl: item['image']!,
                      onTap: () => context.push('/product-details', extra: item),
                    ).animate().fadeIn(delay: (index * 100).ms);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
