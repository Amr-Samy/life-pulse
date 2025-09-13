import 'package:life_pulse/presentation/resources/index.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String? leading;
  final String? title;
  final String? subtitle;
  final bool? showRadio;
  final double? leadingWidth;
  final double? leadingHeight;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.leading,
    this.title,
    this.subtitle,
    this.leadingWidth,
    this.leadingHeight,
    this.showRadio,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s16),
              color: Theme.of(context).cardColor,
              border: Border.all(
                  color: isSelected
                      ? ColorManager.primary
                      : Colors.grey,
                  width: isSelected? 2 : 0.1,
              )
          ),
        child: Row(

          children: [
            //leading
            leading != null? _customRadioButton : SizedBox(width: AppPadding.p16,),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                  style: getLightStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color!,
                  fontSize: FontSize.s14),
                  ),
                  if (subtitle != null)
                  Text(
              subtitle!,
                   style: getRegularStyle(
                   color: Theme.of(context).textTheme.displayLarge!.color!,
                   fontSize: FontSize.s16),
                   ),
                ],
              ),
            ),
            showRadio != null ? Radio(
              fillColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? ColorManager.primary
                  : ColorManager.primary
              ),
                value: value,
                groupValue: groupValue,
                onChanged: (value) => onChanged(value),
                )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p16),
      child: Image.asset(leading??'' ,width:leadingWidth?? AppSize.s100,height:leadingHeight?? AppSize.s80),
    );
  }
}