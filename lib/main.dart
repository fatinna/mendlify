import 'package:mendlify/features/startup/presentation/ui/widgets/app_startup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'app_root_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
