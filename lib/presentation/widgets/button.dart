import 'package:flutter/material.dart';
import 'package:life_pulse/presentation/resources/index.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.textButton,
    required this.onTap,
    this.color,
    this.icon,
    this.fontSize,
    this.textColor,
    this.loading
  });
  final String textButton;
  final String? icon;
  bool? loading = false;
  final double? fontSize;
  var onTap;
  Color? color = ColorManager.primary;
  Color? textColor = ColorManager.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.sp),
          ),
          backgroundColor: color,
          minimumSize: Size.fromHeight(48.sp),
          elevation: 0,
        ),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon !=null ? Padding(
              padding: EdgeInsetsDirectional.only(end: AppPadding.p8),
              child: Image.asset(
                icon!,
                width: AppSize.s16,
                height: AppSize.s16,
                color: ColorManager.white ,
              ),
            ) : const SizedBox.shrink(),

            // loading != null ? Padding(
            //   padding: EdgeInsetsDirectional.only(end: AppPadding.p8),
            //   child: CircularProgressIndicator(color: color != ColorManager.primary ? ColorManager.primary :ColorManager.white,),
            // ) : const SizedBox.shrink(),

            loading == false ?
            Text(
              textButton,
              style: TextStyle(
                color: textColor ?? ColorManager.white,
                fontSize: fontSize ?? 18.sp,
              ),
            ) : CircularProgressIndicator(color: ColorManager.white,),

          ],
        ),
      ),
    );
  }
}
