import 'package:mendlify/features/startup/presentation/providers/startup_provider.dart';
import 'package:mendlify/features/startup/presentation/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.builder});

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(startUpProvider(flavour: 'dev'));

    return asyncValue.when(
      data: (data) {
        return builder(context);
      },
      error: (error, stackTrace) {
        return Material(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: const SplashScreen(),
        );
      },
    );
  }
}
