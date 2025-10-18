import 'package:mendlify/features/startup/presentation/ui/widgets/app_startup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_root_widget.dart';

void main() {
  runApp(
    ProviderScope(
      child: AppStartupWidget(
        builder: (context) {
          return const AppRootWidget();
        },
      ),
    ),
  );
}