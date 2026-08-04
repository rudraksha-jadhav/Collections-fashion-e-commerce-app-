import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/authentication/presentation/screens/otp_screen.dart';
import '../../features/authentication/presentation/screens/signup_screen.dart';

import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/splash_screen.dart';

import '../../features/home/presentation/screens/home_screen.dart';

import '../../features/discover/presentation/screens/brand_collection_screen.dart';
import '../../features/discover/presentation/screens/discover_screen.dart';
import '../../features/discover/presentation/screens/fashion_stories_screen.dart';
import '../../features/discover/presentation/screens/fashion_story_detail_screen.dart';

import '../../features/categories/presentation/screens/categories_screen.dart';

import '../../features/products/presentation/screens/fullscreen_product_image_viewer.dart';
import '../../features/products/presentation/screens/product_details.dart';
import '../../features/products/presentation/screens/product_list.dart';
import '../../features/products/presentation/screens/product_reviews_screen.dart';
import '../../features/products/presentation/screens/search_screen.dart';
import '../../features/products/presentation/screens/size_guide_screen.dart';

import '../../features/wishlist/presentation/screens/empty_wishlist_screen.dart';
import '../../features/wishlist/presentation/screens/wishlist_screen.dart';

import '../../features/cart/presentation/screens/coupon_selection_screen.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';

import '../../features/checkout/presentation/screens/add_delivery_address_screen.dart';
import '../../features/checkout/presentation/screens/checkout_screen.dart';
import '../../features/checkout/presentation/screens/order_confirmation_screen.dart';
import '../../features/checkout/presentation/screens/saved_addresses_screen.dart';
import '../../features/checkout/presentation/screens/saved_payment_methods_screen.dart';

import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/orders/presentation/screens/track_order_screen.dart';

import '../../features/notifications/presentation/screens/notification_center_screen.dart';

import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';

import '../../features/settings/presentation/screens/account_security_screen.dart';
import '../../features/settings/presentation/screens/help_screen.dart';
import '../../features/settings/presentation/screens/language_region_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

final GoRouter appRouter = AppRouter.router;

CustomTransitionPage<void> _buildFadeSlidePage(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 250),
  );
}

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      // Splash & Onboarding
      GoRoute(path: '/splash', pageBuilder: (context, state) => _buildFadeSlidePage(const SplashScreen(), state)),
      GoRoute(path: '/onboarding', pageBuilder: (context, state) => _buildFadeSlidePage(const OnboardingScreen(), state)),

      // Auth Top Level & Aliases
      GoRoute(path: '/login', pageBuilder: (context, state) => _buildFadeSlidePage(const LoginScreen(), state)),
      GoRoute(path: '/signup', pageBuilder: (context, state) => _buildFadeSlidePage(const SignupScreen(), state)),
      GoRoute(path: '/otp', pageBuilder: (context, state) => _buildFadeSlidePage(const OtpScreen(), state)),
      GoRoute(path: '/forgot-password', pageBuilder: (context, state) => _buildFadeSlidePage(const ForgotPasswordScreen(), state)),

      GoRoute(
        path: '/auth',
        pageBuilder: (context, state) => _buildFadeSlidePage(const LoginScreen(), state),
        routes: [
          GoRoute(path: 'login', pageBuilder: (context, state) => _buildFadeSlidePage(const LoginScreen(), state)),
          GoRoute(path: 'signup', pageBuilder: (context, state) => _buildFadeSlidePage(const SignupScreen(), state)),
          GoRoute(path: 'otp', pageBuilder: (context, state) => _buildFadeSlidePage(const OtpScreen(), state)),
          GoRoute(path: 'forgot-password', pageBuilder: (context, state) => _buildFadeSlidePage(const ForgotPasswordScreen(), state)),
        ],
      ),

      // Home Feed
      GoRoute(path: '/home', pageBuilder: (context, state) => _buildFadeSlidePage(const HomeScreen(), state)),

      // Discover & Editorial Stories
      GoRoute(path: '/discover', pageBuilder: (context, state) => _buildFadeSlidePage(const DiscoverScreen(), state)),
      GoRoute(path: '/discover/stories', pageBuilder: (context, state) => _buildFadeSlidePage(const FashionStoriesScreen(), state)),
      GoRoute(path: '/discover/stories/all', pageBuilder: (context, state) => _buildFadeSlidePage(const FashionStoriesScreen(), state)),
      GoRoute(path: '/discover/story/detail', pageBuilder: (context, state) => _buildFadeSlidePage(const FashionStoryDetailScreen(), state)),
      GoRoute(path: '/discover/brand', pageBuilder: (context, state) => _buildFadeSlidePage(const BrandCollectionScreen(), state)),

      // Categories
      GoRoute(path: '/categories', pageBuilder: (context, state) => _buildFadeSlidePage(const CategoriesScreen(), state)),

      // Products & Sub-views
      GoRoute(path: '/products', pageBuilder: (context, state) => _buildFadeSlidePage(const ProductListScreen(), state)),
      GoRoute(path: '/product-details', pageBuilder: (context, state) => _buildFadeSlidePage(const ProductDetailsScreen(), state)),
      GoRoute(path: '/products/details', pageBuilder: (context, state) => _buildFadeSlidePage(const ProductDetailsScreen(), state)),
      GoRoute(path: '/products/image-viewer', pageBuilder: (context, state) => _buildFadeSlidePage(const FullscreenProductImageViewer(), state)),
      GoRoute(path: '/products/size-guide', pageBuilder: (context, state) => _buildFadeSlidePage(const SizeGuideScreen(), state)),
      GoRoute(path: '/products/reviews', pageBuilder: (context, state) => _buildFadeSlidePage(const ProductReviewsScreen(), state)),

      // Search
      GoRoute(path: '/search', pageBuilder: (context, state) => _buildFadeSlidePage(const SearchScreen(), state)),

      // Cart & Checkout Flow
      GoRoute(path: '/cart', pageBuilder: (context, state) => _buildFadeSlidePage(const CartScreen(), state)),
      GoRoute(path: '/cart/coupons', pageBuilder: (context, state) => _buildFadeSlidePage(const CouponSelectionScreen(), state)),
      GoRoute(path: '/checkout', pageBuilder: (context, state) => _buildFadeSlidePage(const CheckoutScreen(), state)),
      GoRoute(path: '/checkout/saved-addresses', pageBuilder: (context, state) => _buildFadeSlidePage(const SavedAddressesScreen(), state)),
      GoRoute(path: '/checkout/add-address', pageBuilder: (context, state) => _buildFadeSlidePage(const AddDeliveryAddressScreen(), state)),
      GoRoute(path: '/checkout/saved-payment', pageBuilder: (context, state) => _buildFadeSlidePage(const SavedPaymentMethodsScreen(), state)),
      GoRoute(path: '/checkout/confirmation/success', pageBuilder: (context, state) => _buildFadeSlidePage(const OrderConfirmationScreen(), state)),

      // Wishlist & Drops History
      GoRoute(path: '/wishlist', pageBuilder: (context, state) => _buildFadeSlidePage(const WishlistScreen(), state)),
      GoRoute(path: '/wishlist/empty', pageBuilder: (context, state) => _buildFadeSlidePage(const EmptyWishlistScreen(), state)),
      GoRoute(path: '/orders', pageBuilder: (context, state) => _buildFadeSlidePage(const OrdersScreen(), state)),
      GoRoute(path: '/orders/track', pageBuilder: (context, state) => _buildFadeSlidePage(const TrackOrderScreen(), state)),

      // User Profile & Settings
      GoRoute(path: '/profile', pageBuilder: (context, state) => _buildFadeSlidePage(const ProfileScreen(), state)),
      GoRoute(path: '/profile/edit', pageBuilder: (context, state) => _buildFadeSlidePage(const EditProfileScreen(), state)),
      GoRoute(path: '/settings', pageBuilder: (context, state) => _buildFadeSlidePage(const SettingsScreen(), state)),
      GoRoute(path: '/settings/security', pageBuilder: (context, state) => _buildFadeSlidePage(const AccountSecurityScreen(), state)),
      GoRoute(path: '/settings/language-region', pageBuilder: (context, state) => _buildFadeSlidePage(const LanguageRegionScreen(), state)),
      GoRoute(path: '/help', pageBuilder: (context, state) => _buildFadeSlidePage(const HelpScreen(), state)),

      // Notifications
      GoRoute(path: '/notifications', pageBuilder: (context, state) => _buildFadeSlidePage(const NotificationCenterScreen(), state)),
    ],
  );
}
