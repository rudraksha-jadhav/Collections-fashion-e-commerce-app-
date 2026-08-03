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

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  final List<Map<String, String>> _orders = const [
    {
      'id': 'ORD-98421',
      'date': 'Aug 03, 2026',
      'items': 'Revival Hoodies (Size M)',
      'total': '\$320.99',
      'status': 'IN TRANSIT',
    },
    {
      'id': 'ORD-84102',
      'date': 'Jul 19, 2026',
      'items': 'Cyberpunk Denim Jacket',
      'total': '\$420.00',
      'status': 'DELIVERED',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopHeader(
                    title: 'MY ORDERS',
                    leading: GlassCard(
                      borderRadius: AppRadius.radiusFull,
                      padding: const EdgeInsets.all(AppSpacing.sm + 2),
                      onTap: () => context.pop(),
                      child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _orders.length,
                      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final order = _orders[index];
                        return GlassCard(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          onTap: () => context.push('/orders/track'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(order['id']!, style: AppTextStyles.title.copyWith(fontSize: 16)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryContainer.withValues(alpha: 0.2),
                                      borderRadius: AppRadius.radiusFull,
                                    ),
                                    child: Text(
                                      order['status']!,
                                      style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(order['date']!, style: AppTextStyles.bodySmall),
                              const Divider(color: AppColors.outlineVariant, height: 20),
                              Text(order['items']!, style: AppTextStyles.body),
                              const SizedBox(height: AppSpacing.sm),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Tap to Track Shipment →', style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer)),
                                  Text(order['total']!, style: AppTextStyles.headline.copyWith(fontSize: 18)),
                                ],
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
}
