import 'package:flutter/material.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/campaign_header.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/campaign_info_card.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/content_section.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/summary_stats_section.dart';
import 'package:life_pulse/presentation/home_tab/campaign_details/widgets/updates_section.dart';

class CampaignDetailsScreen extends StatelessWidget {
  const CampaignDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      body: CustomScrollView(
        slivers: [
          ///Header Image with action buttons
          CampaignHeader(),
          // Main content
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Campaign Info Card
                  CampaignInfoCard(),
                  SizedBox(height: 24),
                  ///Story Section
                  ContentSection(
                    title: 'Story',
                    content:
                    'We are a national charity working to transform the hopes and happiness of young people facing abuse, exploitation and neglect. We support them through their most serious life challenges, and we campaign tirelessly for the big social changes that will improve the lives of those who need hope most.',
                    imageUrl: 'https://i.imgur.com/G5voCFN.png',
                  ),
                  SizedBox(height: 24),
                  ///About Section
                  ContentSection(
                    title: 'About Unesco',
                    content:
                    'The United Nations Educational, Scientific and Cultural Organization is a specialized agency of the United Nations with the aim of promoting world peace and security through international cooperation in education, arts, sciences and culture.',
                  ),
                  SizedBox(height: 24),
                  ///Posts section
                  UpdatesSection(),
                  SizedBox(height: 24),
                  /// Summary Stats
                  SummaryStatsSection(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}