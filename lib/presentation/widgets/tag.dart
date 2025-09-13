import 'package:life_pulse/presentation/resources/index.dart';

class Tag extends StatelessWidget {
  final String title;
  const Tag({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.blueTransparent.withOpacity(0.15),
      margin: EdgeInsetsDirectional.only(end: AppPadding.p8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p16, vertical: AppPadding.p6),
        child: Text(
          title,
          style: getLightStyle(
              color: ColorManager.primary, fontSize: FontSize.s14),
        ),
      ),
    );
  }
}
