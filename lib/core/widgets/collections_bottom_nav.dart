import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_radius.dart';
import '../../app/theme/app_spacing.dart';
import 'cards/glass_card.dart';

class CollectionsBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CollectionsBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      child: GlassCard(
        borderRadius: AppRadius.radiusFull,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_outlined, Icons.home_rounded),
            _buildNavItem(1, Icons.grid_view_outlined, Icons.grid_view_rounded),
            _buildNavItem(2, Icons.shopping_bag_outlined, Icons.shopping_bag_rounded),
            _buildNavItem(3, Icons.settings_outlined, Icons.settings_rounded),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Icon(
        isSelected ? activeIcon : icon,
        color: isSelected ? AppColors.primaryContainer : AppColors.outline,
        size: 24,
      ),
    );
  }
}
