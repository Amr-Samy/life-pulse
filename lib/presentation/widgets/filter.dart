import '../resources/index.dart';

class ToggleButton extends StatelessWidget {
  final String? text;
  final String? icon;
  final bool isSelected;
  final Function()? onTap;

  const ToggleButton({
    super.key,
    required this.text,
    required this.isSelected,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s100),
          side: BorderSide(
              color: ColorManager.primary,width: AppSize.s2,style: BorderStyle.solid
          ),
        ),
        backgroundColor: isSelected?ColorManager.primary : Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon !=null ? Padding(
            padding: EdgeInsetsDirectional.only(end: AppPadding.p8),
            child: Image.asset(
              icon!,
              width: AppSize.s16,
              height: AppSize.s16,
              color: isSelected? ColorManager.white : ColorManager.primary,
            ),
          ) : const SizedBox.shrink(),

          Text(
            text??"",
            style: getRegularStyle(
              fontSize: FontSize.s16,
              color: isSelected? ColorManager.white : ColorManager.primary,
            ),
          ),
        ],
      ),
    );
  }
}
