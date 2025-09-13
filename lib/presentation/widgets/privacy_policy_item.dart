import 'package:life_pulse/presentation/resources/index.dart';

class PrivacyPolicyItem extends StatelessWidget {
  final String title;
  final String description;
  const PrivacyPolicyItem({
    super.key, required this.title, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppPadding.p16,),
          child: Text(
            title,
            style: getSemiBoldStyle(
                color: Theme.of(context).textTheme.displayLarge!.color!,
                fontSize: FontSize.s20),
          ),
        ),

        Text(
          description,
          style: getLightStyle(
              color: ColorManager.lightGrey,
              fontSize: FontSize.s16
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}