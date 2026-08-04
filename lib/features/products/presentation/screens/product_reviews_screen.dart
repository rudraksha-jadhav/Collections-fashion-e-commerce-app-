import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/navigation/top_header.dart';
import '../../../../core/widgets/notifications/glass_toast.dart';

class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key});

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  final List<Map<String, String>> _reviews = [
    {'name': 'Marcus Vance', 'rating': '5.0', 'comment': 'Heavyweight 480GSM cotton feels insanely premium. Vintage wash is spot on.', 'date': '2 days ago', 'verified': 'true'},
    {'name': 'Aria Sterling', 'rating': '5.0', 'comment': 'Boxy fit is perfect. Quickest shipping ever via DHL.', 'date': '1 week ago', 'verified': 'true'},
    {'name': 'Julian Thorne', 'rating': '4.8', 'comment': 'Top notch quality. Will definitely buy the next drop!', 'date': '2 weeks ago', 'verified': 'true'},
  ];

  void _showWriteReviewSheet() {
    int rating = 5;
    final controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: AppSpacing.lg,
                bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.outlineVariant,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text('WRITE A COMMUNITY REVIEW', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                  const SizedBox(height: 4),
                  Text('Revival Hoodies Drop', style: AppTextStyles.headline.copyWith(fontSize: 18)),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starNum = index + 1;
                      return IconButton(
                        icon: Icon(
                          starNum <= rating ? Icons.star_rounded : Icons.star_border_rounded,
                          color: Colors.amber,
                          size: 32,
                        ),
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          setModalState(() {
                            rating = starNum;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    controller: controller,
                    maxLines: 3,
                    style: AppTextStyles.body.copyWith(color: AppColors.primary),
                    decoration: InputDecoration(
                      hintText: 'Share fit, fabric quality, and sizing advice...',
                      hintStyle: AppTextStyles.bodySmall,
                      filled: true,
                      fillColor: AppColors.surfaceContainerLow,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        borderSide: const BorderSide(color: AppColors.outlineVariant),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PrimaryButton(
                    label: 'Submit Verified Review',
                    width: double.infinity,
                    onPressed: () {
                      if (controller.text.trim().isEmpty) return;
                      Navigator.pop(context);
                      setState(() {
                        _reviews.insert(0, {
                          'name': 'You (Verified Buyer)',
                          'rating': '$rating.0',
                          'comment': controller.text.trim(),
                          'date': 'Just now',
                          'verified': 'true',
                        });
                      });
                      GlassToast.show(
                        context,
                        message: 'Thank you! Review published with Verified Buyer badge.',
                        icon: Icons.verified_rounded,
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
                title: 'COMMUNITY REVIEWS',
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
              const SizedBox(height: AppSpacing.md),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                onTap: _showWriteReviewSheet,
                child: Row(
                  children: [
                    const Icon(Icons.rate_review_outlined, color: AppColors.primaryContainer, size: 22),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Own this piece?', style: AppTextStyles.title.copyWith(fontSize: 15)),
                          Text('Share fit advice & earn 100 VIP points', style: AppTextStyles.bodySmall, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    const Icon(Icons.add_rounded, color: AppColors.primaryContainer, size: 22),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Expanded(
                child: ListView.separated(
                  itemCount: _reviews.length,
                  separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final item = _reviews[index];
                    return GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(item['name']!, style: AppTextStyles.title.copyWith(fontSize: 15)),
                                  if (item['verified'] == 'true') ...[
                                    const SizedBox(width: 6),
                                    const Icon(Icons.verified_rounded, color: AppColors.primaryContainer, size: 16),
                                  ],
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                                  const SizedBox(width: 4),
                                  Text(item['rating']!, style: AppTextStyles.caption),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(item['comment']!, style: AppTextStyles.body),
                          const SizedBox(height: 4),
                          Text(item['date']!, style: AppTextStyles.bodySmall),
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
