import 'package:flutter/material.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/cart/presentation/cart_screen.dart';
import '../../features/checkout/presentation/checkout_screen.dart';
import '../../features/checkout/presentation/order_success_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/home/presentation/main_shell_screen.dart';
import '../../features/orders/presentation/order_details_screen.dart';
import '../../features/orders/presentation/order_history_screen.dart';
import '../../features/products/presentation/category_products_screen.dart';
import '../../features/products/presentation/product_details_screen.dart';
import '../../features/products/presentation/search_screen.dart';
import '../../features/profile/presentation/address_book_screen.dart';
import '../../features/profile/presentation/payment_methods_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/settings_screen.dart';
import '../../features/wishlist/presentation/wishlist_screen.dart';
import 'route_names.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return _buildRoute(const LoginScreen(), settings);
      case RouteNames.register:
        return _buildRoute(const RegisterScreen(), settings);
      case RouteNames.mainShell:
        return _buildRoute(const MainShellScreen(), settings);
      case RouteNames.home:
        return _buildRoute(const HomeScreen(), settings);
      case RouteNames.search:
        return _buildRoute(const SearchScreen(), settings);
      case RouteNames.cart:
        return _buildRoute(const CartScreen(), settings);
      case RouteNames.profile:
        return _buildRoute(const ProfileScreen(), settings);
      case RouteNames.categoryProducts:
        return _buildRoute(const CategoryProductsScreen(), settings);
      case RouteNames.productDetails:
        return _buildRoute(const ProductDetailsScreen(), settings);
      case RouteNames.wishlist:
        return _buildRoute(const WishlistScreen(), settings);
      case RouteNames.checkout:
        return _buildRoute(const CheckoutScreen(), settings);
      case RouteNames.orderSuccess:
        return _buildRoute(const OrderSuccessScreen(), settings);
      case RouteNames.orderHistory:
        return _buildRoute(const OrderHistoryScreen(), settings);
      case RouteNames.orderDetails:
        return _buildRoute(const OrderDetailsScreen(), settings);
      case RouteNames.addressBook:
        return _buildRoute(const AddressBookScreen(), settings);
      case RouteNames.paymentMethods:
        return _buildRoute(const PaymentMethodsScreen(), settings);
      case RouteNames.settings:
        return _buildRoute(const SettingsScreen(), settings);
      default:
        return _buildRoute(const MainShellScreen(), settings);
    }
  }

  static MaterialPageRoute<dynamic> _buildRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
    );
  }
}
