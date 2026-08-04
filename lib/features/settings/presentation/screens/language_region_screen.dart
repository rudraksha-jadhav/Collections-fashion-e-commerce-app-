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
import '../../../../core/widgets/notifications/glass_toast.dart';
import '../providers/currency_provider.dart';

class LanguageRegionScreen extends ConsumerStatefulWidget {
  const LanguageRegionScreen({super.key});

  @override
  ConsumerState<LanguageRegionScreen> createState() => _LanguageRegionScreenState();
}

class _LanguageRegionScreenState extends ConsumerState<LanguageRegionScreen> {
  String _selectedLang = 'English (US)';

  final List<String> _languages = ['English (US)', 'English (UK)', 'Japanese (日本語)', 'French (Français)', 'German (Deutsch)'];

  @override
  Widget build(BuildContext context) {
    final activeCurrency = ref.watch(currencyProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(
                title: 'CURRENCY & REGION',
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

              Text('SELECT CURRENCY', style: AppTextStyles.caption.copyWith(fontSize: 11)),
              const SizedBox(height: AppSpacing.sm),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: availableCurrencies.map((c) {
                    final isSelected = c.code == activeCurrency.code;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: GlassCard(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        backgroundColor: isSelected ? AppColors.surfaceContainerHigh : AppColors.glassBackground,
                        borderColor: isSelected ? AppColors.primaryContainer : AppColors.outlineVariant,
                        onTap: () {
                          ref.read(currencyProvider.notifier).setCurrency(c);
                          GlassToast.show(
                            context,
                            message: 'Currency updated to ${c.code} (${c.symbol})',
                            icon: Icons.monetization_on_outlined,
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              '${c.symbol} ${c.code}',
                              style: AppTextStyles.body.copyWith(
                                color: isSelected ? AppColors.primaryContainer : AppColors.primary,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
              Text('LANGUAGE PREFERENCE', style: AppTextStyles.caption.copyWith(fontSize: 11)),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: ListView.separated(
                  itemCount: _languages.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final lang = _languages[index];
                    final isSelected = lang == _selectedLang;
                    return GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      backgroundColor: isSelected ? AppColors.surfaceContainerHigh : AppColors.glassBackground,
                      onTap: () {
                        setState(() {
                          _selectedLang = lang;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(lang, style: AppTextStyles.body.copyWith(color: AppColors.primary)),
                          if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.primaryContainer, size: 20),
                        ],
                      ),
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
