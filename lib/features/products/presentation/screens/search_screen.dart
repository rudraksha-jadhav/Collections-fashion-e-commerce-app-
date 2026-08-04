import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/inputs/search_field.dart';
import '../../../../core/widgets/notifications/glass_toast.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../widgets/filter_sort_sheets.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  final List<Map<String, String>> _recentSearches = [
    {'term': 'Heavyweight Hoodie'},
    {'term': 'Vintage Wash Jeans'},
    {'term': 'Oversized Tee'},
  ];

  final List<Map<String, String>> _allProducts = [
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
      'title': 'Acid Wash Tee',
      'price': '\$180.00',
      'numPrice': '180.00',
      'image': 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80',
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
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.trim().toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _allProducts.where((p) {
      if (_query.isEmpty) return true;
      return p['title']!.toLowerCase().contains(_query);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GlassCard(
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
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: SearchField(
                      controller: _searchController,
                      hintText: 'Search drops, categories...',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  GlassCard(
                    borderRadius: AppRadius.radiusFull,
                    padding: const EdgeInsets.all(AppSpacing.sm + 2),
                    onTap: () => FilterSortSheets.showFilterSheet(context),
                    child: const Icon(Icons.tune_rounded, size: 20, color: AppColors.primary),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  GlassCard(
                    borderRadius: AppRadius.radiusFull,
                    padding: const EdgeInsets.all(AppSpacing.sm + 2),
                    onTap: () => FilterSortSheets.showSortSheet(context),
                    child: const Icon(Icons.sort_rounded, size: 20, color: AppColors.primary),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (_query.isEmpty) ...[
                Text('RECENT SEARCHES', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: 8,
                  children: _recentSearches.map((item) {
                    return ActionChip(
                      backgroundColor: AppColors.surfaceContainerHigh,
                      label: Text(item['term']!, style: AppTextStyles.bodySmall),
                      onPressed: () {
                        _searchController.text = item['term']!;
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _query.isEmpty ? 'TRENDING DROPS' : 'SEARCH RESULTS (${filteredProducts.length})',
                    style: AppTextStyles.caption.copyWith(fontSize: 11),
                  ),
                  GestureDetector(
                    onTap: () => FilterSortSheets.showSortSheet(context),
                    child: Text('Sort →', style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: filteredProducts.isEmpty
                    ? Center(
                        child: Text(
                          'No products found matching "$_query"',
                          style: AppTextStyles.bodySmall,
                        ),
                      )
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.62,
                          crossAxisSpacing: AppSpacing.md,
                          mainAxisSpacing: AppSpacing.md,
                        ),
                        itemCount: filteredProducts.length,
                        itemBuilder: (context, index) {
                          final item = filteredProducts[index];
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
