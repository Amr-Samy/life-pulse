import 'package:get_storage/get_storage.dart';
import 'package:life_pulse/presentation/profile_tab/profile/profile_controller.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/setting_tile.dart';

class LanguageSettingsView extends StatefulWidget {
  const LanguageSettingsView({super.key});

  @override
  State<LanguageSettingsView> createState() => _LanguageSettingsViewState();
}

class _LanguageSettingsViewState extends State<LanguageSettingsView> {
  final profileController = Get.find<ProfileController>(tag: "ProfileController");
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _initializeLanguage();
  }

  void _initializeLanguage() {
    final storedLang = box.read('language_code');
    if (storedLang != null) {
      profileController.selectedLanguage.value =
          profileController.getIndexFromLangCode(storedLang);
    } else {
      isArabic()
          ? profileController.selectedLanguage.value = 6
          : profileController.selectedLanguage.value = 0;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: ApplicationToolbar(
        title: AppStrings.language.tr,
        actions: const [
          SizedBox.shrink(),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p16),
              child: Text(
                AppStrings.suggested.tr,
                style: getSemiBoldStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color!,
                    fontSize: FontSize.s20),
              ),
            ),

            // English
            SettingTile(
              title: 'English (US)',
              onTap: () {
                profileController.changeLanguage("en");
              },
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 0,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            // Arabic
            SettingTile(
              title: 'العربية',
              onTap: () {profileController.changeLanguage("ar");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 6,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),

            Padding(

              padding: EdgeInsets.symmetric(vertical: AppPadding.p8,),
              child: Divider(
                height: AppSize.s2,
                thickness: AppSize.s02,
                endIndent: AppPadding.p16,
                indent: AppPadding.p16,
              ),
            ),

            /// Other Languages
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p16),
              child: Text(
                AppStrings.otherLanguages.tr,
                style: getSemiBoldStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color!,
                    fontSize: FontSize.s20),
              ),
            ),

            SettingTile(
              title: 'Français',
              onTap: () {profileController.changeLanguage("fr");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 7,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: 'Español',
              onTap: () {profileController.changeLanguage("es");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 8,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: 'Deutsch',
              onTap: () {profileController.changeLanguage("de");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 9,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: 'Русский',
              onTap: () {profileController.changeLanguage("ru");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 10,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: 'اردو',
              onTap: () {profileController.changeLanguage("ur");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 11,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: '中文',
              onTap: () {profileController.changeLanguage("cn");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 12,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: 'Bahasa Indonesia',
              onTap: () {profileController.changeLanguage("id");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 13,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: 'فارسی',
              onTap: () {profileController.changeLanguage("fa");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 14,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: 'Türkçe',
              onTap: () {profileController.changeLanguage("tr");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 15,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: 'Tagalog',
              onTap: () {profileController.changeLanguage("tl");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 17,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: 'Hausa',
              onTap: () {profileController.changeLanguage("ha");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 18,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),
            SettingTile(
              title: 'ไทย',
              onTap: () {profileController.changeLanguage("th");},
              trailing: Radio(
                fillColor: MaterialStateColor.resolveWith((states) =>
                states.contains(MaterialState.selected)
                    ? ColorManager.primary
                    : ColorManager.primary
                ),
                value: 16,
                groupValue: profileController.selectedLanguage.value,
                onChanged: (value) => profileController.onChanged(value!),
              ),
            ),

          ],
        ),
      ),

    );
  }
}