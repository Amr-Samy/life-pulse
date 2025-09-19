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

    if (storedLang != null && _isLanguageSupported(storedLang)) {
      return Locale(storedLang);
    }

    final deviceLocale = Platform.localeName.split('_').first;
    if (_isLanguageSupported(deviceLocale)) {
      return Locale(deviceLocale);
    }

    return const Locale('ar');
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
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          locale: _getStoredLocale(),
          fallbackLocale: const Locale('ar'),
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
          storage.read("firstRun") != null ? Routes.mainRoute : Routes.onBoardingRoute,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          ),
          theme: getApplicationTheme('light'),
          darkTheme: getApplicationTheme('dark'),
          themeMode: ThemeService().theme,
        );
      },
    );
  }

}