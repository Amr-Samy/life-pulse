import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:life_pulse/presentation/resources/index.dart';
ThemeData getApplicationTheme(String theme) {
  switch (theme){
  //#region dark theme
    case 'dark':
      return ThemeData(
        useMaterial3: true,

    fontFamily: Get.locale?.languageCode == "en" ? FontConstants.fontFamily : null,
    // fontFamilyFallback: ['Urbanist'],
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: Colors.transparent, // ripple effect
    splashFactory: NoSplash.splashFactory,
    scaffoldBackgroundColor: ColorManager.dark,
    //Card Theme
    cardTheme: CardThemeData(
      color: ColorManager.dark,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s0,
      ),
    cardColor: ColorManager.lightDark,

    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ColorManager.dark,
    ),
    // dialogBackgroundColor: ColorManager.lightDark,
    //     tabBarTheme: const TabBarTheme(
    //       tabAlignment: TabAlignment.start,
    //
    //     ),
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(
      centerTitle: false,
      color: ColorManager.dark,
      shadowColor: ColorManager.lightPrimary,
      elevation: AppSize.s0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleSpacing: 0,
      titleTextStyle:
        getRegularStyle(color: ColorManager.white,fontSize: FontSize.s16),
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor:  ColorManager.primary,
        splashColor: Colors.transparent, // ripple effect
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s17),
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
        ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set text color
          ),
        ),

        //Text
    textTheme: TextTheme(
      displayLarge:
        getBoldStyle(color: ColorManager.white,fontSize: FontSize.s40),
      titleLarge:
        getSemiBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16),
      titleMedium:
        getSemiBoldStyle(color: ColorManager.lightGrey,fontSize: FontSize.s14),
      bodyLarge:getSemiBoldStyle(color: ColorManager.grey, fontSize: FontSize.s12,),
      bodySmall: getSemiBoldStyle(color: ColorManager.grey1,fontSize: FontSize.s12,),

    ),
    //Input Decoration
    inputDecorationTheme: InputDecorationTheme(
        fillColor: ColorManager.lightDark,
        filled: true,
        contentPadding: EdgeInsets.all(AppPadding.p8),
        hintStyle:
        getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        labelStyle:
        getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
        errorStyle: getRegularStyle(color: ColorManager.error,fontSize: FontSize.s12,),
        alignLabelWithHint: true,
        // enabled border style
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.transparent, width: AppSize.s0),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border style
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s05),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border style
        errorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.error, width: AppSize.s05),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused border style
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s05),
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
        )
    ),

    dividerTheme: DividerThemeData(
      color: ColorManager.grey,
      thickness: 0.2,
      indent: AppPadding.p32,
      endIndent: AppPadding.p32,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.dark,
      selectedIconTheme: IconThemeData(size: AppSize.s16,),
      unselectedIconTheme: IconThemeData(size: AppSize.s16,),
      selectedLabelStyle: getSemiBoldStyle(
          color: ColorManager.primary,
          fontSize: FontSize.s12
      ),
      unselectedLabelStyle: getSemiBoldStyle(
          color: ColorManager.disabled,
          fontSize: FontSize.s12
      ),
    ),
        navigationBarTheme: NavigationBarThemeData(
            backgroundColor: ColorManager.dark,
            labelTextStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return getSemiBoldStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s12
                );
              }
              return getSemiBoldStyle(
                  color: ColorManager.grey,
                  fontSize: FontSize.s12
              );
            }
            )
        ),

        popupMenuTheme: PopupMenuThemeData(
            color: ColorManager.lightDark
        ),
  );





    //#region Light Theme
    default:
      return ThemeData(
        useMaterial3: true,

        fontFamily: Get.locale?.languageCode == "en" ? FontConstants.fontFamily : null,
        primaryColor: ColorManager.primary,
        primaryColorLight: ColorManager.lightPrimary,
        primaryColorDark: ColorManager.darkPrimary,
        disabledColor: ColorManager.grey1,
        splashColor: Colors.transparent, // ripple effect
        splashFactory: NoSplash.splashFactory,
        scaffoldBackgroundColor: ColorManager.white,
        //Card Theme
        cardTheme: CardThemeData(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s0,
        ),
        cardColor: ColorManager.darkWhite,
        iconTheme: const IconThemeData(color: Colors.black),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          color: ColorManager.white,
          shadowColor: ColorManager.white,
          surfaceTintColor: ColorManager.white,
          elevation: AppSize.s0,
          iconTheme: const IconThemeData(color: Colors.black),
          titleSpacing: 0,
          titleTextStyle:
          getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s20),
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light
          ),
        ),
        buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor:  ColorManager.primary,
          splashColor: ColorManager.lightPrimary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: getRegularStyle(color: ColorManager.white,fontSize: FontSize.s17),
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s12),
            ),
          ),
        ),
        //Text
        textTheme: TextTheme(
          displayLarge:
          getBoldStyle(color: ColorManager.black,fontSize: FontSize.s40),
          titleLarge:
          getSemiBoldStyle(color: ColorManager.darkGrey,fontSize: FontSize.s16),
          titleMedium:
          getSemiBoldStyle(color: ColorManager.lightGrey,fontSize: FontSize.s14),
          bodyLarge:getSemiBoldStyle(color: ColorManager.grey,fontSize: FontSize.s12,),
          bodySmall: getSemiBoldStyle(color: ColorManager.grey1,fontSize: FontSize.s12,),
        ),
        // tabBarTheme: const TabBarTheme(
        //   tabAlignment: TabAlignment.start,
        //
        // ),
        //Input Decoration
        inputDecorationTheme: InputDecorationTheme(
            fillColor: ColorManager.darkWhite,
            filled: true,
          // content padding
            contentPadding: EdgeInsets.all(AppPadding.p8),
            alignLabelWithHint: true,
            // hint style
            hintStyle:
            getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
            labelStyle:
            getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
            errorStyle: getRegularStyle(color: ColorManager.error,fontSize: FontSize.s12,),

            // enabled border style
            enabledBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: Colors.transparent, width: AppSize.s0),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

            // focused border style
            focusedBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s1),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),

            // error border style
            errorBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: ColorManager.error, width: AppSize.s05),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))),
            // focused border style
            focusedErrorBorder: OutlineInputBorder(
                borderSide:
                BorderSide(color: ColorManager.primary, width: AppSize.s05),
                borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
            )
        ),
        dividerTheme: DividerThemeData(
          color: ColorManager.lightGrey,
          thickness: 0.5,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorManager.white,
          selectedIconTheme: IconThemeData(size: AppSize.s16,),
          unselectedIconTheme: IconThemeData(size: AppSize.s16,),
          selectedLabelStyle: getSemiBoldStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s12
          ),
          unselectedLabelStyle: getSemiBoldStyle(
              color: ColorManager.disabled,
              fontSize: FontSize.s12
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: ColorManager.white,
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return getSemiBoldStyle(
                  color: ColorManager.primary,
                  fontSize: FontSize.s12
              );
            }
            return getSemiBoldStyle(
                color: ColorManager.grey,
                fontSize: FontSize.s12
            );
          }
          )
        ),
        popupMenuTheme: PopupMenuThemeData(
          color: ColorManager.white
        ),
      );
  }
  }



class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool loadThemeFromBox() => _box.read(_key) ?? false;

  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!loadThemeFromBox());
  }
}