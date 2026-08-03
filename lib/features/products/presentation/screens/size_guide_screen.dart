import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class SizeGuideScreen extends StatelessWidget {
  const SizeGuideScreen({super.key});

  final List<Map<String, String>> _sizes = const [
    {'size': 'S', 'chest': '38 - 40 in', 'length': '28.5 in', 'fit': 'Relaxed'},
    {'size': 'M', 'chest': '41 - 43 in', 'length': '29.5 in', 'fit': 'Oversized Boxy'},
    {'size': 'L', 'chest': '44 - 46 in', 'length': '30.5 in', 'fit': 'Oversized Boxy'},
    {'size': 'XL', 'chest': '47 - 49 in', 'length': '31.5 in', 'fit': 'Heavy Oversized'},
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
                title: 'SIZE GUIDE',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('OVERSIZED HOODIE MEASUREMENTS', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: ListView.separated(
                  itemCount: _sizes.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final item = _sizes[index];
                    return GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: AppRadius.radiusSm,
                            ),
                            child: Text(
                              item['size']!,
                              style: AppTextStyles.title.copyWith(color: AppColors.onPrimaryContainer),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Chest: ${item['chest']}', style: AppTextStyles.body),
                              Text('Length: ${item['length']}', style: AppTextStyles.bodySmall),
                            ],
                          ),
                          Text(item['fit']!, style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer)),
                        ],
                      ),
                    ).animate().fadeIn(delay: (index * 80).ms);
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
