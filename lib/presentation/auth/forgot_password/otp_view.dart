// import 'package:flutter_verification_code/flutter_verification_code.dart';
// import 'package:life_pulse/presentation/auth/sign_in/signIn_viewModel.dart';
// import 'package:life_pulse/presentation/resources/index.dart';
// import 'package:life_pulse/presentation/widgets/button.dart';
// import 'package:life_pulse/presentation/widgets/timer.dart';
//
// class OTPScreen extends StatefulWidget {
//   const OTPScreen({super.key});
//
//   @override
//   State<OTPScreen> createState() => _OTPScreenState();
// }
//
// class _OTPScreenState extends State<OTPScreen> with WidgetsBindingObserver{
//   final signInController = Get.find<SignInController>(tag: "SignInController");
//
//   @override
//   void initState() {
//     super.initState();
//     // Add the observer.
//     WidgetsBinding.instance.addObserver(this);
//   }
//   @override
//   void dispose() {
//     // Remove the observer
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//
//     switch (state) {
//       case AppLifecycleState.resumed:
//         FocusManager.instance.primaryFocus?.unfocus();
//         signInController.pasteCodeSink.add(true);
//         break;
//       case AppLifecycleState.inactive:
//         break;
//       case AppLifecycleState.paused:
//         break;
//       case AppLifecycleState.detached:
//         break;
//       case AppLifecycleState.hidden:
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: AppSize.s0,
//         automaticallyImplyLeading: true,
//         title: Text(AppStrings.forgotPassword.tr),
//       ),
//
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: AppPadding.p32),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: AppMargin.m40,),
//
//             //TODO replace with email
//             Text(
//               "${AppStrings.codeSendTo.tr} ${signInController.emailCharacter.value}",
//               style: getLightStyle(
//                   color: Theme.of(context).textTheme.displayLarge!.color!,
//                   fontSize: FontSize.s16),
//             ),
//
//             SizedBox(height: AppMargin.m40,),
//
//             Center(
//               child: VerificationCode(
//                 textStyle: getLightStyle(
//                     color: Theme.of(context).textTheme.displayLarge!.color!,
//                     fontSize: FontSize.s20),
//                 keyboardType: TextInputType.number,
//                 underlineColor: ColorManager.primary,
//                 fullBorder: true,
//                 length: 6,
//                 cursorColor: ColorManager.primary,
//                 onCompleted: (String value) {
//                   print(value);
//                   signInController.code.value = value;
//
//                 },
//                 onEditing: (bool value) {
//
//                 },
//                 digitsOnly: true,
//                 pasteStream:  signInController.pasteCode,
//                 margin: EdgeInsets.symmetric(horizontal: AppMargin.m8),
//                 itemSize: AppSize.s40,
//                 underlineUnfocusedColor: ColorManager.lightGrey,
//                 underlineWidth: 0.2,
//                 fillColor: Theme.of(context).cardColor,
//               ),
//             ),
//
//             SizedBox(height: AppMargin.m40,),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//
//                 Obx(
//                       ()=> Center(
//                     child: GestureDetector(
//                       onTap:signInController.hasTimerStopped.value?
//                           (){
//                             signInController.resendOtp();
//                       } :
//                           (){
//                         Get.snackbar(
//                           AppStrings.wait.tr,
//                           AppStrings.otpErrorM.tr,
//                           backgroundColor: Colors.redAccent,
//                           colorText: Colors.white,
//                           icon: const Icon(Icons.hourglass_top_outlined, color: Colors.white),
//                           snackPosition: SnackPosition.BOTTOM,
//                         );
//                       },
//
//                       child: Text(
//                         AppStrings.resend.tr,
//                         style: TextStyle(
//                           decoration: TextDecoration.underline,
//                           decorationColor: signInController.hasTimerStopped.value
//                               ? ColorManager.primary
//                               : Colors.grey.withOpacity(0.5),
//                           color: signInController.hasTimerStopped.value
//                               ? ColorManager.primary
//                               : Colors.grey.withOpacity(0.5),
//                           fontSize: FontSize.s16,
//                         ),
//
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 Obx(
//                   ()=> Container(
//                     width: 60.0,
//                     padding: const EdgeInsets.only(top: 3.0, right: 4.0),
//                     child: CountDownTimer(
//                       key: ValueKey(signInController.timer.value),
//                       secondsRemaining: signInController.timer.value,
//                       whenTimeExpires: () {
//                         signInController.hasTimerStopped.value = true;
//                       },
//                       countDownTimerStyle: TextStyle(
//                         color: ColorManager.primary,
//                         fontSize: 17.0,
//                         height: 1.2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//           ],
//         ),
//       ),
//
//
//       bottomSheet:  Padding(
//         padding: EdgeInsets.only(
//           left: AppPadding.p16,
//           right: AppPadding.p16,
//           bottom: AppPadding.p16,
//         ),
//         child: CustomButton(
//           loading: false,
//           onTap: () {
//             signInController.checkResetToken();
//           },
//           textButton: AppStrings.continueOption.tr,
//         ),
//       ),
//     );
//   }
// }
