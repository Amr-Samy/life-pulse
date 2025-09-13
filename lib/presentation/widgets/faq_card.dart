import 'package:life_pulse/presentation/resources/index.dart';

class FaqCard extends StatelessWidget {
  final String question;
  final String answer;
  const FaqCard({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s16),
        ),
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
        child: ExpansionTile(
          collapsedIconColor:Theme.of(context).textTheme.displayLarge!.color!,
          shape: const Border(),
          title: Text(
              question,
              style: getSemiBoldStyle(
                  color: Theme.of(context).textTheme.displayLarge!.color!,
                  fontSize: FontSize.s18
              )
          ),
          children: <Widget>[
            Divider(
              height: AppSize.s2,
              thickness: AppSize.s05,
              endIndent: AppPadding.p16,
              indent: AppPadding.p16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
              child: Text(
                  answer,
                  style: getRegularStyle(
                      color: Theme.of(context).textTheme.displayLarge!.color!,
                      fontSize: FontSize.s16
                  ),
                textAlign: TextAlign.start,
              ),
            ),

          ],
        ),
      ),
    );
  }
}