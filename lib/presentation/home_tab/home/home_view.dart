import 'dart:math' as math;
import 'package:life_pulse/presentation/home_tab/campaign_details/campaign_details_screen.dart';
import 'package:life_pulse/presentation/home_tab/home/widgets/quick_donation_sheet_view.dart';
import '../../layout/layout_controller.dart';
import '../../profile_tab/profile/profile_controller.dart';
import '../../resources/index.dart';
import 'controllers/home_controller.dart';
import 'models/campaign_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final profileController = Get.find<ProfileController>(tag: "ProfileController");
  final homeController = Get.put(HomeController(),tag: "HomeController");
  final layoutController = Get.find<LayoutController>(tag: "LayoutController");

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final shouldLoadMore = !homeController.isLoadingMoreLatest.value &&
        homeController.hasMoreLatest.value &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300;

    if (shouldLoadMore) {
      homeController.loadMoreLatest();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(profileController),
      body: RefreshIndicator(
        onRefresh: _refresh,
        backgroundColor: Theme.of(context).cardColor,
        color: ColorManager.primary,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              // shrinkWrap: true,
              // physics: const BouncingScrollPhysics(),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDonationWalletCard(profileController),
                const SizedBox(height: 24),
                _buildFeatureCampaignTitle(),
                const SizedBox(height: 16),
                _buildFeatureCampaignList(),
                const SizedBox(height: 24),
                _buildLatestCampaigns(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Quick Donation",
        onPressed: () {
          showQuickDonationSheet(context);
        },
        backgroundColor: ColorManager.primary,
        child: Image.asset(
          ImageAssets.quick,
          width: AppSize.s32,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    await homeController.fetchData();
  }

  Widget _buildFeatureCampaignList() {
  const double screenPadding = 0.0;
  const double cardSpacing = 70.0;

    return Obx(() {
      if (homeController.isLoadingFeatured.value && homeController.featuredCampaigns.isEmpty) {
        return const SizedBox(
          height: 480,
          child: Center(child: CircularProgressIndicator()),
        );
      }
      if (homeController.featuredCampaigns.isEmpty) {
        return const SizedBox(
          height: 480,
          child: Center(child: Text("No featured campaigns found.")),
        );
      }

    return SizedBox(
    height: 480,
      child: PageView.builder(
          controller: homeController.pageController,
          onPageChanged: homeController.onPageChanged,
          itemCount: homeController.featuredCampaigns.length +
              (homeController.hasMoreFeatured.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == homeController.featuredCampaigns.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final campaign = homeController.featuredCampaigns[index];
        final double leftPadding = (index == 0) ? screenPadding : (cardSpacing / 2);
            final double rightPadding =
                (index == homeController.featuredCampaigns.length - 1)
                    ? screenPadding
                    : (cardSpacing / 2);

          return AnimatedBuilder(
              animation: homeController.pageController,
            builder: (context, child) {
              double value = 0.0;
                if (homeController.pageController.position.haveDimensions) {
                  value = index.toDouble() - (homeController.pageController.page ?? 0);
      value = (value * 0.05).clamp(-1, 1);
              }

    double scale = 1.0 - (value.abs() * 0.15);
    scale = scale.clamp(0.92, 1.0);

              return Transform.rotate(
      angle: math.pi * value * 0.5,
                  child: Transform.scale(scale: scale, child: child),
              );
              },
          child: Padding(
    padding: EdgeInsets.only(
      left: leftPadding,
      right: rightPadding,
      top: 40,
      bottom: 40,
    ),
                child: Obx(
                    () {
                  bool isSelected = homeController.currentCampaignIndex.value == index;

                  return CampaignCard(campaign: campaign, isSelected: isSelected);
            }),
              ),
            );
          },
        ),
    );
    });
  }

  Widget _buildLatestCampaigns() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Campaign',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Obx(() {
            if (homeController.isLoadingLatest.value && homeController.latestCampaigns.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            if (homeController.latestCampaigns.isEmpty) {
              return const Center(child: Text("No latest campaigns found."));
            }
            return Column(
              children: [
                GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeController.latestCampaigns.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              childAspectRatio: 0.7, //! card height
              ),
              itemBuilder: (context, index) {
                final campaign = homeController.latestCampaigns[index];
                return LatestCampaignCard(campaign: campaign);
              },
                ),
                // Show loading indicator at the bottom if loading more
                Obx(() {
                  if (homeController.isLoadingMoreLatest.value) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            );
          }),
        ],
      ),
    );
  }

  void showQuickDonationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return const DonationBottomSheet();
      },
    );
  }
}

AppBar _buildAppBar(ProfileController profileController) {
    return AppBar(
      elevation: 0,
      backgroundColor: ColorManager.lightGreenColor,

      automaticallyImplyLeading: false,
      titleSpacing: 25,
      title: Row(
      children: [
        Obx(() {
          final imageUrl = profileController.userImage.value;
          if (imageUrl != null && imageUrl.isNotEmpty) {
            return CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.green,
            );
          } else {
            return const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.greenAccent,
              child: Icon(Icons.person, size: 22),

            );
          }
        }),
        const SizedBox(width: 12),
         Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${profileController.userName.value}',
              style: TextStyle(
                  fontSize: 18,
                fontWeight: FontWeight.bold,
                  color: Colors.black87,
              ),
            ),
            // Text(
            //   'Donated \$150K',
            //   style: TextStyle(
            //       color: Colors.black54,
            //       fontSize: 13,
            //     ),
            //   ),
            ],
            )),
          ],
        ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, size: 28),
          color: Colors.black54,
        ),
        const SizedBox(width: 8),
      ],
  );
}

Widget _buildDonationWalletCard(ProfileController profileController) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: ColorManager.lightGreenColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    ImageAssets.wallet,
                    width: AppSize.s24,
                    color: Colors.green,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Donation wallet',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Obx(
                  ()=> Text(
                  "${profileController.walletBalance.value } EGP",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Top up',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
  );
}

Widget _buildFeatureCampaignTitle() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Text(
      'Feature Campaign',
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
          color: Colors.black87,
      ),
    ),
  );
}



class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final bool isSelected;

  const CampaignCard({
    super.key,
    required this.campaign,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor = isSelected ? const Color(0xFFE8F5E9) : const Color(0xFFE3F2FD);
    final Color borderColor = isSelected ? Colors.green : Colors.blue;
    final Color authorColor = isSelected ? Colors.green : Colors.blue;
    final double progress = campaign.progressPercentage / 100.0;

    return GestureDetector(
      // onTap: () => Get.to(() => CampaignDetailsScreen(campaign: campaign)),
      onTap: () => Get.to(() => CampaignDetailsScreen()),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: campaign.firstImage != null
                  ? Image.network(
                      campaign.firstImage!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported, size: 100),
                    )
                  : Image.asset(
                'assets/images/boarding/boarding1.png',
                height: 150,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    campaign.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // verified by ( case sponsor )
                  Row(
                    children: [
                      const Text('By', style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 4),
                        Text(
                        campaign.creator.name,
                          style: TextStyle(color: authorColor, fontWeight: FontWeight.bold),
                        ),
                      const SizedBox(width: 4),
                        Icon(Icons.check_circle, color: authorColor, size: 16),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // targetAmount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('مُتبقى', style: TextStyle(color: Colors.grey)),
                      Text(
                        "${campaign.remainingAmount.toString()} ج.م " ?? '',
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // progress bar
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey.shade300,
                            color: authorColor,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${campaign.progressPercentage}%',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // donors
                  Row(
                    children: [
                      if (int.parse(campaign.donationsCount) > 0)
                      SizedBox(
                        width: 70,
                        child: Stack(
                          children: [
                            _buildDonorAvatar('assets/images/boarding/boarding3.png'),
                            Positioned(left: 20, child: _buildDonorAvatar('assets/images/boarding/boarding3.png')),
                            Positioned(left: 40, child: _buildDonorAvatar('assets/images/boarding/boarding3.png')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '+${campaign.donationsCount} people donated',
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  if(campaign.isPriority)
                  _buildInfoRow(Icons.star, 'Emergencies'),
                ],
              ),
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonorAvatar(String imagePath) {
    return CircleAvatar(
      radius: 15,
      backgroundImage: AssetImage(imagePath),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}


class LatestCampaignCard extends StatelessWidget {
  final Campaign campaign;

  const LatestCampaignCard({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    final double progress = campaign.progressPercentage / 100.0;
    return GestureDetector(
      // onTap: () => Get.to(() => CampaignDetailsScreen(campaign: campaign)),
      onTap: () => Get.to(() => CampaignDetailsScreen()),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            Expanded(
              flex: 3,
              child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: campaign.firstImage != null
                      ? Image.network(
                          campaign.firstImage!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 80),
                        )
                      : Image.asset(
                          'assets/images/boarding/boarding3.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      campaign.isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: campaign.isFavorited ? Colors.red : Colors.black54,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            ),
            // Content
            Expanded(
              flex: 2,
      child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                children: [
                    Flexible(
                      child: Text(
                    campaign.title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text('By', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    campaign.creator.name,
                          style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                      const SizedBox(width: 4),
                      const Icon(Icons.check_circle, color: Colors.green, size: 14),
                    ],
                  ),
            const SizedBox(height: 6),
                  Row(
                    children: [
                      const Text('Raised', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const Spacer(),
                      Text('${campaign.progressPercentage}%',
                          style:
                              const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey.shade300,
                    color: Colors.green,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
            const SizedBox(height: 4),
                  Row(
                    children: [
                      if (int.parse(campaign.donationsCount) > 0)
                          SizedBox(
                          width: 50,
                          height: 20,
                            child: Stack(
                              children: [
                                _buildDonorAvatar('assets/images/boarding/boarding3.png'),
                                Positioned(left: 12, child: _buildDonorAvatar('assets/images/boarding/boarding3.png')),
                                Positioned(left: 24, child: _buildDonorAvatar('assets/images/boarding/boarding3.png')),
                              ],
                            ),
                          ),
                      Expanded(
                        child: Text(
                          '+${campaign.donationsCount} مُتبرع',
                          style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonorAvatar(String imagePath) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: Colors.white,
        child: CircleAvatar(
        radius: 9,
          backgroundImage: AssetImage(imagePath),
        ),
    );
  }



}
