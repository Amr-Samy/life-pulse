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
                        labelColor: ColorManager.primary,
                        unselectedLabelColor: const Color.fromARGB(255, 131, 127, 127),

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
    // void setupScrollListener() {
    //   scrollController.addListener(() {
    //     if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
    //       if (contactUsController.hasMoreData.value &&
    //           !contactUsController.isLoadMoreLoading.value) { //isPageLoading
    //         contactUsController.getFAQs(
    //           category: "",
    //           items: 5,
    //           isLoadMore: true,
    //         );
    //       }
    //     }
    //   });
    // }
    // setupScrollListener();

    return
      // contactUsController.isPageLoading.value
      //     ? SizedBox(
      //         height: MediaQuery.of(context).size.height / 1.3,
      //         child: const Center(
      //           child: CircularProgressIndicator(),
      //         ))
      //     :
      ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          FaqTile(
            question: 'What is Dona?',
            answer: 'In the bustling city of Dentropolis, Sharky, the tooth-brushing shark superhero, patrolled the streets with a toothbrush in hand and a fin-toothed grin.',
          ),
          FaqTile(
            question: 'How to use Dona?',
            answer: 'Detailed instructions on how to use the Dona app.',
          ),
          FaqTile(
            question: 'Dona is Free?',
            answer: 'Information about the pricing and free features of Dona.',
          ),
          FaqTile(
            question: 'Why use Dona?',
            answer: 'Explanation of the benefits and key features of using Dona.',
          ),
          FaqTile(
            question: 'How I can delete all Dona?',
            answer: 'Instructions on how to delete your data from Dona will be provided here.',
          ),
        ],
      ) ;
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
          /// Whats app
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
              contactUsController.launchLink(url: "https://www.moss.gov.eg/ar-eg/Pages/default.aspx");
            },
          ),
          CustomCard(
            icon: ImageAssets.f,
            title: AppStrings.facebook.tr,
            onTap: () {
              contactUsController.launchLink(url: "https://web.facebook.com/MoSS.Egypt/");
            },
          ),
          CustomCard(
            icon: ImageAssets.x,
            title: AppStrings.x.tr,
            onTap: () {
              contactUsController.launchLink(url: "https://x.com/Moss_Egypt/");
            },
          ),
          CustomCard(
            icon: ImageAssets.i,
            title: AppStrings.instagram.tr,
            onTap: () {
              contactUsController.launchLink(url: "https://www.instagram.com/Moss.Egypt/");
            },
          ),
        ],
      ),
    );
  }
}

class FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const FaqTile({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          title: Text(
            question,
            style: TextStyle(fontWeight: FontWeight.bold, color: theme.textTheme.bodyMedium?.color, fontSize: FontSize.s16),
          ),
          // The content to show when expanded (the answer)
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
              answer,
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
