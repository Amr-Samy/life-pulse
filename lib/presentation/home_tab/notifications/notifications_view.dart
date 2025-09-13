import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/notification_item.dart';
import 'notifications_controller.dart';
class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> with AutomaticKeepAliveClientMixin {
  final notificationsController = Get.put(NotificationsController(),tag: "NotificationsController");
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _initializeData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  void _initializeData() {
    notificationsController.reset();
    notificationsController.getNotifications();
  }

  void _loadMoreData() {
    // if (!notificationsController.isLoading.value &&
    //     (notificationsController.notificationsResponse?.paging?.next != null)) {
    //   notificationsController.currentPage.value++;
    //   notificationsController.getNotifications(
    //     page: notificationsController.currentPage.value,
    //     appendData: true,
    //   );
    // }
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          AppStrings.notifications.tr,
          style: getBoldStyle(
              color: Theme.of(context).textTheme.displayLarge!.color!,
              fontSize: FontSize.s20
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                  child: Text(
                      AppStrings.today.tr,
                    style: getBoldStyle(
                        color: Theme.of(context).textTheme.displayLarge!.color!,
                        fontSize: FontSize.s18
                    ),
                  ),
                ),
            ),
            Obx(() => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                    // if (index == notificationsController.notificationsList.length) {
                    //   return notificationsController.isLoading.value
                    //   ? const Center(
                    //       child: Padding(
                    //         padding: EdgeInsets.all(16.0),
                    //         child: CircularProgressIndicator(),
                    //       ),
                    //     )
                    //       : const SizedBox.shrink();
                    // }

                  return Padding(
                    padding: EdgeInsets.only(bottom: AppPadding.p16),
                    child: NotificationItem(
                        subtitle: "",
                        onTap: () {  },
                        type: "",
                    ),
                  );
                    },
                childCount: 1,
                ),
            )),
              ],
            ),
          ),
    );
  }
}
