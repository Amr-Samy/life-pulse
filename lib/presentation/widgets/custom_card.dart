import 'package:life_pulse/presentation/resources/index.dart';

class CustomCard extends StatelessWidget {
  final String icon;
  final String title;
  final double? leadingWidth;
  final double? leadingHeight;
  final Function()? onTap;

  const CustomCard({
    required this.icon,
    required this.title,
    required this.onTap,
    this.leadingWidth,
    this.leadingHeight,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;

    return GestureDetector(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s16),
            color: Theme.of(context).cardColor,
        ),
        margin: EdgeInsets.symmetric(vertical: AppPadding.p12),
        padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
        child: Row(
          children: [
            //leading
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p16),
              child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      ColorManager.primary,
                      BlendMode.srcIn
                  ),
                  child: Image.asset(icon ,width:leadingWidth?? AppSize.s24,height:leadingHeight?? AppSize.s24)),
            ),

            Text(
              title,
              style: getSemiBoldStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color!,
                  fontSize: FontSize.s16
              ),
            ),
          ],
        ),
      ),
    );
  }

}