import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/inputs/email_field.dart';
import '../../../../core/widgets/inputs/password_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
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
                'JOIN THE\nCULTURE.',
                textAlign: TextAlign.center,
                style: GoogleFonts.libreCaslonText(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  height: 1.05,
                  color: AppColors.primary,
                ),
              ).animate().fadeIn().slideY(begin: 0.1),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Create an account to unlock exclusive drops\nand editorial curations.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant),
              ).animate().fadeIn(delay: 150.ms),
              const SizedBox(height: AppSpacing.xxl),
              EmailField(controller: _nameController, hintText: 'Full Name').animate().fadeIn(delay: 250.ms),
              const SizedBox(height: AppSpacing.md),
              EmailField(controller: _emailController, hintText: 'Email Address').animate().fadeIn(delay: 300.ms),
              const SizedBox(height: AppSpacing.md),
              EmailField(controller: _phoneController, hintText: 'Phone Number').animate().fadeIn(delay: 350.ms),
              const SizedBox(height: AppSpacing.md),
              PasswordField(controller: _passwordController).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'By creating an account, you agree to our Terms\nof Service and Privacy Policy.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
              ).animate().fadeIn(delay: 450.ms),
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                label: 'CREATE ACCOUNT',
                icon: Icons.arrow_forward_rounded,
                width: double.infinity,
                onPressed: () => context.go('/otp'),
              ).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: AppSpacing.xxl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already part of the culture? ', style: AppTextStyles.bodySmall),
                  GestureDetector(
                    onTap: () => context.go('/login'),
                    child: Text(
                      'SIGN IN',
                      style: AppTextStyles.buttonText.copyWith(color: AppColors.primary, fontSize: 13),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 550.ms),
            ],
          ),
        ),
      ),
    );
  }
}
