import 'package:life_pulse/presentation/resources/index.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final String icon;
  var onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .2,
        height: MediaQuery.of(context).size.width * .15,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s16),
              side: BorderSide(color: ColorManager.grey,width: 0.2),
            ),
            backgroundColor: Theme.of(context).cardColor,
            minimumSize: Size.fromHeight(AppSize.s50),
            elevation: AppSize.s0,
          ),
          onPressed: onTap,
          child: Image.asset(
            icon,
            width: AppSize.s24,
            height: AppSize.s24,
          ),
        ),
      ),
    );
  }
}
