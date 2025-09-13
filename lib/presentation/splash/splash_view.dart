// import 'dart:async';
// import 'package:flutter/services.dart';
//
// import '../resources/index.dart';
//
// //TODO native splash -12 logo size x1 instead of x4
// class SplashView extends StatefulWidget {
//   const SplashView({super.key});
//
//   @override
//   State<SplashView> createState() => _SplashViewState();
// }
//
// class _SplashViewState extends State<SplashView> {
//   Timer? _timer;
//   _startDelay(){
//     _timer = Timer(const Duration(seconds: AppConstants.splashDelay),_goNext);
//   }
//   _goNext(){
//     // Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
//     Navigator.pushReplacementNamed(context, Routes.mainRoute);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     //Hide status bar
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
//     _startDelay();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//     // overlays: SystemUiOverlay.values
//     // );
//     _timer?.cancel();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     isDarkMode(){
//       return Theme.of(context).cardColor == ColorManager.lightDark ? true : false;
//     }
//     return Scaffold(
//       body: Center(child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           const SizedBox(),
//           Image.asset(
//               isDarkMode()? ImageAssets.splashDark : ImageAssets.splashLight,
//             width: MediaQuery.of(context).size.width * 0.9,
//             height: MediaQuery.of(context).size.height /2,
//           ),
//           ColorFiltered(
//             colorFilter: ColorFilter.mode(ColorManager.primary, BlendMode.srcIn),
//             child: Image.asset(
//               ImageAssets.loading,
//               height: 60,
//             ),
//           ),
//         ],
//       )
//         ,),
//     );
//   }
// }
