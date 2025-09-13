import 'package:life_pulse/presentation/resources/index.dart';

class ReceiptRowItem extends StatelessWidget {
  final String text;
  final String value;
  final Widget? trailing;
  const ReceiptRowItem({
    super.key, required this.text, required this.value, this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: getLightStyle(
                color: Theme.of(context).textTheme.displayLarge!.color!,
                fontSize: FontSize.s16),
          ),

          Row(
            children: [
              Text(
                value,
                style: getRegularStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color!,
                    fontSize: FontSize.s16),
                overflow: TextOverflow.ellipsis,
              ),
              trailing != null ? trailing! : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}