import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  int _focusedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const Spacer(),
              Text(
                'VERIFY\nYOUR NUMBER.',
                textAlign: TextAlign.center,
                style: GoogleFonts.libreCaslonText(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  height: 1.05,
                  color: AppColors.primary,
                ),
              ).animate().fadeIn().slideY(begin: 0.1),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Code sent to +91 XXXXX XXXXX',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant),
              ).animate().fadeIn(delay: 150.ms),
              const SizedBox(height: AppSpacing.xxl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  final isFocused = _focusedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: isFocused ? Colors.blueAccent : Colors.transparent,
                          width: 2.5,
                        ),
                        boxShadow: isFocused
                            ? [BoxShadow(color: Colors.blueAccent.withValues(alpha: 0.5), blurRadius: 8)]
                            : null,
                      ),
                      child: Center(
                        child: TextField(
                          controller: _controllers[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          style: GoogleFonts.hankenGrotesk(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          decoration: const InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          onTap: () {
                            setState(() {
                              _focusedIndex = index;
                            });
                          },
                          onChanged: (val) {
                            if (val.isNotEmpty && index < 3) {
                              setState(() {
                                _focusedIndex = index + 1;
                              });
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                    ),
                  );
                }),
              ).animate().fadeIn(delay: 250.ms),
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: 'VERIFY',
                icon: Icons.arrow_forward_rounded,
                width: double.infinity,
                onPressed: () => context.go('/home'),
              ).animate().fadeIn(delay: 350.ms),
              const SizedBox(height: AppSpacing.lg),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Verification code resent!')),
                  );
                },
                child: Text(
                  'Resend Code',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ).animate().fadeIn(delay: 400.ms),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
