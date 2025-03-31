import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget {
  static const String name = "counter_screen";

  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final int counterValue = ref.watch(counterProvider);
    final bool isDarkTheme = ref.watch(isDarkThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
            onPressed: () => ref
                .read(isDarkThemeProvider.notifier)
                .update((state) => !state),
            icon: Icon(
              isDarkTheme
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      body: Center(
        child: Text(
          'Valor: $counterValue',
          style: theme.textTheme.titleLarge,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            ref.read(counterProvider.notifier).update((state) => state + 1),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
