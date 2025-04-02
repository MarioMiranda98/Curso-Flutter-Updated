import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/src/config/theme/app_theme.dart';
import 'package:cinemapedia/src/config/router/app_router.dart';

void main() async {
  await dotenv.load();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cinemapedia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      routerConfig: appRouter,
    );
  }
}
