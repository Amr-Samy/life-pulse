import 'package:carousel_slider/carousel_slider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../resources/index.dart';

class CampaignHeader extends StatefulWidget {
  final int campaignId;
  final List<String>? imageUrls;
  final bool isFavorited;
  final VoidCallback? onFavoriteTap;
  const CampaignHeader({
    super.key,
    required this.campaignId,
    this.isFavorited = false,
    this.onFavoriteTap,
    this.imageUrls,
  });

  @override
  State<CampaignHeader> createState() => _CampaignHeaderState();
}

class _CampaignHeaderState extends State<CampaignHeader> {
  int _currentImageIndex = 0;

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: InteractiveViewer(
              panEnabled: true,
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.white, size: 50);
                },
              ),
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final hasImages = widget.imageUrls != null && widget.imageUrls!.isNotEmpty;

    return SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      backgroundColor: const Color(0xFFE0F2F1),
      elevation: 1,
      leading: Center(
        child: GestureDetector(
          onTap: () { Get.back(); },
            child: _buildCircularButton(Icons.arrow_back)
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            final String campaignUrl =
                'https://nabd.kirellos.com/campaigns/${widget.campaignId}';
            SharePlus.instance.share(ShareParams(uri: Uri(path: campaignUrl)));
          },
          child: _buildCircularButton(Icons.share_outlined),
        ),

        const SizedBox(width: 8),

        if(!isGuest())
        GestureDetector(
            onTap: widget.onFavoriteTap,
          child: _buildCircularButton(
              widget.isFavorited ? Icons.favorite : Icons.favorite_border,
              color: widget.isFavorited ? Colors.red : Colors.white,
          ),
        ),

        const SizedBox(width: 16),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: hasImages
            ? Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider.builder(
                    itemCount: widget.imageUrls!.length,
                    itemBuilder: (context, index, realIndex) {
                      final imageUrl = widget.imageUrls![index];
                      return GestureDetector(
          onTap: () {
                          if (imageUrl.isNotEmpty) {
                            _showImageDialog(context, imageUrl);
            }
          },
              child: Image.network(
                          imageUrl,
                        fit: BoxFit.cover,
                          width: double.infinity,
                        color: Colors.black.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 260.0,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      enableInfiniteScroll: widget.imageUrls!.length > 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                ),
                  ),
                  if (widget.imageUrls!.length > 1)
                    Positioned(
                      bottom: 10.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widget.imageUrls!.map((url) {
                          int index = widget.imageUrls!.indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImageIndex == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.4),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
            )
            : Container(
                color: Colors.grey.shade300,
                foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                  image: const AssetImage('assets/images/background_pattern.png'),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                )),
                child:
                    const Icon(Icons.image, size: 100, color: Colors.grey)),
      ),
    );
  }

  Widget _buildCircularButton(IconData icon, {Color? color}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color ?? Colors.white, size: 22),
    );
  }
}