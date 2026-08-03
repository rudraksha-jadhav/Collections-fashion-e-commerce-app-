import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/cards/product_card.dart';
import '../../../../core/widgets/inputs/search_field.dart';

import '../widgets/filter_sort_sheets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  final List<Map<String, String>> _recentSearches = [
    {'term': 'Heavyweight Hoodie'},
    {'term': 'Vintage Wash Jeans'},
    {'term': 'Oversized Tee'},
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
              Row(
                children: [
                  GlassCard(
                    borderRadius: AppRadius.radiusFull,
                    padding: const EdgeInsets.all(AppSpacing.sm + 2),
                    onTap: () => context.pop(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('TRENDING DROPS', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                  GestureDetector(
                    onTap: () => FilterSortSheets.showSortSheet(context),
                    child: Text('Sort →', style: AppTextStyles.caption.copyWith(color: AppColors.primaryContainer)),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.62,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      title: index == 0 ? 'Revival Hoodie' : 'Acid Wash Tee',
                      price: '\$${(180 + index * 45).toStringAsFixed(2)}',
                      imageUrl: index % 2 == 0
                          ? 'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?auto=format&fit=crop&q=80'
                          : 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80',
                      onTap: () => context.push('/product-details'),
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
