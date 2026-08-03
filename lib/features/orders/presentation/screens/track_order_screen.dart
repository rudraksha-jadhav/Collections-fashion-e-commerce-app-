import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  final List<Map<String, String>> _timeline = const [
    {'status': 'Order Placed', 'desc': 'Aug 03, 2026 — 14:32 PM', 'isDone': 'true'},
    {'status': 'Quality Inspection', 'desc': 'Aug 03, 2026 — 16:00 PM', 'isDone': 'true'},
    {'status': 'Out for Delivery (DHL Express)', 'desc': 'Expected Aug 05 by 18:00 PM', 'isDone': 'false'},
    {'status': 'Delivered', 'desc': 'Pending package arrival', 'isDone': 'false'},
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
                title: 'TRACK SHIPMENT',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    const Icon(Icons.local_shipping_outlined, color: AppColors.primary, size: 28),
                    const SizedBox(width: AppSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('TRACKING CODE', style: AppTextStyles.caption),
                        Text('DHL-9841029384', style: AppTextStyles.title.copyWith(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(),
              const SizedBox(height: AppSpacing.xl),
              Text('TIMELINE', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: ListView.separated(
                  itemCount: _timeline.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final item = _timeline[index];
                    final isDone = item['isDone'] == 'true';
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
                          color: isDone ? AppColors.primaryContainer : AppColors.outline,
                          size: 22,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: GlassCard(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            backgroundColor: isDone ? AppColors.surfaceContainerHigh : AppColors.glassBackground,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['status']!, style: AppTextStyles.title.copyWith(fontSize: 15)),
                                const SizedBox(height: 4),
                                Text(item['desc']!, style: AppTextStyles.bodySmall),
                              ],
                            ),
                          ),
                        ),
                      ],
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
