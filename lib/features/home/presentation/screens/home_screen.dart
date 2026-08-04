import 'dart:async';
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
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/category_chip.dart';
import '../../../../core/widgets/navigation/section_title.dart';
import '../../../../core/widgets/navigation/top_header.dart';
import '../../../../core/widgets/notifications/glass_toast.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../settings/presentation/providers/currency_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All', 'T-shirt', 'Hoodies', 'Jeans', 'Sweaters'];

  late Timer _timer;
  int _secondsRemaining = 8085; // 02h 14m 45s
  bool _hasReserved = false;

  final List<Map<String, dynamic>> _products = [
    {
      'title': 'Revival Hoodies',
      'numPrice': 320.99,
      'image': 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Solid Hoodies',
      'numPrice': 290.00,
      'image': 'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Neon Puffer Jacket',
      'numPrice': 450.00,
      'image': 'https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Skull Graphic Hoodie',
      'numPrice': 310.50,
      'image': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&q=80',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatCountdown() {
    final hours = (_secondsRemaining ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_secondsRemaining % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '${hours}h : ${minutes}m : ${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    final currencyNotifier = ref.watch(currencyProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(
                title: 'COLLECTIONS',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.push('/categories'),
                  child: const Icon(Icons.grid_view_rounded, size: 20, color: AppColors.primary),
                ),
                trailing: GestureDetector(
                  onTap: () => context.push('/profile'),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.outlineVariant),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // VIP Drop Countdown Banner
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, color: AppColors.primaryContainer, size: 20),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            'VIP DROP #04',
                            style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer.withValues(alpha: 0.2),
                            borderRadius: AppRadius.radiusFull,
                          ),
                          child: Text(
                            _formatCountdown(),
                            style: AppTextStyles.caption.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Acid Wash Collection Drop',
                      style: AppTextStyles.headline.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Limited to 500 numbered pieces worldwide. Early reservation pass unlocks 30min prior access.',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    PrimaryButton(
                      label: _hasReserved ? 'VIP Pass Reserved ✓' : 'Reserve Access Pass',
                      icon: _hasReserved ? Icons.check_circle_rounded : Icons.confirmation_number_outlined,
                      width: double.infinity,
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        setState(() {
                          _hasReserved = !_hasReserved;
                        });
                        GlassToast.show(
                          context,
                          message: _hasReserved ? 'VIP Access Pass #142 Reserved!' : 'Reservation cancelled',
                          icon: Icons.confirmation_number_outlined,
                        );
                      },
                    ),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: 0.05),

              const SizedBox(height: AppSpacing.lg),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_categories.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: CategoryChip(
                        label: _categories[index],
                        isSelected: _selectedCategoryIndex == index,
                        onTap: () {
                          setState(() {
                            _selectedCategoryIndex = index;
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              const SectionTitle(
                tag: 'CURATED DROPS',
              ),
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
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final item = _products[index];
                  final formattedPrice = currencyNotifier.formatPrice(item['numPrice']);
                  return ProductCard(
                    title: item['title']!,
                    price: formattedPrice,
                    imageUrl: item['image']!,
                    onTap: () => context.push('/product-details'),
                    onAddToCart: () {
                      ref.read(cartProvider.notifier).addItem(
                            title: item['title']!,
                            price: item['numPrice'],
                            image: item['image']!,
                          );
                      GlassToast.show(
                        context,
                        message: 'Added ${item['title']} to Bag!',
                        icon: Icons.shopping_bag_outlined,
                      );
                    },
                  ).animate().fadeIn(delay: (index * 80).ms);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
