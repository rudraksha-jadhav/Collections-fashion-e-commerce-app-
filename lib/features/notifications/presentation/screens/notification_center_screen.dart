import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';
import '../../../../core/widgets/notifications/glass_toast.dart';

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({super.key});

  @override
  State<NotificationCenterScreen> createState() => _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': '🔥 DROP ALERT: Tokyo Nights Capsule',
      'body': 'Exclusive early drop is live now! Limited to 250 pieces worldwide.',
      'time': '10m ago',
      'isUnread': true,
      'route': '/discover',
    },
    {
      'title': '📦 Order #ORD-98421 Shipped',
      'body': 'Your Revival Hoodie has been dispatched via DHL Express.',
      'time': '2h ago',
      'isUnread': true,
      'route': '/orders/track',
    },
    {
      'title': '⚡ Level 3 Hype Status Unlocked',
      'body': 'Congratulations! You unlocked priority secret drop access.',
      'time': '1d ago',
      'isUnread': false,
      'route': '/profile',
    },
  ];

  int get _unreadCount => _notifications.where((n) => n['isUnread'] == true).length;

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
                title: 'NOTIFICATIONS',
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
                trailing: _unreadCount > 0
                    ? GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            for (var n in _notifications) {
                              n['isUnread'] = false;
                            }
                          });
                          GlassToast.show(
                            context,
                            message: 'All notifications marked as read',
                            icon: Icons.done_all_rounded,
                          );
                        },
                        child: Text(
                          'Mark all read',
                          style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer),
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView.separated(
                  itemCount: _notifications.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final item = _notifications[index];
                    final isUnread = item['isUnread'] == true;

                    return GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      backgroundColor: isUnread ? AppColors.surfaceContainerHigh.withValues(alpha: 0.8) : AppColors.glassBackground,
                      onTap: () {
                        setState(() {
                          item['isUnread'] = false;
                        });
                        context.push(item['route']);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    if (isUnread) ...[
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: AppColors.primaryContainer,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                    Expanded(
                                      child: Text(
                                        item['title']!,
                                        style: AppTextStyles.title.copyWith(
                                          fontSize: 15,
                                          fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(item['time']!, style: AppTextStyles.caption.copyWith(fontSize: 10)),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(item['body']!, style: AppTextStyles.bodySmall),
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
