import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  // const MyApp({super.key});
  MyApp._internal();
  static final MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _getStoredLocale() {
    final box = GetStorage();
    final storedLang = box.read('language_code');

    // If we have a stored language that matches our supported locales
    if (storedLang != null && _isLanguageSupported(storedLang)) {
      return Locale(storedLang);
    }

    // Fallback to device locale if supported
    final deviceLocale = Platform.localeName.split('_').first;
    if (_isLanguageSupported(deviceLocale)) {
      return Locale(deviceLocale);
    }

    // Final fallback to English
    return const Locale('en');
  }

  bool _isLanguageSupported(String languageCode) {
    const supportedLanguages = [
      'en', 'ar', 'fr', 'es', 'de', 'ru',
      'ur', 'cn', 'id', 'fa', 'tr', 'tl',
      'ha', 'th'
    ];
    return supportedLanguages.contains(languageCode);
  }

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          // builder: DevicePreview.appBuilder,
          // locale: DevicePreview.locale(context),
          locale: _getStoredLocale(),
          fallbackLocale: const Locale('en'),
          translations: LocalizationApp(),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
            Locale('fr'),
            Locale('es'),
            Locale('de'),
            Locale('ru'),
            Locale('ur'),
            Locale('cn'),
            Locale('id'),
            Locale('fa'),
            Locale('tr'),
            Locale('tl'),
            Locale('ha'),
            Locale('th'),
          ],
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute:
          // storage.read("firstRun") != null ? Routes.mainRoute : Routes.onBoardingRoute,
          Routes.onBoardingRoute,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          ),
          theme: getApplicationTheme('light'),
          darkTheme: getApplicationTheme('dark'),
          themeMode: ThemeService().theme,
          // builder: (BuildContext context, Widget? widget) {
          //   ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          //     return CustomError(errorDetails: errorDetails);
          //   };
          //   return widget!;
          // },
        );
      },
    );
  }

}