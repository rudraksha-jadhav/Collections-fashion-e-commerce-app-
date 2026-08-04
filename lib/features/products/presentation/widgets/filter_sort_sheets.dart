import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/category_chip.dart';

class FilterSortSheets {
  static void showFilterSheet(BuildContext context) {
    String selectedCategory = 'All';
    double maxPrice = 500;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('FILTERS', style: AppTextStyles.caption.copyWith(fontSize: 14)),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.close_rounded, color: AppColors.primary, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('CATEGORY', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                  const SizedBox(height: AppSpacing.xs),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['All', 'Hoodies', 'T-Shirts', 'Outerwear', 'Sneakers'].map((cat) {
                      final isSelected = selectedCategory == cat;
                      return CategoryChip(
                        label: cat,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            selectedCategory = cat;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('MAX PRICE: \$${maxPrice.toInt()}', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                  Slider(
                    value: maxPrice,
                    min: 50,
                    max: 1000,
                    divisions: 19,
                    activeColor: AppColors.primaryContainer,
                    inactiveColor: AppColors.outlineVariant,
                    onChanged: (val) {
                      setState(() {
                        maxPrice = val;
                      });
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    label: 'Apply Filters',
                    width: double.infinity,
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Applied filters for $selectedCategory under \$${maxPrice.toInt()}')),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static void showSortSheet(BuildContext context) {
    String selectedSort = 'Latest Drop';
    final options = ['Latest Drop', 'Price: High to Low', 'Price: Low to High', 'Most Popular'];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SORT BY', style: AppTextStyles.caption.copyWith(fontSize: 14)),
                  const SizedBox(height: AppSpacing.md),
                  ...options.map((opt) {
                    final isSelected = selectedSort == opt;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GlassCard(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        onTap: () {
                          setState(() {
                            selectedSort = opt;
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Sorted items by $opt')),
                          );
                        },
                        child: Row(
                          children: [
                            Text(opt, style: AppTextStyles.title.copyWith(fontSize: 15)),
                            const Spacer(),
                            if (isSelected)
                              const Icon(Icons.check_circle_rounded, color: AppColors.primaryContainer, size: 20),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
