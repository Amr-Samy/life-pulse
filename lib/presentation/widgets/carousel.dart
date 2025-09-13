import 'dart:async';

import 'package:life_pulse/data/model/carousel.dart';
import 'package:life_pulse/presentation/home_tab/home/controllers/home_controller.dart';
import 'package:life_pulse/presentation/resources/index.dart';
import 'package:life_pulse/presentation/widgets/carousel_card.dart';
import 'package:life_pulse/presentation/widgets/dot_indicator.dart';

class Carousel extends StatefulWidget {
  Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final homeController = Get.find<HomeController>(tag: "HomeController");

  late PageController _pageController;
  int _pageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
    next();
    });
  }

  next(){
    ++_pageIndex;
    // if (_pageIndex < homeController.offersList.length) {
    // } else {
    //   _pageIndex = 0;
    // }

    _pageController.animateToPage(
      _pageIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    // Dispose everything
    _pageController.dispose();
    _timer!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [

              // Obx(
              //     () => SizedBox(
              //     height: AppSize.s200,
              //     child: PageView.builder(
              //       physics: const BouncingScrollPhysics(),
              //       onPageChanged: (index) {
              //         setState(() {
              //           _pageIndex = index;
              //         });
              //       },
              //       itemCount: homeController.offersList.length,
              //       controller: _pageController,
              //       itemBuilder: (context, index) => CarouselCard(
              //         title: homeController.offersList[index].name ?? "",
              //         description: homeController.offersList[index].text ?? "",
              //         discountValue: homeController.offersList[index].value?.toInt().toString() ?? "",
              //       ),
              //     ),
              //   ),
              // ),


              //Indicator
              Padding(
                padding: EdgeInsets.only(bottom: AppPadding.p14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ...List.generate(
                    //   homeController.offersList.length,
                    //       (index) => Padding(
                    //     padding: const EdgeInsets.only(right: 4),
                    //     child: DotIndicator(
                    //       isActive: index == _pageIndex,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}