import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';

class ProfileBottomBar extends StatelessWidget {
  const ProfileBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildItem({
      required IconData icon,
      required String label,
      required bool isSelected,
      required VoidCallback onTap,
    }) {
      final color = isSelected ? Colors.black : const Color(0xFFB7B7B7);

      return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(height: 4),
                Text(
                  label.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: color,
                        fontSize: 8,
                        height: 1.0,
                        letterSpacing: 0.9,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE7E3DB)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            buildItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isSelected: false,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.mainShell,
                  (route) => false,
                );
              },
            ),
            buildItem(
              icon: Icons.search_outlined,
              label: 'Search',
              isSelected: false,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.search);
              },
            ),
            buildItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Cart',
              isSelected: false,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.cart);
              },
            ),
            buildItem(
              icon: Icons.person,
              label: 'Profile',
              isSelected: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
