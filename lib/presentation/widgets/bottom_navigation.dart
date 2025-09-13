import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/button.dart';

class BottomNavigation extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color? color;
  const BottomNavigation({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 8,top: 8),
        width: double.infinity,
        height: AppSize.s100,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:  BorderRadiusDirectional.only(
              topStart: Radius.circular(AppSize.s16),
              topEnd: Radius.circular(AppSize.s16),
              bottomEnd: Radius.circular(AppSize.s0),
              bottomStart: Radius.circular(AppSize.s0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]
        ),

        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: AppSize.s40,
          margin: EdgeInsets.only(bottom: AppPadding.p16,top: AppPadding.p16),
          child: CustomButton(
            loading: false,
            textButton: text,
            onTap: onTap,
            color: color,
          ),
        )
    );
  }
}