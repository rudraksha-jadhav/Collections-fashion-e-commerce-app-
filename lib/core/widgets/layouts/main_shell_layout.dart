import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../features/cart/presentation/providers/cart_provider.dart';
import '../collections_bottom_nav.dart';

class MainShellLayout extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainShellLayout({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartCountProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          navigationShell,
          CollectionsBottomNav(
            currentIndex: navigationShell.currentIndex,
            cartItemCount: cartCount,
            onTap: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
          ),
        ],
      ),
    );
  }
}
