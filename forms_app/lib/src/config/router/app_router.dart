import 'package:go_router/go_router.dart';

import 'package:forms_app/src/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/cubits',
      builder: (context, state) => const CubitCounterScreen(),
    ),
    GoRoute(
      path: '/bloc-counter',
      builder: (context, state) => const BlocCounterScreen(),
    ),
  ],
);
