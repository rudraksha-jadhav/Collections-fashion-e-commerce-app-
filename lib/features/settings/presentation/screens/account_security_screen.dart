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
import '../../../../core/widgets/notifications/glass_toast.dart';
import '../../../../core/widgets/sheets/biometric_auth_sheet.dart';

class AccountSecurityScreen extends StatefulWidget {
  const AccountSecurityScreen({super.key});

  @override
  State<AccountSecurityScreen> createState() => _AccountSecurityScreenState();
}

class _AccountSecurityScreenState extends State<AccountSecurityScreen> {
  bool _isBiometricEnabled = false;

  void _showActiveSessionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ACTIVE SESSIONS', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.md),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    const Icon(Icons.phone_android_rounded, color: AppColors.primaryContainer, size: 24),
                    const SizedBox(width: AppSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Realme RMX2001 (This Phone)', style: AppTextStyles.title.copyWith(fontSize: 15)),
                        Text('Active now — Android 11', style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    const Icon(Icons.laptop_mac_rounded, color: AppColors.outline, size: 24),
                    const SizedBox(width: AppSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Chrome macOS (Web App)', style: AppTextStyles.title.copyWith(fontSize: 15)),
                        Text('Last active 2 hours ago', style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              PrimaryButton(
                label: 'Revoke Other Sessions',
                width: double.infinity,
                onPressed: () {
                  Navigator.pop(context);
                  GlassToast.show(
                    context,
                    message: 'Revoked all other active sessions!',
                    icon: Icons.security_rounded,
                  );
                },
              ),
            ],
          ),
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
                title: 'ACCOUNT & SECURITY',
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
              _buildSecurityOption(
                title: '2-Factor Authentication (2FA)',
                subtitle: 'Enabled via Mobile OTP',
                onTap: () => context.push('/otp'),
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildSecurityOption(
                title: 'Change Password',
                subtitle: 'Update account password',
                onTap: () => context.push('/forgot-password'),
              ),
              const SizedBox(height: AppSpacing.sm),
              GlassCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                onTap: () {
                  if (!_isBiometricEnabled) {
                    BiometricAuthSheet.show(
                      context,
                      onSuccess: () {
                        setState(() {
                          _isBiometricEnabled = true;
                        });
                      },
                    );
                  } else {
                    setState(() {
                      _isBiometricEnabled = false;
                    });
                    GlassToast.show(
                      context,
                      message: 'Biometric Login Disabled',
                      icon: Icons.fingerprint_rounded,
                    );
                  }
                },
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Biometric Login', style: AppTextStyles.title.copyWith(fontSize: 15)),
                        const SizedBox(height: 2),
                        Text(
                          _isBiometricEnabled ? 'TouchID / FaceID Active' : 'Enable Fingerprint or FaceID',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Switch.adaptive(
                      value: _isBiometricEnabled,
                      activeTrackColor: AppColors.primaryContainer,
                      onChanged: (val) {
                        if (val) {
                          BiometricAuthSheet.show(
                            context,
                            onSuccess: () {
                              setState(() {
                                _isBiometricEnabled = true;
                              });
                            },
                          );
                        } else {
                          setState(() {
                            _isBiometricEnabled = false;
                          });
                          GlassToast.show(
                            context,
                            message: 'Biometric Login Disabled',
                            icon: Icons.fingerprint_rounded,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ).animate().fadeIn(),
              const SizedBox(height: AppSpacing.sm),
              _buildSecurityOption(
                title: 'Active Sessions & Devices',
                subtitle: 'Manage connected phones & web sessions',
                onTap: () => _showActiveSessionsSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityOption({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      onTap: onTap,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.title.copyWith(fontSize: 15)),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.bodySmall),
            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.outline, size: 16),
        ],
      ),
    ).animate().fadeIn();
  }
}
