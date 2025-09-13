import 'package:life_pulse/presentation/resources/index.dart';

class PopUpMenuItem extends StatelessWidget {
  final String icon;
  final String title;

  const PopUpMenuItem({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
            Get.textTheme.displayLarge!.color!,
            BlendMode.srcIn
        ),
        child: IntrinsicWidth(
          child: Row(
            children: [
              Image.asset(
                icon,
                width: AppSize.s24,
                height:AppSize.s24,
                fit: BoxFit.fitWidth,
                color: Get.textTheme.displayLarge!.color!,
              ),

              SizedBox(width: AppPadding.p8,),

              Text(
                title,
                style: getLightStyle(
                    color: Get.textTheme.displayLarge!.color!,
                    fontSize: FontSize.s16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}