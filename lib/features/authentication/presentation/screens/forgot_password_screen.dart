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

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlassCard(
                borderRadius: AppRadius.radiusFull,
                padding: const EdgeInsets.all(AppSpacing.sm + 2),
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
              ),
              const Spacer(),
              Text(
                'RESET ACCESS.',
                style: GoogleFonts.libreCaslonText(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  height: 1.05,
                  color: AppColors.primary,
                ),
              ).animate().fadeIn().slideY(begin: 0.1),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Enter your email address to reset your\npassword.',
                style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant),
              ).animate().fadeIn(delay: 150.ms),
              const SizedBox(height: AppSpacing.xxl),
              Text('EMAIL ADDRESS', style: AppTextStyles.caption.copyWith(fontSize: 11)),
              const SizedBox(height: AppSpacing.xs),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: AppRadius.radiusSm,
                ),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 4),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: GoogleFonts.hankenGrotesk(fontSize: 15, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'your@email.com',
                    hintStyle: GoogleFonts.hankenGrotesk(fontSize: 15, color: Colors.grey.shade400),
                    border: InputBorder.none,
                  ),
                ),
              ).animate().fadeIn(delay: 250.ms),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: 'SEND CODE',
                icon: Icons.arrow_forward_rounded,
                width: double.infinity,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Recovery code sent to your email!')),
                  );
                  context.push('/otp');
                },
              ).animate().fadeIn(delay: 350.ms),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
