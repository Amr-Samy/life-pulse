import 'package:life_pulse/presentation/resources/index.dart';
import 'package:intl/intl.dart';
class MessageItem extends StatefulWidget {
  final int index;
  final int id;
  final int? unreadCount;
  final String type;
  final String userName;
  final String? userImage;
  final String lastMessage;
  final String lastMessageTime;
  final VoidCallback? onTap;
  final VoidCallback ? onDelete;
  final VoidCallback ? onArchive;
  bool isRead;
  bool isArchived;

  MessageItem({
    super.key,
    required this.index,
    required this.userName,
    this.userImage,
    required this.lastMessage,
    required this.lastMessageTime,
    this.onTap,
    required this.isRead,
    required this.isArchived,
    this.onDelete,
    this.onArchive,
    required this.id,
    required this.type,
    this.unreadCount,
  });
  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {

  // bool isSelected = false;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState(() {
          // isSelected = !isSelected;
          widget.isRead= true;
          selectedIndex = widget.index;
        });

      },
      child: Container(
        color: widget.isRead
            ? Theme.of(context).scaffoldBackgroundColor
            : Theme.of(context).cardColor,
        child: ListTile(

          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Visibility(
                visible: !widget.isRead,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: AppSize.s12,
                      backgroundColor: ColorManager.primary,
                    ),
                    Text(
                      //unread messages count
                      widget.unreadCount.toString() ?? "" ,
                      style: getRegularStyle(
                          color: ColorManager.white,
                          fontSize: FontSize.s12
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: !widget.isRead? AppSize.s8 : AppSize.s0,),

              Text(
                DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.lastMessageTime)),
                style: getRegularStyle(
                    color: Get.textTheme.displayLarge!.color!,
                    fontSize: FontSize.s14
                ),
              ),
            ],
          ),
          leading:  CircleAvatar(radius: 25,
            backgroundColor: Colors.black26,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.s40),
                child: Image.network(
                    widget.userImage!,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                )
            ),
          ),

          title: Text(
            widget.userName,
            style: getSemiBoldStyle(
            color: Get.textTheme.displayLarge!.color!,
            fontSize: FontSize.s16
              ),
            ),

          subtitle: Text(widget.lastMessage ,maxLines: 1,overflow: TextOverflow.ellipsis,),
        ),
      ),
    );
  }
}
