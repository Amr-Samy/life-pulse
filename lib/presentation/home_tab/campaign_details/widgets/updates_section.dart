import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../resources/strings_manager.dart';
import '../../home/models/campaign_model.dart';
import '../campaign_updates_screen.dart';
import '../models/campaign_update_model.dart';
import 'package:intl/intl.dart';


class UpdatesSection extends StatelessWidget {
  final Campaign campaign;
  const UpdatesSection({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    if (campaign.latestUpdate == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text(
           AppStrings.updates.tr,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
            if (campaign.updatesCount != null && campaign.updatesCount! > 1)
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color(0xFFC5E0DE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: () {
                  Get.to(() => CampaignUpdatesScreen(campaignId: campaign.id));
                },
                child: Row(
                  children: [
                     Text(AppStrings.showAllUpdates.tr,style: TextStyle(color: Colors.black87),),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_ios, size: 12),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        UpdateCard(update: campaign.latestUpdate!),
      ],
    );
  }
}

class UpdateCard extends StatefulWidget {
  final CampaignUpdate update;

  const UpdateCard({super.key, required this.update});

  @override
  State<UpdateCard> createState() => _UpdateCardState();
}

class _UpdateCardState extends State<UpdateCard> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Slider
          if (widget.update.images.isNotEmpty) ...[
            SizedBox(
              height: 180,
              child: PageView.builder(
                itemCount: widget.update.images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                      widget.update.images[index],
                width: double.infinity,
                fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            // Indicator
            if (widget.update.images.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.update.images.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    width: _currentImageIndex == index ? 12.0 : 8.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                      color: _currentImageIndex == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),
            const SizedBox(height: 12),
          ],
          Text(
            widget.update.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.update.content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Posted on ${DateFormat.yMMMMd('en_EG').format(widget.update.createdAt)}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
