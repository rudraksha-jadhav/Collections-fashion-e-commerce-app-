import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/app_colors.dart';
import '../../../features/cart/presentation/providers/cart_provider.dart';
import '../collections_bottom_nav.dart';

class MainShellLayout extends ConsumerWidget {
  final Widget child;

  const MainShellLayout({super.key, required this.child});

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/discover')) return 1;
    if (location.startsWith('/cart')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = _calculateSelectedIndex(context);
    final cartCount = ref.watch(cartCountProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          child,
          CollectionsBottomNav(
            currentIndex: currentIndex,
            cartItemCount: cartCount,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                  context.go('/discover');
                  break;
                case 2:
                  context.go('/cart');
                  break;
                case 3:
                  context.go('/settings');
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
