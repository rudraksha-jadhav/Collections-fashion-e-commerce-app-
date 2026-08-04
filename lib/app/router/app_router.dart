import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/widgets/layouts/main_shell_layout.dart';

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

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      // Splash & Onboarding
      GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingScreen()),

      // Auth
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
      GoRoute(path: '/otp', builder: (context, state) => const OtpScreen()),
      GoRoute(path: '/forgot-password', builder: (context, state) => const ForgotPasswordScreen()),

      // Persistent Shell Navigation (Home, Discover, Cart, Settings)
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => MainShellLayout(child: child),
        routes: [
          GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
          GoRoute(path: '/discover', builder: (context, state) => const DiscoverScreen()),
          GoRoute(path: '/cart', builder: (context, state) => const CartScreen()),
          GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
        ],
      ),

      // Sub-views & Secondary Screens
      GoRoute(path: '/discover/stories', builder: (context, state) => const FashionStoriesScreen()),
      GoRoute(path: '/discover/story/detail', builder: (context, state) => const FashionStoryDetailScreen()),
      GoRoute(path: '/discover/brand', builder: (context, state) => const BrandCollectionScreen()),

      GoRoute(path: '/categories', builder: (context, state) => const CategoriesScreen()),

      GoRoute(path: '/products', builder: (context, state) => const ProductListScreen()),
      GoRoute(path: '/product-details', builder: (context, state) => const ProductDetailsScreen()),
      GoRoute(path: '/products/image-viewer', builder: (context, state) => const FullscreenProductImageViewer()),
      GoRoute(path: '/products/size-guide', builder: (context, state) => const SizeGuideScreen()),
      GoRoute(path: '/products/reviews', builder: (context, state) => const ProductReviewsScreen()),

      GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),

      GoRoute(path: '/cart/coupons', builder: (context, state) => const CouponSelectionScreen()),
      GoRoute(path: '/checkout', builder: (context, state) => const CheckoutScreen()),
      GoRoute(path: '/checkout/saved-addresses', builder: (context, state) => const SavedAddressesScreen()),
      GoRoute(path: '/checkout/add-address', builder: (context, state) => const AddDeliveryAddressScreen()),
      GoRoute(path: '/checkout/saved-payment', builder: (context, state) => const SavedPaymentMethodsScreen()),
      GoRoute(
        path: '/checkout/confirmation',
        builder: (context, state) => OrderConfirmationScreen(orderId: state.extra as String?),
      ),

      GoRoute(path: '/wishlist', builder: (context, state) => const WishlistScreen()),
      GoRoute(path: '/wishlist/empty', builder: (context, state) => const EmptyWishlistScreen()),
      GoRoute(path: '/orders', builder: (context, state) => const OrdersScreen()),
      GoRoute(
        path: '/orders/track',
        builder: (context, state) => TrackOrderScreen(orderId: state.extra as String?),
      ),

      GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
      GoRoute(path: '/profile/edit', builder: (context, state) => const EditProfileScreen()),
      GoRoute(path: '/settings/security', builder: (context, state) => const AccountSecurityScreen()),
      GoRoute(path: '/settings/language-region', builder: (context, state) => const LanguageRegionScreen()),
      GoRoute(path: '/help', builder: (context, state) => const HelpScreen()),

      GoRoute(path: '/notifications', builder: (context, state) => const NotificationCenterScreen()),
    ],
  );
}
