import 'package:flutter/material.dart';

import 'core/routes/app_router.dart';
import 'core/routes/route_names.dart';
import 'core/state/app_scope.dart';
import 'core/state/app_store.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const ArmFashionApp());
}

class ArmFashionApp extends StatefulWidget {
  const ArmFashionApp({super.key});

  @override
  State<ArmFashionApp> createState() => _ArmFashionAppState();
}

class _ArmFashionAppState extends State<ArmFashionApp> {
  final AppStore _store = AppStore();

  @override
  Widget build(BuildContext context) {
    return AppScope(
      store: _store,
      child: MaterialApp(
        title: 'ARM Fashion',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: RouteNames.login,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
