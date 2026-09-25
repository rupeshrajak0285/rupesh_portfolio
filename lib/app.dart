import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/providers/nav_provider.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavProvider(),
      child: MaterialApp(
        title: 'Rupesh Rajak · Senior Flutter Developer',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.dark,
        scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: false),
        home: const HomePage(),
      ),
    );
  }
}
