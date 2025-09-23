import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:life_pulse/presentation/profile_tab/profile/profile_controller.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';
import 'package:life_pulse/presentation/widgets/drop_down.dart';
import 'package:life_pulse/presentation/widgets/input_field.dart';

import '../../widgets/custom_text_field.dart';

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
      profileController.loadProfileData();
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
            SizedBox(height: AppMargin.m16,),
            // Avatar
            Center(
                child: Obx(() => Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                      backgroundColor: const Color(0xFFF1F1F1),
                      backgroundImage: profileController.selectedImage.value != null
                          ?  FileImage(profileController.selectedImage.value as File)
                          : (profileController.userImage.value != null && profileController.userImage.value!.isNotEmpty)
                          ?  NetworkImage(profileController.userImage.value!)
                          : null,
                      child: (profileController.selectedImage.value == null && (profileController.userImage.value == null || profileController.userImage.value!.isEmpty))
                          ? const Icon(Icons.person, color: Colors.grey, size: 50)
                          : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                      child: GestureDetector(
                        onTap: () {
                          profileController.pickImage();
                        },
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                    ),
                ],
                )),
              ),

            SizedBox(height: AppMargin.m40,),
              /// Name
              CustomTextField(
                  hintText: AppStrings.fullName.tr,
                  keyboardType: TextInputType.name,
                onFieldSubmitted: (text){

                },
                controller: profileController.fullNameTextController,
              ),

              SizedBox(height: AppMargin.m16,),
              // /// Nickname
              // CustomTextField(
              //   controller: profileController.nicknameTextController,
              //   hintText: AppStrings.nickname.tr,
              //   keyboardType: TextInputType.name,
              //   onFieldSubmitted: (text){
              //
              //   },
              // ),
              // SizedBox(height: AppMargin.m16,),

              /// Email
              CustomTextField(
                controller: profileController.emailTextController,
                hintText: AppStrings.email.tr,
                keyboardType: TextInputType.emailAddress,
                enabled: true,
                onFieldSubmitted: (text){

                },
              ),

              SizedBox(height: AppMargin.m20,),

              // phone
              InputField(
                controller: profileController.phoneTextController,
                hintText: AppStrings.phoneNumber.tr,
                keyboardType: TextInputType.phone,
                enabled: false,
                onFieldSubmitted: (text){

                },
                prefix: IntrinsicWidth(
                  child: CountryCodePicker(
                    padding: const EdgeInsetsDirectional.all(0),
                    alignLeft: true ,
                    onChanged: (code) {

                    },
                    boxDecoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    initialSelection: "EG",
                    dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Colors.white,
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
                  ),
                ),
              ),

              SizedBox(height: AppMargin.m16,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: AppPadding.p16,
          right: AppPadding.p16,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppPadding.p16,
        ),
        child: Obx(() => CustomButton(
          loading: profileController.isLoading.value,
          onTap: (){
            profileController.editProfile();
          },
          textButton: AppStrings.update.tr,
          color: Colors.green,
        )),
      ),
    );
  }
}