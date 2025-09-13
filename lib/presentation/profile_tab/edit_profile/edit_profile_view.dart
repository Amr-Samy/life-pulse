import 'package:country_code_picker/country_code_picker.dart';
import 'package:life_pulse/presentation/profile_tab/profile/profile_controller.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/drop_down.dart';
import 'package:life_pulse/presentation/widgets/input_field.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final profileController = Get.find<ProfileController>(tag: "ProfileController");
  @override
  void initState() {
    super.initState();
    // profileController.loadProfileData();
    // profileController.getLanguages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: AppSize.s0,
        automaticallyImplyLeading: true,
        title: Text(AppStrings.editProfile.tr),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: AppMargin.m16,),

              InputField(
                controller: profileController.fullNameTextController,
                hintText: AppStrings.fullName.tr,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (text){

                },
              ),

              SizedBox(height: AppMargin.m16,),

              InputField(
                controller: profileController.nicknameTextController,
                hintText: AppStrings.nickname.tr,
                keyboardType: TextInputType.name,
                onFieldSubmitted: (text){

                },
              ),

              SizedBox(height: AppMargin.m16,),


              SizedBox(height: AppMargin.m16,),

              InputField(
                controller: profileController.emailTextController,
                hintText: AppStrings.email.tr,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (text){

                },
              ),

              SizedBox(height: AppMargin.m20,),

              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                ),
                child: CountryCodePicker(
                  padding: const EdgeInsetsDirectional.all(0),
                  alignLeft: true ,
                  onChanged: (code) {

                  },
                  dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: true,
                  showDropDownButton: true,
                  dialogTextStyle: getSemiBoldStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                      fontSize: FontSize.s16),
                  textStyle: getSemiBoldStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                      fontSize: FontSize.s16),
                  barrierColor: Theme.of(context).cardColor,
                  searchStyle: getSemiBoldStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                      fontSize: FontSize.s16),
                  //TODO remove he
                  // countryFilter: ['he','iw'],
                ),
              ),

              SizedBox(height: AppMargin.m20,),

               CommonDropdownButton(
                    hintText: AppStrings.language.tr,
                    chosenValue: profileController.selectedFavLanguage,
                    itemsList: profileController.languages,
                    onChanged: (value) {
                        profileController.selectedFavLanguage!.value = value;
                        for (var language in profileController.languageList) {
                          if (language.name == value) {
                            profileController.favLangId = language.id;
                            break;
                          }
                        }
                    }
                ),

              SizedBox(height: AppMargin.m16,),


              InputField(
                controller: profileController.phoneTextController,
                hintText: AppStrings.phoneNumber.tr,
                keyboardType: TextInputType.phone,
                onFieldSubmitted: (text){

                },
                prefix: IntrinsicWidth(
                  child: CountryCodePicker(
                    padding: const EdgeInsetsDirectional.all(0),
                    alignLeft: true ,
                    onChanged: (code) {

                    },
                    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    // showDropDownButton: true,
                    dialogTextStyle: getSemiBoldStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        fontSize: FontSize.s16),
                    textStyle: getSemiBoldStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        fontSize: FontSize.s16),
                    barrierColor: Theme.of(context).cardColor,
                    searchStyle: getSemiBoldStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        fontSize: FontSize.s16),
                    //TODO remove he
                    // countryFilter: ['he','iw'],
                  ),
                ),
              ),

              SizedBox(height: AppMargin.m16,),
            ],
          ),
        ),
      ),
      bottomSheet:  Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p16,
          right: AppPadding.p16,
          bottom: AppPadding.p16,
        ),
        child: CustomButton(
          loading: profileController.isLoading.value,
          onTap: (){
            profileController.editProfile();
          },
          textButton: AppStrings.update.tr,
        ),
      ),
    );
  }
}