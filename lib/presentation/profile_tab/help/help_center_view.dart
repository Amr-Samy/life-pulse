import 'dart:io';

import 'package:life_pulse/presentation/profile_tab/help/help_center_controller.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/custom_card.dart';
import 'package:life_pulse/presentation/widgets/faq_card.dart';
import 'package:life_pulse/presentation/widgets/filter.dart';

class HelpCenterView extends StatefulWidget {
  const HelpCenterView({super.key});

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> with SingleTickerProviderStateMixin {
  final contactUsController = Get.put(ContactUsController(), tag: "ContactUsController");
  TabController? _controller;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    contactUsController.getContacts();
    contactUsController.getFaqCategories();
    contactUsController.getFAQs(category: "");
    _controller = TabController(length: 2, vsync: this);
    _controller?.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplicationToolbar(
        title: AppStrings.helpCenter.tr,
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: AppPadding.p16, left: AppPadding.p16, right: AppPadding.p16),
        child: SafeArea(
          child: CustomScrollView(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            slivers: [
              //tab bar
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        width: AppSize.s02,
                        color: ColorManager.grey1,
                      )),
                    ),
                    child: TabBar(
                        controller: _controller,
                        onTap: (index) {
                          //TODO never does that
                          setState(() {});
                        },
                        labelPadding: const EdgeInsets.all(0),
                        isScrollable: false,
                        indicatorColor: ColorManager.primary,
                        labelColor: ColorManager.primary, //<-- selected text color
                        unselectedLabelColor: const Color.fromARGB(255, 131, 127, 127), //<--

                        tabs: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.44,
                            child: Tab(
                              text: AppStrings.faq.tr,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.44,
                            child:  Tab(
                              text: AppStrings.contactUs.tr,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                  child: SizedBox(
                height: AppPadding.p16,
              )),

              //Tabs
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: TabBarView(
                      // index: _selectedIndex,
                      controller: _controller,
                      children: const [
                        // first tab bar view widget
                        FaqTab(),
                        // second tab bar view widget
                        ContactUsTab(),
                      ]),
                ),
              ),

              SliverToBoxAdapter(
                  child: SizedBox(
                height: AppPadding.p16,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class FaqTab extends StatelessWidget {
  const FaqTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final contactUsController = Get.find<ContactUsController>(tag: "ContactUsController");
    final scrollController = ScrollController();
    void setupScrollListener() {
      scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          if (contactUsController.hasMoreData.value &&
              !contactUsController.isLoadMoreLoading.value) { //isPageLoading
            contactUsController.getFAQs(
              category: "",
              items: 5,
              isLoadMore: true,
            );
          }
        }
      });
    }

    setupScrollListener();

    return Obx(
      () => contactUsController.isPageLoading.value
          ? SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ))
          : Column(
              children: [
                ///Filters
                Obx(
                  () => SizedBox(
                    height: AppSize.s40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => ToggleButton(
                            text: "q",
                            isSelected: index ==1? true : false,
                            onTap: () {

                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(width: AppPadding.p8),
                      itemCount: 3,
                    ),
                  ),
                ),
                SizedBox(height: AppPadding.p16),
                // * FAQ //
                Expanded(
                  //NotificationListener<ScrollNotification>
                  child: ListView.separated(
                    key: const ValueKey('controllerA'),
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: contactUsController.faqsList.length +
                            ((contactUsController.hasMoreData.value && contactUsController.isLoadMoreLoading.value) ? 1 : 0),

                    scrollDirection: Axis.vertical,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index >= contactUsController.faqsList.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return FaqCard(
                        question: contactUsController.faqsList[index].question ?? "",
                        answer: contactUsController.faqsList[index].answer ?? "",
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: AppPadding.p16),
                  ),
                ),
                SizedBox(height: AppPadding.p16),

              ],
            ),
    );
  }
}

class ContactUsTab extends StatelessWidget {
  const ContactUsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final contactUsController = Get.find<ContactUsController>(tag: "ContactUsController");
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          CustomCard(
            icon: ImageAssets.service,
            title: AppStrings.customerService.tr,
            onTap: () {
              Get.toNamed(Routes.supportChatView);
            },
          ),
          CustomCard(
            icon: ImageAssets.whatsapp,
            title: AppStrings.whatsApp.tr,
            onTap: () {
              String url() {
                if (Platform.isAndroid) {
                  return "https://wa.me/${contactUsController.contactUs?.whatsapp}/?text=${Uri.parse("Hello!")}";
                } else {
                  return "https://api.whatsapp.com/send?phone=${contactUsController.contactUs?.whatsapp}=${Uri.parse("Hello!")}";
                }
              }

              contactUsController.launchLink(url: url());
            },
            leadingWidth: AppSize.s28,
            leadingHeight: AppSize.s28,
          ),
          CustomCard(
            icon: ImageAssets.web,
            title: AppStrings.website.tr,
            onTap: () {
              contactUsController.launchLink(url: contactUsController.contactUs?.website);
            },
          ),
          CustomCard(
            icon: ImageAssets.f,
            title: AppStrings.facebook.tr,
            onTap: () {
              contactUsController.launchLink(url: contactUsController.contactUs?.facebook);
            },
          ),
          CustomCard(
            icon: ImageAssets.x,
            title: AppStrings.x.tr,
            onTap: () {
              contactUsController.launchLink(url: contactUsController.contactUs?.twitter);
            },
          ),
          CustomCard(
            icon: ImageAssets.i,
            title: AppStrings.instagram.tr,
            onTap: () {
              contactUsController.launchLink(url: contactUsController.contactUs?.instagram);
            },
          ),
        ],
      ),
    );
  }
}
