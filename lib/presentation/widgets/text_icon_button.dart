import 'package:life_pulse/presentation/resources/index.dart';

class TextIconButton extends StatelessWidget {
  TextIconButton({
    super.key,
    required this.textButton,
    required this.onTap,
    required this.icon,
  });
  final String textButton;
  final String icon;
  var onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16),
            side: BorderSide(color: ColorManager.grey,width: 0.5),
          ),
          backgroundColor: Theme.of(context).cardColor,
          minimumSize: Size.fromHeight(AppSize.s50),
          elevation: AppSize.s0,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              width: AppSize.s24,
              height: AppSize.s24,
            ),
            SizedBox(width: AppPadding.p8,),
            Text(
              textButton,
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
