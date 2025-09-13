import 'package:life_pulse/presentation/resources/index.dart';

class CustomCheck extends StatelessWidget {
   CustomCheck({
    super.key,
     required this.checkedValue,
     required this.title,
     required this.onTap,
  });
  bool checkedValue = false;
  String title;
   final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: StatefulBuilder(
          builder: (context,StateSetter stateUpdater) {
            return CheckboxListTile(
              title: Text(
                title,
                style: getRegularStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color!,
                    fontSize: FontSize.s16
                ),
              ),
              visualDensity: const VisualDensity(horizontal: AppPadding.pNegative4),
              value: checkedValue,
              onChanged: (newValue) { stateUpdater(() {
                checkedValue = !checkedValue;
                onTap();
              }); },
              controlAffinity: ListTileControlAffinity.leading,
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s5),
              ),
              side: BorderSide(color: ColorManager.primary,width: AppSize.s2,style: BorderStyle.solid),
            );
          }
      ),
    );
  }
}