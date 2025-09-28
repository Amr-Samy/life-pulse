import 'package:share_plus/share_plus.dart';

import '../../../resources/index.dart';

class CampaignHeader extends StatelessWidget {
  final int campaignId;
  final String? imageUrl;
  final bool isFavorited;
  final VoidCallback? onFavoriteTap;
  const CampaignHeader({
    super.key,
    required this.campaignId,
    this.imageUrl,
    this.isFavorited = false,
    this.onFavoriteTap,
  });
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
    return SliverAppBar(
      expandedHeight: 220.0,
      pinned: true,
      backgroundColor: Colors.white,
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
                'https://nabd.kirellos.com/campaigns/$campaignId';
            SharePlus.instance.share(ShareParams(uri: Uri(path: campaignUrl)));
          },
          child: _buildCircularButton(Icons.share_outlined),
        ),

        const SizedBox(width: 8),

        if(!isGuest())
        GestureDetector(
          onTap: onFavoriteTap,
          child: _buildCircularButton(
            isFavorited ? Icons.favorite : Icons.favorite_border,
            color: isFavorited ? Colors.red : Colors.white,
          ),
        ),

        const SizedBox(width: 16),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: imageUrl != null
            ? GestureDetector(
          onTap: () {
            if (imageUrl != null && imageUrl!.isNotEmpty) {
             _showImageDialog(context, imageUrl!);
            }
          },
              child: Image.network(
                  imageUrl!,
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.3),
                        colorBlendMode: BlendMode.darken,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                ),
            )
            : Container(
                color: Colors.grey.shade300,
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