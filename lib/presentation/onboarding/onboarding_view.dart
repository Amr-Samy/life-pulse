import '../resources/index.dart';
import 'package:flutter/services.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  _OnBoardingViewState createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late final PageController _pageController;
  int _currentIndex = 0;

  final List<SliderObject> _list = [
    SliderObject(AppStrings.onBoardingTitle1,
      AppStrings.onBoardingSubTitle1,
      ImageAssets.onboardingLogo2,
      const Color(0xFFE0CDCD),
    ),
    SliderObject(
      AppStrings.onBoardingTitle2,
      AppStrings.onBoardingSubTitle2,
      ImageAssets.onboardingLogo1,
      const Color(0xFFD7EDF4),
    ),
    SliderObject(
      AppStrings.onBoardingTitle3,
      AppStrings.onBoardingSubTitle3,
      ImageAssets.onboardingLogo3,
      const Color(0xFFFDEFD5),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          color: _list[_currentIndex].backgroundColor,
          child: SafeArea(
          child: Stack(
            children: [
                _buildDecorativeShapes(),
                // Page View for Slides
              PageView.builder(
                controller: _pageController,
                itemCount: _list.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnBoardingPage(_list[index]);
                },
              ),

                // Skip Button
              if (_currentIndex != _list.length - 1)
                Positioned(
                  top: AppPadding.p12,
                  right: AppPadding.p20,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, Routes.mainRoute);
                    },
                    child: Text(
                      AppStrings.skip,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: ColorManager.darkGrey,
                      ),
                    ),
                  ),
                ),

                // Bottom Navigation Controls
              Positioned(
                bottom: AppPadding.p20,
                left: AppPadding.p20,
                right: AppPadding.p20,
                child: _buildBottomControls(),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }


  Widget _buildDecorativeShapes() {
    return Stack(
      children: [
        Positioned(
          top: -MediaQuery.of(context).size.width * 0.3,
          right: -MediaQuery.of(context).size.width * 0.4,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -MediaQuery.of(context).size.width * 0.1,
          left: -MediaQuery.of(context).size.width * 0.2,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              shape: BoxShape.circle,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBottomControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // --- Page Indicator ---
        Row(
          children: [
            for (int i = 0; i < _list.length; i++)
              Padding(
                padding:  EdgeInsets.only(right: AppPadding.p8),
                child: _buildDotIndicator(i),
              )
          ],
        ),

        FloatingActionButton(
          onPressed: () {
            if (_currentIndex == _list.length - 1) {
              Navigator.pushReplacementNamed(context, Routes.mainRoute);
            } else {
              _pageController.nextPage(
                duration: const Duration(milliseconds: AppConstants.sliderAnimationTime),
                curve: Curves.easeInOut,
              );
            }
          },
          backgroundColor: ColorManager.primary,
          child: (_currentIndex == _list.length - 1)
              ? Icon(Icons.check, color: ColorManager.white)
              : Icon(Icons.arrow_forward, color: ColorManager.white),
        ),
      ],
    );
  }

  Widget _buildDotIndicator(int index) {
    bool isActive = index == _currentIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      height: AppSize.s8,
      width: isActive ? AppSize.s24 : AppSize.s8,
      decoration: BoxDecoration(
        color: isActive ? ColorManager.primary : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: Column(
        children: [
          const Spacer(flex: 2),
          Image.asset(
            _sliderObject.image,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          const Spacer(flex: 1),
          Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: ColorManager.darkGrey,
            ),
          ),
           SizedBox(height: AppSize.s12),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppPadding.p8),
            child: Text(
              _sliderObject.subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: ColorManager.grey,
                height: 1.5,
              ),
            ),
          ),

          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

// --- Data Model (Unchanged) ---
class SliderObject {
  String title;
  String subTitle;
  String image;
  Color backgroundColor;

  SliderObject(this.title, this.subTitle, this.image, this.backgroundColor);
}