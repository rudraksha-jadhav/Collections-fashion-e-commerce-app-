import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = const [
    {
      'tag': 'COLLECTIONS — 01',
      'title': 'MORE THAN FASHION.\nIT\'S CULTURE.',
      'description': 'Discover drops, editorial stories, and luxury streetwear built for the new generation.',
      'image': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&q=80',
    },
    {
      'tag': 'COLLECTIONS — 02',
      'title': 'DISCOVER\nTHE DROP.',
      'description': 'Curated high-fashion releases, high-contrast imagery, and exclusive editorial spreads.',
      'image': 'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&q=80',
    },
    {
      'tag': 'COLLECTIONS — 03',
      'title': 'LIMITED\nEDITIONS.',
      'description': 'Unlock early access to high-demand street fashion capsules & VIP membership drops.',
      'image': 'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?auto=format&fit=crop&q=80',
    },
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.go('/login'),
                  child: Text(
                    'SKIP',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final item = _pages[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: AppRadius.radiusLg,
                            child: CachedNetworkImage(
                              imageUrl: item['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          item['tag']!,
                          style: AppTextStyles.caption.copyWith(fontSize: 11),
                        ).animate().fadeIn(),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          item['title']!,
                          style: GoogleFonts.libreCaslonText(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            height: 1.1,
                            color: AppColors.primary,
                          ),
                        ).animate().fadeIn().slideY(begin: 0.1),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          item['description']!,
                          style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant),
                        ).animate().fadeIn(),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              GlassCard(
                borderRadius: AppRadius.radiusFull,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(_pages.length, (index) {
                        final isSelected = index == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 6),
                          width: isSelected ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primaryContainer : AppColors.outlineVariant,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    PrimaryButton(
                      label: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                      icon: Icons.arrow_forward_rounded,
                      onPressed: _nextPage,
                    ),
                  ],
                ),
              ).animate().fadeIn(),
            ],
          ),
        ),
      ),
    );
  }
}
