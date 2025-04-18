import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {
  static const String name = "theme_changer";

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final bool isDarkTheme = ref.watch(isDarkThemeProvider);
    final themeProviderNotifier = ref.read(themeNotifierProvider.notifier);
    final AppTheme appTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Changer'),
        actions: [
          IconButton(
            onPressed: themeProviderNotifier.toggleDarkMode,
            icon: Icon(
              appTheme.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Color> colors = ref.watch(colorListProvider);
    // final int selectedColor = ref.watch(selectedColorProvider);
    final themeProviderNotifier = ref.read(themeNotifierProvider.notifier);
    final AppTheme appTheme = ref.watch(themeNotifierProvider);

    return ListView.builder(
      itemCount: colorList.length,
      itemBuilder: (context, index) {
        final Color color = colors.elementAt(index);

        return RadioListTile(
          title: Text(
            'Este color',
            style: TextStyle(
              color: color,
            ),
          ),
          subtitle: Text('${color.toARGB32()}'),
          activeColor: color,
          value: index,
          groupValue: appTheme.selectedColor,
          onChanged: (value) =>
              themeProviderNotifier.changeColorIndex(value ?? 0),
        );
      },
    );
  }
}
