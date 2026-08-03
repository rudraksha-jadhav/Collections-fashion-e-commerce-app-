import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/inputs/email_field.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'Rudraksha Jadhav');
  final _emailController = TextEditingController(text: 'rudraksha@hypeos.com');
  final _phoneController = TextEditingController(text: '+1 (555) 019-2834');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeader(
                title: 'EDIT PROFILE',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primaryContainer, width: 2),
                        image: const DecorationImage(
                          image: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GlassCard(
                        borderRadius: AppRadius.radiusFull,
                        padding: const EdgeInsets.all(8),
                        onTap: () {},
                        child: const Icon(Icons.camera_alt_outlined, size: 16, color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn().scale(),
              const SizedBox(height: AppSpacing.xxl),
              Text('FULL NAME', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.xs),
              EmailField(controller: _nameController, hintText: 'Full Name'),
              const SizedBox(height: AppSpacing.md),
              Text('EMAIL ADDRESS', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.xs),
              EmailField(controller: _emailController, hintText: 'Email Address'),
              const SizedBox(height: AppSpacing.md),
              Text('PHONE NUMBER', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.xs),
              EmailField(controller: _phoneController, hintText: 'Phone Number'),
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: 'Save Changes',
                width: double.infinity,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully!')),
                  );
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
