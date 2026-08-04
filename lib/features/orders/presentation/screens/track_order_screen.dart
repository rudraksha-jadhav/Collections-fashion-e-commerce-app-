import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../providers/orders_provider.dart';

class TrackOrderScreen extends ConsumerWidget {
  final String? orderId;

  const TrackOrderScreen({super.key, this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(ordersProvider);
    final targetOrderId = orderId ?? (orders.isNotEmpty ? orders.first.orderId : '#ORD-98421');
    final activeOrder = orders.firstWhere(
      (o) => o.orderId == targetOrderId,
      orElse: () => orders.first,
    );

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

              // Order Summary Card
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.local_shipping_outlined, color: AppColors.primaryContainer, size: 24),
                            const SizedBox(width: AppSpacing.sm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ORDER ID', style: AppTextStyles.caption.copyWith(fontSize: 10)),
                                Text(activeOrder.orderId, style: AppTextStyles.title.copyWith(fontSize: 16)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer.withValues(alpha: 0.2),
                              borderRadius: AppRadius.radiusFull,
                            ),
                            child: Text(
                              activeOrder.status.toUpperCase(),
                              style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: AppColors.outlineVariant, height: 24),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: AppColors.outline, size: 18),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            activeOrder.deliveryAddress,
                            style: AppTextStyles.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(),

              const SizedBox(height: AppSpacing.xl),
              Text('LIVE TRACKING TIMELINE', style: AppTextStyles.caption.copyWith(fontSize: 11, letterSpacing: 1.5)),
              const SizedBox(height: AppSpacing.md),

              // Timeline Stepper
              Expanded(
                child: ListView.separated(
                  itemCount: activeOrder.trackingSteps.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final step = activeOrder.trackingSteps[index];
                    final isCompleted = step.isCompleted;
                    final isCurrent = step.isCurrent;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Icon(
                              isCompleted
                                  ? Icons.check_circle_rounded
                                  : isCurrent
                                      ? Icons.local_shipping_rounded
                                      : Icons.radio_button_unchecked_rounded,
                              color: isCompleted || isCurrent ? AppColors.primaryContainer : AppColors.outline,
                              size: 22,
                            ),
                            if (index < activeOrder.trackingSteps.length - 1)
                              Container(
                                width: 2,
                                height: 36,
                                color: isCompleted ? AppColors.primaryContainer : AppColors.outlineVariant,
                              ),
                          ],
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: GlassCard(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            backgroundColor: isCurrent
                                ? AppColors.surfaceContainerHigh
                                : isCompleted
                                    ? AppColors.glassBackground
                                    : AppColors.background,
                            borderColor: isCurrent ? AppColors.primaryContainer : AppColors.outlineVariant,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        step.title,
                                        style: AppTextStyles.title.copyWith(
                                          fontSize: 15,
                                          color: isCurrent ? AppColors.primaryContainer : AppColors.primary,
                                        ),
                                      ),
                                    ),
                                    if (isCurrent)
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: AppColors.primaryContainer,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(step.description, style: AppTextStyles.bodySmall),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: (index * 100).ms);
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Simulation Action Button
              PrimaryButton(
                label: activeOrder.status == 'Delivered' ? 'Package Delivered ✓' : 'Advance Delivery Stage 🚚',
                icon: Icons.fast_forward_rounded,
                width: double.infinity,
                onPressed: () {
                  if (activeOrder.status == 'Delivered') return;
                  HapticFeedback.mediumImpact();
                  ref.read(ordersProvider.notifier).advanceTrackingStatus(activeOrder.orderId);
                  GlassToast.show(
                    context,
                    message: 'Delivery stage updated for ${activeOrder.orderId}',
                    icon: Icons.local_shipping_outlined,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
