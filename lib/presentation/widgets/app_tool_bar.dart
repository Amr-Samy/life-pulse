import 'package:life_pulse/presentation/resources/index.dart';

class ApplicationToolbar  extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final String? leading;
  final List<Widget> actions;
  const ApplicationToolbar({
    super.key,
    required this.title,
    required this.actions,
    this.leading,
  });

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: leading != null ?  false : true,


      leading: leading != null ? Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Image.asset(
          leading ?? '',
          width: AppSize.s16,
          height:AppSize.s16,
          fit: BoxFit.fitWidth,
        ),
      ) : null,

      title: Text(
        title,
        style: getBoldStyle(
            color: Theme.of(context).textTheme.displayLarge!.color!,
            fontSize: FontSize.s22),
      ),

      actions: actions ,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
