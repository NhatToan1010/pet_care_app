import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_care_app/feature/authentication/controllers/onboading_controller.dart';
import 'package:pet_care_app/feature/authentication/views/onboarding/widgets/onboarding_page.dart';
import 'package:pet_care_app/utils/constants/colors.dart';
import 'package:pet_care_app/utils/constants/sizes.dart';
import 'package:pet_care_app/utils/constants/texts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSize.defaultSpace),
        child: Column(
          children: [
            // --- Onboarding Page
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.updatePageIndex,
                children: [
                  OnboadingPage(
                    title: LocalTexts.onboardingTitle1,
                    subtitle: LocalTexts.onboardingSubtitle,
                    imageUrl: 'assets/images/onboarding/onboading_1.png',
                  ),
                  OnboadingPage(
                    title: LocalTexts.onboardingTitle2,
                    subtitle: LocalTexts.onboardingSubtitle,
                    imageUrl: 'assets/images/onboarding/onboading_2.png',
                  ),
                  OnboadingPage(
                    title: LocalTexts.onboardingTitle3,
                    subtitle: LocalTexts.onboardingSubtitle,
                    imageUrl: 'assets/images/onboarding/onboading_3.png',
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Dot Indicator
            SmoothPageIndicator(
              controller: controller.pageController,
              count: 3,
              onDotClicked: controller.dotNavigationClicked,
              effect: ExpandingDotsEffect(
                activeDotColor: AppPallete.blackColor,
                dotHeight: 8.0,
                dotColor: AppPallete.greyColor,
              ),
            ),
            SizedBox(height: AppSize.spaceBtwSections),

            // --- Button
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.nextPage(),
                  child: Text(controller.currentPageIndex.value == 2
                      ? 'Hoàn Tất'
                      : 'Tiếp tục'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
