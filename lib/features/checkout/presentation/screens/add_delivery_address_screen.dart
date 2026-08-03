import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_radius.dart';
import '../../../../app/theme/app_spacing.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/cards/glass_card.dart';
import '../../../../core/widgets/inputs/email_field.dart';
import '../../../../core/widgets/navigation/top_header.dart';

class AddDeliveryAddressScreen extends StatefulWidget {
  const AddDeliveryAddressScreen({super.key});

  @override
  State<AddDeliveryAddressScreen> createState() => _AddDeliveryAddressScreenState();
}

class _AddDeliveryAddressScreenState extends State<AddDeliveryAddressScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();

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
                title: 'ADD DELIVERY ADDRESS',
                leading: GlassCard(
                  borderRadius: AppRadius.radiusFull,
                  padding: const EdgeInsets.all(AppSpacing.sm + 2),
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back_rounded, size: 20, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Text('RECIPIENT NAME', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.xs),
              EmailField(controller: _nameController, hintText: 'Full Name'),
              const SizedBox(height: AppSpacing.md),
              Text('STREET ADDRESS', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.xs),
              EmailField(controller: _addressController, hintText: 'Street & Apartment / Suite'),
              const SizedBox(height: AppSpacing.md),
              Text('CITY & STATE', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.xs),
              EmailField(controller: _cityController, hintText: 'City, State'),
              const SizedBox(height: AppSpacing.md),
              Text('POSTAL / ZIP CODE', style: AppTextStyles.caption),
              const SizedBox(height: AppSpacing.xs),
              EmailField(controller: _zipController, hintText: 'ZIP Code'),
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: 'Save Address',
                width: double.infinity,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Delivery address saved!')),
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
