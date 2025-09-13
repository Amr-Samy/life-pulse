import 'package:life_pulse/presentation/resources/index.dart';

class SettingTile extends StatefulWidget {
  final String? icon;
  final String title;
  final Function()? onTap;
  final Widget? trailing;

  const SettingTile({
    super.key,
    this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
  });

  @override
  State<SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ListTile(
        leading:widget.icon !=null? Image.asset(
          widget.icon ??'',
          width: AppSize.s24,
          color: Theme.of(context).textTheme.displayLarge!.color!,
        ) : null ,

        trailing: widget.trailing,

        title: Text(
            widget.title,
          style: getRegularStyle(
              color: Theme.of(context).textTheme.displayLarge!.color!,
              fontSize: FontSize.s18,
          ),
        ),
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        minLeadingWidth : AppSize.s8,
        onTap: widget.onTap,
      ),
    );
  }
}