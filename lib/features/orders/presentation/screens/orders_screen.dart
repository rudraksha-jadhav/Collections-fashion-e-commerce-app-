import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';
import '../../../settings/presentation/providers/currency_provider.dart';
import '../providers/orders_provider.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);
    final currencyNotifier = ref.watch(currencyProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
                child: orders.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.inventory_2_outlined, size: 64, color: AppColors.outline),
                            const SizedBox(height: AppSpacing.md),
                            Text('NO ORDERS PLACED YET', style: AppTextStyles.title),
                            const SizedBox(height: AppSpacing.xs),
                            Text('Explore curated drops and place your first order', style: AppTextStyles.bodySmall),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: orders.length,
                        separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          final itemNames = order.items.map((i) => '${i.title} (${i.size}) x${i.quantity}').join(', ');

                          return GlassCard(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            onTap: () => context.push('/orders/track?orderId=${Uri.encodeComponent(order.orderId)}'),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(order.orderId, style: AppTextStyles.title.copyWith(fontSize: 16)),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryContainer.withValues(alpha: 0.2),
                                        borderRadius: AppRadius.radiusFull,
                                      ),
                                      child: Text(
                                        order.status.toUpperCase(),
                                        style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer, fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(order.date, style: AppTextStyles.bodySmall),
                                const Divider(color: AppColors.outlineVariant, height: 20),
                                Text(itemNames, style: AppTextStyles.body),
                                const SizedBox(height: AppSpacing.sm),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Tap to Track Shipment →', style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer)),
                                    Text(currencyNotifier.formatPrice(order.totalAmount), style: AppTextStyles.headline.copyWith(fontSize: 18)),
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
    );
  }
}
