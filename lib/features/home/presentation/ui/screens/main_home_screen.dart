import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/theme/app_theme_state.dart';

class MainHomeScreen extends ConsumerWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(appThemeStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Theme $themeModeState",
        ),
        leading: Consumer(
          builder: (context, ref, child) {
            return Switch(
                value: themeModeState == ThemeMode.dark,
                onChanged: (value) {
                  ref.read(appThemeStateProvider.notifier).changeTheme(value);
                });
          },
        ),
      ),
    );
  }
}
