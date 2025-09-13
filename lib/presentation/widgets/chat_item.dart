import 'package:life_pulse/presentation/resources/index.dart';
class ChatItem extends StatelessWidget {
  final String image;
  final String name;
  final String field;
  final bool isAllowedToChat;
  final Function() onTap;
  final Function()? onChatTap;



  const ChatItem({
    super.key,
    required this.image,
    required this.name,
    required this.field,
    required this.onTap,
    required this.isAllowedToChat,
    this.onChatTap,
  });

  isDarkMode(){
    return Theme.of(Get.context!).cardColor == ColorManager.lightDark ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:EdgeInsets.all(AppPadding.p0),
      onTap: onTap,
      leading:GestureDetector(
        child:  CircleAvatar(
          radius: AppSize.s28,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.s32),
            child: Image.network(
                image,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
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
        field ,
        style: getLightStyle(
          color: Get.textTheme.displayLarge!.color!,
          fontSize: FontSize.s16 ,
        ),
        maxLines:1 ,
        overflow: TextOverflow.ellipsis,
      ),

      trailing: GestureDetector(
        onTap: onChatTap ?? (){},
        child: Image.asset(
          ImageAssets.chat,
          width: AppSize.s24,
          height:AppSize.s24,
          fit: BoxFit.fitWidth,
          color: isAllowedToChat? ColorManager.primary : ColorManager.grey1,
        ),
      ),
    );
  }
}
