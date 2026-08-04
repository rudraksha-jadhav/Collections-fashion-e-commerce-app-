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
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/collections_bottom_nav.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  final List<Map<String, String>> _brandCollections = const [
    {
      'name': 'OBSIDIAN NEON',
      'tagline': 'CYBERPUNK STREETWEAR',
      'image': 'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&q=80',
    },
    {
      'name': 'TOKYO DRIFT',
      'tagline': 'JAPANESE OVERSIZED CUTS',
      'image': 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?auto=format&fit=crop&q=80',
    },
  ];

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
                    title: 'DISCOVER',
                    leading: GlassCard(
                      borderRadius: AppRadius.radiusFull,
                      padding: const EdgeInsets.all(AppSpacing.sm + 2),
                      onTap: () => context.push('/search'),
                      child: const Icon(Icons.search_rounded, size: 20, color: AppColors.primary),
                    ),
                    trailing: GlassCard(
                      borderRadius: AppRadius.radiusFull,
                      padding: const EdgeInsets.all(AppSpacing.sm + 2),
                      onTap: () => context.push('/categories'),
                      child: const Icon(Icons.grid_view_rounded, size: 20, color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('EDITORIAL STORIES', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                      GestureDetector(
                        onTap: () => context.push('/discover/stories'),
                        child: Text('View All →', style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer)),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  GestureDetector(
                    onTap: () => context.push('/discover/story/detail'),
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: AppRadius.radiusLg,
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&q=80'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: AppRadius.radiusLg,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.background.withValues(alpha: 0.9),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'THE NEON NOIR MANIFESTO',
                              style: GoogleFonts.libreCaslonText(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: AppColors.primary,
                              ),
                            ),
                            Text('Read Editorial Feature →', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryContainer)),
                          ],
                        ),
                      ),
                    ),
                  ).animate().fadeIn(),
                  const SizedBox(height: AppSpacing.xl),
                  Text('FEATURED BRAND DROPS', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                  const SizedBox(height: AppSpacing.sm),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _brandCollections.length,
                    separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final item = _brandCollections[index];
                      return GestureDetector(
                        onTap: () => context.push('/discover/brand'),
                        child: GlassCard(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: AppRadius.radiusSm,
                                child: CachedNetworkImage(
                                  imageUrl: item['image']!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['name']!, style: AppTextStyles.title.copyWith(fontSize: 16)),
                                    Text(item['tagline']!, style: AppTextStyles.bodySmall),
                                  ],
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.outline, size: 16),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: (index * 100).ms);
                    },
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('TRENDING CAPSULES', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                  const SizedBox(height: AppSpacing.sm),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                    ),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        title: index == 0 ? 'Revival Hoodie' : 'Tokyo Oversized Tee',
                        price: index == 0 ? '\$320.99' : '\$180.00',
                        imageUrl: index == 0
                            ? 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80'
                            : 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80',
                        onTap: () => context.push('/product-details'),
                      ).animate().fadeIn();
                    },
                  ),
                ],
              ),
            ),
          ),
          CollectionsBottomNav(
            currentIndex: 1,
            onTap: (index) {
              if (index == 0) context.go('/home');
              if (index == 1) context.go('/discover');
              if (index == 2) context.go('/cart');
              if (index == 3) context.go('/settings');
            },
          ),
        ],
      ),
    );
  }
}
