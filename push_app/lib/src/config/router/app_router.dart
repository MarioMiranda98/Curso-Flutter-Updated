import 'package:go_router/go_router.dart';
import 'package:push_app/src/presentation/screens/details_screen/details_screen.dart';
import 'package:push_app/src/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/push_details/:messageId',
      builder: (context, state) {
        final pushMessageId = state.pathParameters['messageId'] ?? '';

        return DetailsScreen(pushMessageId: pushMessageId);
      },
    ),
  ],
);
