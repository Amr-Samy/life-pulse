import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/filter.dart';
class InviteFriendItem extends StatelessWidget {
  final String image;
  final String name;
  final String phone;
  final bool isInvited;
  final Function() onTap;


  const InviteFriendItem({
    super.key,
    required this.image,
    required this.name,
    required this.onTap,
    required this.phone,
    required this.isInvited,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:EdgeInsets.all(AppPadding.p0),
      leading:GestureDetector(
        child:  CircleAvatar(
          radius: AppSize.s32,
          child: Image.asset(image),
        ),
      ),

      title: Text(
        name ,
        style: getSemiBoldStyle(
          color: Get.textTheme.displayLarge!.color!,
          fontSize: FontSize.s20 ,
        ),
        maxLines:1 ,
        overflow: TextOverflow.ellipsis,
      ),

      subtitle: Text(
        phone ,
        style: getLightStyle(
          color: Get.textTheme.displayLarge!.color!,
          fontSize: FontSize.s16 ,
        ),
        maxLines:1 ,
        overflow: TextOverflow.ellipsis,
      ),

      trailing: IntrinsicWidth(
        child: ToggleButton(
          text: isInvited ? AppStrings.invited.tr : AppStrings.invite.tr,
          isSelected: !isInvited,
          onTap: onTap,
        ),
      ),
    );
  }
}
