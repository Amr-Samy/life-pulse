// import 'package:life_pulse/presentation/resources/index.dart';
// import 'package:life_pulse/presentation/widgets/button.dart';
// import 'package:life_pulse/presentation/widgets/radio_card.dart';
//
// import '../sign_in/signIn_viewModel.dart';
//
// class ForgotPasswordView extends StatefulWidget {
//   const ForgotPasswordView({super.key});
//
//   @override
//   State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
// }
//
// class _ForgotPasswordViewState extends State<ForgotPasswordView> {
//   final signInController = Get.find<SignInController>(tag: "SignInController");
//
//   @override
//   void initState() {
//     super.initState();
//     // signInController.encryptEmail();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: AppSize.s0,
//         automaticallyImplyLeading: true,
//         title: Text(AppStrings.forgotPassword.tr),
//       ),
//
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: AppMargin.m16,
//               ),
//
//               Image.asset(
//                   ImageAssets.forgotPassword,
//                 width: MediaQuery.of(context).size.width * 0.65,
//               ),
//
//               SizedBox(height: AppMargin.m40,),
//
//               Text(
//                 AppStrings.selectResetMethod.tr,
//                 style: getLightStyle(
//                     color: Theme.of(context).textTheme.displayLarge!.color!,
//                     fontSize: FontSize.s18),
//               ),
//
//               SizedBox(height: AppMargin.m20,),
//
//               ///TODO OBX // REMOVE SET STATE //get phone and email
//               MyRadioListTile<int>(
//                 value: 1,
//                 groupValue: signInController.selectedRadioTile.value,
//                 leading: ImageAssets.sms,
//                 title: AppStrings.viaSMS.tr,
//                 subtitle: "+1 111 ******99",
//                 onChanged: (value) => setState(() => signInController.selectedRadioTile.value = value!),
//               ),
//
//               SizedBox(height: AppMargin.m20,),
//
//               MyRadioListTile<int>(
//                 value: 2,
//                 groupValue: signInController.selectedRadioTile.value,
//                 leading: ImageAssets.mail,
//                 title: AppStrings.viaEmail.tr,
//                 // subtitle: "and***ley@yourdomain.com",
//                 subtitle: signInController.emailCharacter.value,
//                 onChanged: (value) => setState(() => signInController.selectedRadioTile.value = value!),
//
//               ),
//
//             ],
//           ),
//         ),
//       ),
//
//       bottomSheet:  Padding(
//         padding: EdgeInsets.only(
//             left: AppPadding.p16,
//             right: AppPadding.p16,
//             bottom: AppPadding.p16,
//         ),
//         child: CustomButton(
//           loading: false,
//           onTap: () {
//             Navigator.pushReplacementNamed(context, Routes.otpRoute);
//           },
//           textButton: AppStrings.continueOption.tr,
//         ),
//       ),
//     );
//   }
// }