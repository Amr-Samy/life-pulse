

import '../../layout/layout_controller.dart';
import '../../profile_tab/profile/profile_controller.dart';
import '../../resources/index.dart';
import '../../widgets/input_field.dart';
import 'controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final profileController = Get.find<ProfileController>(tag: "ProfileController");
  final homeController = Get.put(HomeController(),tag: "HomeController");
  final layoutController = Get.find<LayoutController>(tag: "LayoutController");
  @override
  void initState() {
    super.initState();

  }

  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc().add(const Duration(hours: 1));

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        backgroundColor: Theme.of(context).cardColor,
        color: ColorManager.primary,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: SingleChildScrollView(
            child: Column(
              // shrinkWrap: true,
              // physics: const BouncingScrollPhysics(),
              children: [

                SizedBox(height: AppMargin.m16,),
                //App Bar
                Visibility(
                  visible: !isGuest(),
                  child: ListTile(
                    contentPadding:EdgeInsets.all(AppPadding.p0),

                    leading: GestureDetector(
                      onTap: (){layoutController.currentPageIndex.value = 4;},
                      child: CircleAvatar(
                        child: Obx(
                              ()=> profileController.studentImage.isNotEmpty ?
                              ClipRRect(
                                borderRadius: BorderRadius.circular(AppSize.s48),
                                child: Image.network(
                                    AppStrings.baseUrl+(profileController.studentImage.value),
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    ImageAssets.profilePlaceholder,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  );
                },
              ),
            )
          : Image.asset(
                          ImageAssets.profilePlaceholder,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        )
                        ),
                      ),
                    ),

                    title: Text(
                      (now.hour > 12 && now.hour < 24 ) ?
                      AppStrings.goodAfternoon.tr :
                      AppStrings.goodMorning.tr ,
                      style: getRegularStyle(
                          color: Theme.of(context).textTheme.displayLarge!.color!,
                          fontSize: FontSize.s14
                      ),
                    ),

                    subtitle: Obx(
                      ()=> Text(profileController.studentName.value,
                        style: getBoldStyle(
                            color: Theme.of(context).textTheme.displayLarge!.color!,
                            fontSize: FontSize.s16
                        ),
                      ),
                    ),

                    trailing: IntrinsicWidth(
                      child: Transform.translate(
                        offset: Offset(AppPadding.p8, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [

                            IconButton(
                              visualDensity: const VisualDensity(horizontal: -4),
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.notificationsRoute);
                              },
                              icon: Image.asset(
                                ImageAssets.notification,
                                width: AppSize.s24,
                                height:AppSize.s24,
                                fit: BoxFit.fitWidth,
                                color: Get.textTheme.displayLarge!.color!,
                              ),
                            ),
                            IconButton(
                              visualDensity: const VisualDensity(horizontal: -4),
                              onPressed: (){

                              },
                              icon: Image.asset(
                                  ImageAssets.bookmark,
                                width: AppSize.s24,
                                height:AppSize.s24,
                                fit: BoxFit.fitWidth,
                                color: Get.textTheme.displayLarge!.color!,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: AppMargin.m16,),

                //search
                GestureDetector(
                  onTap: (){
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => const SearchView(),
                    //       fullscreenDialog: true,
                    //     )
                    // );
                  },
                  child: AbsorbPointer(
                    child: InputField(
                      controller: searchTextController,
                      prefix: Padding(
                        padding: EdgeInsets.all(AppPadding.p14),
                        child: Image.asset(
                          ImageAssets.search,
                          width: AppSize.s01,
                          height:AppSize.s01,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      hintText: AppStrings.search.tr,
                      inputAction: TextInputAction.search,
                      suffix: Padding(
                        padding: EdgeInsets.all(AppPadding.p14),
                        child: Image.asset(
                            ImageAssets.filter,
                            width: AppSize.s01,
                            height:AppSize.s01,
                            fit: BoxFit.fitWidth,
                        ),
                      ),

                      onChange: (searchTerm){},
                    ),
                  ),
                ),

                SizedBox(height: AppMargin.m16,),

                //carousel
                //todo get use of code and date

                // Obx(
                //     ()=> SizedBox(
                //     child:homeController.offersList.isNotEmpty? Carousel() : const SizedBox.shrink(),
                //   ),
                // ),
                //top tutors
                //TODO Hero Animation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Spot Light",
                      style: getBoldStyle(
                          color: Theme.of(context).textTheme.displayLarge!.color!,
                          fontSize: FontSize.s18
                      ),
                    ),

                  GestureDetector(
                    onTap: (){

                    },
                    child: Text(AppStrings.seeAll.tr,
                      style: getBoldStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s16
                      ),
                    ),
                  ),
                  ],
                ),

                // Most popular Courses
                SizedBox(height: AppMargin.m16,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Urgent Cases",
                      style: getBoldStyle(
                          color: Theme.of(context).textTheme.displayLarge!.color!,
                          fontSize: FontSize.s18
                      ),
                    ),
                    GestureDetector(
                      onTap: (){

                      },
                      child: Text(AppStrings.seeAll.tr,
                        style: getBoldStyle(
                            color: ColorManager.primary,
                            fontSize: FontSize.s16
                        ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {

    return Future.delayed (
      const Duration (seconds: 2),
    );
  }
}
