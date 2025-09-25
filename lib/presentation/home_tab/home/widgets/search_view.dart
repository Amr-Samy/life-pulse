import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:life_pulse/presentation/home_tab/home/controllers/compain_search_controller.dart';
import 'package:life_pulse/presentation/home_tab/home/home_view.dart';
import 'package:life_pulse/presentation/resources/strings_manager.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final CampaignSearchController searchController = Get.put(CampaignSearchController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300) {
      searchController.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    Get.delete<SearchController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: searchController.searchEditingController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: AppStrings.search.tr,
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.shade600),
            ),
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
            onChanged: searchController.onSearchChanged,
          ),
        ),
      ),
      body: Obx(() {
        if (searchController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (searchController.searchEditingController.text.isEmpty) {
          return Center(child: Text(AppStrings.startSearch.tr));
        }
        if (searchController.searchResults.isEmpty) {
          return Center(
              child: Text("${AppStrings.noResultFound.tr} '${searchController.searchEditingController.text}'."));
        }

        return GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16.0),
          itemCount: searchController.searchResults.length + (searchController.isLoadingMore.value ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.55,
          ),
          itemBuilder: (context, index) {
            if (index == searchController.searchResults.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final campaign = searchController.searchResults[index];
            return LatestCampaignCard(campaign: campaign);
          },
        );
      }),
    );
  }
}
