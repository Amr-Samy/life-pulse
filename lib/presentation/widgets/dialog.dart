import 'package:life_pulse/presentation/resources/index.dart';

class SuccessDialog extends StatelessWidget {

  final String image;
  final String title;
  final String subTitle;
  final Widget actions;

  const SuccessDialog({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: AppPadding.p20,
        ),

        Stack(
          alignment: Alignment.center,
          children: [
            SvgPicture.asset(ImageAssets.bubbles),
            Image.asset(
              image,
              width: 150,
            ),
          ],
        ),
        SizedBox(
          height: AppPadding.p20,
        ),
        Text(
          title,
          style: getBoldStyle(
              color: ColorManager.primary,
              fontSize: FontSize.s22),
        ),

        SizedBox(
          height: AppPadding.p20,
        ),

        Align(
          alignment: Alignment.center,

          child: Text(
            textAlign: TextAlign.center,
            subTitle,
            style: getSemiBoldStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color!,
                fontSize: FontSize.s16),
          ),
        ),

        SizedBox(
          height: AppPadding.p20,
        ),

        actions,

        SizedBox(
          height: AppPadding.p20,
        ),

      ],
    );
  }
}