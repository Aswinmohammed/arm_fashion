import 'package:flutter/material.dart';

class AuthBrandLogo extends StatelessWidget {
  const AuthBrandLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'ARM',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontFamily: 'serif',
                fontWeight: FontWeight.w400,
                color: Colors.black.withValues(alpha: 0.82),
                letterSpacing: 1.4,
                height: 0.95,
              ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 112,
          height: 1.2,
          color: Colors.black.withValues(alpha: 0.35),
        ),
        const SizedBox(height: 6),
        Text(
          'FASHION',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.black.withValues(alpha: 0.72),
                letterSpacing: 5.5,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}
