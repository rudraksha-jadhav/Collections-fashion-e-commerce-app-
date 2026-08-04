import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/category_chip.dart';
import '../../../../core/widgets/collections_bottom_nav.dart';
import '../../../../core/widgets/navigation/section_title.dart';
import '../../../../core/widgets/navigation/top_header.dart';
import '../../../../core/widgets/notifications/glass_toast.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['All', 'T-shirt', 'Hoodies', 'Jeans', 'Sweaters'];

  final List<Map<String, String>> _products = [
    {
      'title': 'Revival Hoodies',
      'price': '\$320.99',
      'numPrice': '320.99',
      'image': 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Solid Hoodies',
      'price': '\$290.00',
      'numPrice': '290.00',
      'image': 'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Neon Puffer Jacket',
      'price': '\$450.00',
      'numPrice': '450.00',
      'image': 'https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&q=80',
    },
    {
      'title': 'Skull Graphic Hoodie',
      'price': '\$310.50',
      'numPrice': '310.50',
      'image': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cartCount = ref.watch(cartCountProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
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
                      return ProductCard(
                        title: item['title']!,
                        price: item['price']!,
                        imageUrl: item['image']!,
                        onTap: () => context.push('/product-details'),
                        onAddToCart: () {
                          ref.read(cartProvider.notifier).addItem(
                                title: item['title']!,
                                price: double.parse(item['numPrice']!),
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
          CollectionsBottomNav(
            currentIndex: 0,
            cartItemCount: cartCount,
            onTap: (index) {
              if (index == 1) context.go('/discover');
              if (index == 2) context.go('/cart');
              if (index == 3) context.go('/settings');
            },
          ),
        ],
      ),
    );
  }
}
