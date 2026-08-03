import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/inputs/email_field.dart';
import '../../../../core/widgets/inputs/password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.lg),
              Text(
                'COLLECTIONS',
                style: GoogleFonts.libreCaslonText(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ).animate().fadeIn(),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'WELCOME\nBACK.',
                textAlign: TextAlign.center,
                style: GoogleFonts.libreCaslonText(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  height: 1.05,
                  color: AppColors.primary,
                ),
              ).animate().fadeIn(delay: 150.ms).slideY(begin: 0.1),
              const SizedBox(height: AppSpacing.xxl),
              EmailField(controller: _emailController).animate().fadeIn(delay: 250.ms),
              const SizedBox(height: AppSpacing.md),
              PasswordField(controller: _passwordController).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: AppSpacing.xs),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.push('/forgot-password'),
                  child: Text(
                    'FORGOT PASSWORD?',
                    style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant, fontSize: 11),
                  ),
                ),
              ).animate().fadeIn(delay: 350.ms),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: 'SIGN IN',
                icon: Icons.arrow_forward_rounded,
                width: double.infinity,
                onPressed: () => context.go('/home'),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.outlineVariant)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text('OR', style: AppTextStyles.caption.copyWith(fontSize: 11)),
                  ),
                  const Expanded(child: Divider(color: AppColors.outlineVariant)),
                ],
              ).animate().fadeIn(delay: 450.ms),
              const SizedBox(height: AppSpacing.lg),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: AppSpacing.lg),
                onTap: () => context.go('/home'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.g_mobiledata_rounded, color: AppColors.primary, size: 24),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Continue with Google', style: AppTextStyles.buttonText.copyWith(color: AppColors.primary)),
                  ],
                ),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: AppSpacing.sm),
              GlassCard(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: AppSpacing.lg),
                onTap: () => context.push('/otp'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone_android_rounded, color: AppColors.primary, size: 18),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Continue with Phone', style: AppTextStyles.buttonText.copyWith(color: AppColors.primary)),
                  ],
                ),
              ).animate().fadeIn(delay: 550.ms),
              const SizedBox(height: AppSpacing.xxl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account? ', style: AppTextStyles.bodySmall),
                  GestureDetector(
                    onTap: () => context.push('/signup'),
                    child: Text(
                      'Create account',
                      style: AppTextStyles.buttonText.copyWith(color: AppColors.primary, fontSize: 13, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
