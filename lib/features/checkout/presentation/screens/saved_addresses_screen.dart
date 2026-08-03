import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  final List<Map<String, String>> _addresses = const [
    {'title': 'Primary Residence', 'details': '742 Evergreen Terrace, Suite 4B\nNew York, NY 10001', 'isDefault': 'true'},
    {'title': 'Studio Office', 'details': '55 Broadway Penthouse\nNew York, NY 10006', 'isDefault': 'false'},
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
              TopHeader(
                title: 'SAVED ADDRESSES',
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
                  itemCount: _addresses.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final item = _addresses[index];
                    final isDefault = item['isDefault'] == 'true';
                    return GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item['title']!, style: AppTextStyles.title.copyWith(fontSize: 16)),
                              if (isDefault)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryContainer,
                                    borderRadius: AppRadius.radiusSm,
                                  ),
                                  child: Text(
                                    'DEFAULT',
                                    style: AppTextStyles.caption.copyWith(color: AppColors.onPrimaryContainer, fontSize: 10),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(item['details']!, style: AppTextStyles.bodySmall),
                        ],
                      ),
                    ).animate().fadeIn(delay: (index * 100).ms);
                  },
                ),
              ),
              PrimaryButton(
                label: 'Add New Address',
                icon: Icons.add_rounded,
                width: double.infinity,
                onPressed: () => context.push('/checkout/add-address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
