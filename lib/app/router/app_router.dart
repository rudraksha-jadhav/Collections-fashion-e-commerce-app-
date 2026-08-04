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

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> discoverNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'discover');
final GlobalKey<NavigatorState> cartNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'cart');
final GlobalKey<NavigatorState> settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    // Splash & Onboarding (Root Navigator)
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Auth (Root Navigator)
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/otp',
      builder: (context, state) => const OtpScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),

    // Stateful Shell Navigation (Home, Discover, Cart, Settings)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShellLayout(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: homeNavigatorKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: discoverNavigatorKey,
          routes: [
            GoRoute(
              path: '/discover',
              builder: (context, state) => const DiscoverScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: cartNavigatorKey,
          routes: [
            GoRoute(
              path: '/cart',
              builder: (context, state) => const CartScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: settingsNavigatorKey,
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),

    // Secondary Screens (Root Navigator)
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/discover/stories',
      builder: (context, state) => const FashionStoriesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/discover/story/detail',
      builder: (context, state) => const FashionStoryDetailScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/discover/brand',
      builder: (context, state) => const BrandCollectionScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/products',
      builder: (context, state) => const ProductListScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/product-details',
      builder: (context, state) => ProductDetailsScreen(product: state.extra as Map<String, dynamic>?),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/products/image-viewer',
      builder: (context, state) => const FullscreenProductImageViewer(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/products/size-guide',
      builder: (context, state) => const SizeGuideScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/products/reviews',
      builder: (context, state) => const ProductReviewsScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/cart/coupons',
      builder: (context, state) => const CouponSelectionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/checkout',
      builder: (context, state) => const CheckoutScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/checkout/saved-addresses',
      builder: (context, state) => const SavedAddressesScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/checkout/add-address',
      builder: (context, state) => const AddDeliveryAddressScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/checkout/saved-payment',
      builder: (context, state) => const SavedPaymentMethodsScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/checkout/confirmation/success',
      builder: (context, state) => const OrderConfirmationScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/wishlist',
      builder: (context, state) => const WishlistScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/wishlist/empty',
      builder: (context, state) => const EmptyWishlistScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/orders',
      builder: (context, state) => const OrdersScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/orders/track',
      builder: (context, state) => const TrackOrderScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/profile/edit',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/settings/security',
      builder: (context, state) => const AccountSecurityScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/settings/language-region',
      builder: (context, state) => const LanguageRegionScreen(),
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/help',
      builder: (context, state) => const HelpScreen(),
    ),

    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/notifications',
      builder: (context, state) => const NotificationCenterScreen(),
    ),
  ],
);
