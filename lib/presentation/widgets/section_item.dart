// import 'package:life_pulse/presentation/resources/index.dart';
// class SectionItem extends StatelessWidget {
//   final String number;
//   final String title;
//   final String duration;
//   final String status;
//   final Function() onTap;
//
//
//
//   const SectionItem({
//     super.key,
//     required this.number,
//     required this.title,
//     required this.duration,
//     required this.status,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       // contentPadding:EdgeInsets.all(AppPadding.p0),
//       onTap: status == 'locked'? (){} : onTap,
//       tileColor: Theme.of(context).cardColor,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(AppSize.s16),
//       ),
//       leading:CircleAvatar(
//         radius: AppSize.s24,
//         backgroundColor: ColorManager.primary.withOpacity(0.1),
//         child: FittedBox(
//           fit: BoxFit.fitWidth,
//           child: Text(
//             number,
//             style: getBoldStyle(
//               color: ColorManager.primary,
//               fontSize: FontSize.s20,
//             ).copyWith(
//               letterSpacing: AppSize.s2
//             ),
//
//           ),
//         ),
//       ),
//
//       title: Text(
//         title ,
//         style: getSemiBoldStyle(
//           color: Get.textTheme.displayLarge!.color!,
//           fontSize: FontSize.s20 ,
//         ),
//         maxLines:1 ,
//         overflow: TextOverflow.ellipsis,
//       ),
//
//       subtitle: Text(
//         '$duration ${AppStrings.min.tr}' ,
//         style: getLightStyle(
//           color: Get.textTheme.displayLarge!.color!,
//           fontSize: FontSize.s16 ,
//         ),
//         maxLines:1 ,
//         overflow: TextOverflow.ellipsis,
//       ),
//
//       trailing: Image.asset(
//         status == 'locked'? ImageAssets.locked : ImageAssets.play ,
//         width: AppSize.s24,
//         height:AppSize.s24,
//         fit: BoxFit.fitWidth,
//         color: status == 'locked'?ColorManager.grey1 : ColorManager.primary,
//       ),
//     );
//   }
// }
