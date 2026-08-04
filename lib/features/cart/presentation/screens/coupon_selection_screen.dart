import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';
import '../../../../core/widgets/notifications/glass_toast.dart';
import '../providers/cart_provider.dart';

class CouponSelectionScreen extends ConsumerWidget {
  const CouponSelectionScreen({super.key});

  final List<Map<String, String>> _coupons = const [
    {'code': 'COLLECTIONS20', 'discount': '20% OFF', 'desc': 'Valid on all streetwear drops above \$200'},
    {'code': 'LUXE100', 'discount': '\$100 OFF', 'desc': 'Exclusive Level 3 VIP member reward'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(
                title: 'COUPONS & PROMOS',
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
              Expanded(
                child: ListView.separated(
                  itemCount: _coupons.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final item = _coupons[index];
                    return GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['code']!, style: AppTextStyles.title.copyWith(fontSize: 18, color: AppColors.primaryContainer)),
                                Text(item['discount']!, style: AppTextStyles.headline.copyWith(fontSize: 16)),
                                const SizedBox(height: 4),
                                Text(item['desc']!, style: AppTextStyles.bodySmall),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          PrimaryButton(
                            label: 'Apply',
                            onPressed: () {
                              final success = ref.read(cartProvider.notifier).applyCouponCode(item['code']!);
                              if (success) {
                                GlassToast.show(
                                  context,
                                  message: 'Applied coupon ${item['code']}!',
                                  icon: Icons.local_offer_outlined,
                                );
                                context.pop();
                              }
                            },
                          ),
                        ],
                      ),
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
