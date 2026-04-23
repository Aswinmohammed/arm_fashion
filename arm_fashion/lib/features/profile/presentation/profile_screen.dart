import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../widgets/profile_bottom_bar.dart';
import '../widgets/profile_menu_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.embedded = false,
  });

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);
    const menuItems = [
      'MY ORDERS',
      'WISHLIST',
      'ADDRESS BOOK',
      'PAYMENT METHODS',
      'SETTINGS',
    ];

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F6F2),
          appBar: AppBar(
            automaticallyImplyLeading: !embedded,
            backgroundColor: const Color(0xFFF8F6F2),
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            leading: embedded
                ? null
                : IconButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
                    icon: const Icon(Icons.menu),
                  ),
            title: Text(
              'ARM FASHION',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.4,
                  ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.cart);
                },
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                    child: Column(
                      children: [
                        Container(
                          width: 108,
                          height: 108,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'images/profile/arm_aswin.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFFE6E1DA),
                                        Color(0xFFBBB5AE),
                                      ],
                                    ),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 58,
                                      color: Color(0xFF5A5A5A),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          store.userName,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: const Color(0xFF2E2E2E),
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          store.userEmail.isEmpty ? 'NOT SIGNED IN' : store.userEmail,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: const Color(0xFF666666),
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(height: 34),
                        ...menuItems.map((item) {
                          return ProfileMenuTile(
                            label: item,
                            onTap: () {
                              if (item == 'MY ORDERS') {
                                Navigator.pushNamed(context, RouteNames.orderHistory);
                              } else if (item == 'WISHLIST') {
                                Navigator.pushNamed(context, RouteNames.wishlist);
                              } else if (item == 'ADDRESS BOOK') {
                                Navigator.pushNamed(context, RouteNames.addressBook);
                              } else if (item == 'PAYMENT METHODS') {
                                Navigator.pushNamed(context, RouteNames.paymentMethods);
                              } else if (item == 'SETTINGS') {
                                Navigator.pushNamed(context, RouteNames.settings);
                              }
                            },
                          );
                        }),
                        const SizedBox(height: 26),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              store.logout();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteNames.login,
                                (route) => false,
                              );
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                                    letterSpacing: 2.8,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            child: const Text('LOGOUT'),
                          ),
                        ),
                        const SizedBox(height: 54),
                        Text(
                          'VERSION 1.0.0',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: const Color(0xFF7B7B7B),
                                letterSpacing: 1.4,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (!embedded) const ProfileBottomBar(),
              ],
            ),
          ),
        );
      },
    );
  }
}
