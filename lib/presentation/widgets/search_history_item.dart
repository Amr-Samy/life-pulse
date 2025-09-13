import 'package:life_pulse/presentation/resources/index.dart';
class SearchHistoryItem extends StatelessWidget {
  final String text;
  final Function() onTap;



  const SearchHistoryItem({
    super.key,
    required this.text,
    required this.onTap,
  });

  isDarkMode(){
    return Theme.of(Get.context!).cardColor == ColorManager.lightDark ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:EdgeInsets.all(AppPadding.p0),
      title: Text(
        text ,
        style: getLightStyle(
          color: Get.textTheme.displayLarge!.color!,
          fontSize: FontSize.s20 ,
        ),
        maxLines:1 ,
        overflow: TextOverflow.ellipsis,
      ),

      trailing: GestureDetector(
        onTap: onTap,
        child: Image.asset(
          ImageAssets.close,
          width: AppSize.s24,
          height:AppSize.s24,
          fit: BoxFit.fitWidth,
          color: Get.textTheme.displayLarge!.color!,
        ),
      ),
    );
  }
}
