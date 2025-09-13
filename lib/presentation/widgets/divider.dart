import 'package:life_pulse/presentation/resources/index.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Row(
          children: <Widget>[
            const Expanded(
                child: Divider(indent: 0,endIndent: 0,)
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Text(
                  text,
                style: getRegularStyle(
                    color: Theme.of(context).textTheme.displayLarge!.color!,
                    fontSize: FontSize.s16
                ),
              ),
            ),

            const Expanded(
                child: Divider(indent: 0,endIndent: 0,)
            ),
          ]
      ),
    );
  }
}
