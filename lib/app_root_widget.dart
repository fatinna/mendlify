import 'package:mendlify/core/utils/theme/app_theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/route/go_router_provider.dart';
import 'core/utils/theme/app_theme.dart';
import 'generated/l10n.dart';

class AppRootWidget extends ConsumerWidget {
  const AppRootWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final themeModeState = ref.watch(appThemeStateProvider);
    Locale? locale = Locale('en');
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            themeMode: themeModeState,
            routerConfig: goRouter,
            locale: locale,
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale!.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            localizationsDelegates: const [
              // 1
              S.delegate,
              // 2
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        });
  }
}
