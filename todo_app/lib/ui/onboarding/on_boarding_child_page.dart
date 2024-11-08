import 'package:flutter/material.dart';
import 'package:todo_app/ultils/enums/onboarding_page_position.dart';

class OnboardingChildPage extends StatelessWidget {
  final OnboardingPagePosition onboardingPagePosition;
  //page controller
  final VoidCallback nextOnPressed;
  final VoidCallback backOnPressed;
  final VoidCallback skipOnPressed;

  const OnboardingChildPage(
      {super.key,
      required this.onboardingPagePosition,
      required this.nextOnPressed,
      required this.backOnPressed,
      required this.skipOnPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildSkipButton(),
              _buildOnboardingImage(),
              _buildOnboardingPageControl(),
              _buildOnboardingTitleAndContent(),
              _buildOnboardingNextAndBackButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: const EdgeInsets.only(top: 14),
      child: TextButton(
        onPressed: skipOnPressed,
        child: Text(
          "SKIP",
          style: TextStyle(
              fontSize: 16,
              fontFamily: "Lato",
              color: Colors.white.withOpacity(0.44)),
        ),
      ),
    );
  }

  Widget _buildOnboardingImage() {
    return Image.asset(
      onboardingPagePosition.onboardingPageImage(),
      height: 296,
      width: 271,
      fit: BoxFit.contain,
    );
  }

  Widget _buildOnboardingPageControl() {
    /**
     * highlight page control
     */
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page1
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(56)),
          ),
          Container(
            height: 4,
            width: 26,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page2
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(56)),
          ),
          Container(
            height: 4,
            width: 26,
            decoration: BoxDecoration(
                color: onboardingPagePosition == OnboardingPagePosition.page3
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(56)),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingTitleAndContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              onboardingPagePosition.onboardingPageTitle(),
              style: TextStyle(
                  color: Colors.white.withOpacity(0.87),
                  fontFamily: "Lato",
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 42),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              onboardingPagePosition.onboardingPageContent(),
              style: TextStyle(
                color: Colors.white.withOpacity(0.87),
                fontFamily: "Lato",
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnboardingNextAndBackButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24)
          .copyWith(top: 107, bottom: 24),
      child: Row(
        children: [
          TextButton(
              onPressed: () {
                backOnPressed();
              },
              child: Text(
                "BACK",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Lato",
                    color: Colors.white.withOpacity(0.44)),
              )),
          const Spacer(),
          ElevatedButton(
              onPressed: () {
                //C1
                nextOnPressed.call();
                //C2: next
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8875FF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: Text(
                onboardingPagePosition == OnboardingPagePosition.page3
                    ? "GET STARTED"
                    : "NEXT",
                style: const TextStyle(
                    fontSize: 16, fontFamily: "Lato", color: Colors.white),
              )),
        ],
      ),
    );
  }
}
