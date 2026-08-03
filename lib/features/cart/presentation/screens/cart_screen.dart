import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/collections_bottom_nav.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'title': 'Revival Hoodies',
      'price': 320.99,
      'size': 'M',
      'quantity': 1,
      'image': 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Solid Hoodies',
      'price': 290.00,
      'size': 'L',
      'quantity': 1,
      'image': 'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&q=80',
    },
  ];

  double get _totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: 180),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopHeader(
                    title: 'YOUR BAG',
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
                      itemCount: _cartItems.length,
                      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final item = _cartItems[index];
                        return GlassCard(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: AppRadius.radiusSm,
                                child: CachedNetworkImage(
                                  imageUrl: item['image'],
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['title'], style: AppTextStyles.title.copyWith(fontSize: 16)),
                                    const SizedBox(height: 2),
                                    Text('Size: ${item['size']}', style: AppTextStyles.bodySmall),
                                    const SizedBox(height: 6),
                                    Text('\$${item['price'].toStringAsFixed(2)}', style: AppTextStyles.headline.copyWith(fontSize: 16)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline, color: AppColors.outline, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        if (item['quantity'] > 1) {
                                          item['quantity']--;
                                        }
                                      });
                                    },
                                  ),
                                  Text('${item['quantity']}', style: AppTextStyles.title),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline, color: AppColors.primaryContainer, size: 20),
                                    onPressed: () {
                                      setState(() {
                                        item['quantity']++;
                                      });
                                    },
                                  ),
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
          Positioned(
            bottom: 80,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: GlassCard(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TOTAL', style: AppTextStyles.caption.copyWith(fontSize: 10)),
                      Text('\$${_totalPrice.toStringAsFixed(2)}', style: AppTextStyles.headline.copyWith(fontSize: 20)),
                    ],
                  ),
                  const Spacer(),
                  PrimaryButton(
                    label: 'Checkout',
                    icon: Icons.arrow_forward_rounded,
                    onPressed: () => context.push('/checkout'),
                  ),
                ],
              ),
            ),
          ),
          CollectionsBottomNav(
            currentIndex: 2,
            onTap: (index) {
              if (index == 0) context.go('/home');
              if (index == 1) context.go('/categories');
              if (index == 3) context.go('/settings');
            },
          ),
        ],
      ),
    );
  }
}
