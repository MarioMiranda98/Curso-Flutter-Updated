import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teslo_app/features/auth/presentation/providers/auth_provider.dart';

final appRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);

  return AppRouterNotifier(authNotifier: authNotifier);
});

class AppRouterNotifier extends ChangeNotifier {
  AppRouterNotifier({required this.authNotifier}) {
    authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  final AuthNotifier authNotifier;
  AuthStatus _authStatus = AuthStatus.checking;

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }
}
