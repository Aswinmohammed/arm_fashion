import 'package:flutter/material.dart';

class WishlistBottomUtilityBar extends StatelessWidget {
  const WishlistBottomUtilityBar({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildIcon(IconData icon, {bool active = false}) {
      return Icon(
        icon,
        size: 17,
        color: active ? Colors.black : const Color(0xFFB8B8B8),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE8E4DD)),
          bottom: BorderSide(color: Color(0xFFE8E4DD)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildIcon(Icons.home_outlined),
          buildIcon(Icons.search_outlined),
          buildIcon(Icons.shopping_bag_outlined),
          buildIcon(Icons.person_outline, active: true),
        ],
      ),
    );
  }
}
