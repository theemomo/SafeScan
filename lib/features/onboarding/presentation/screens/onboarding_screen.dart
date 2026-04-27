import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/di/injection_container.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/features/onboarding/presentation/cubits/onboarding_cubit.dart';
import 'package:safe_scan/features/onboarding/presentation/widgets/onboarding_page_widget.dart';
import 'package:safe_scan/features/settings/presentation/cubits/locale_cubit.dart';
import 'package:safe_scan/l10n/app_localizations.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<OnboardingCubit>(),
      child: const OnboardingScreenContent(),
    );
  }
}

class OnboardingScreenContent extends StatefulWidget {
  const OnboardingScreenContent({super.key});

  @override
  State<OnboardingScreenContent> createState() =>
      _OnboardingScreenContentState();
}

class _OnboardingScreenContentState extends State<OnboardingScreenContent> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishOnboarding() {
    context.read<OnboardingCubit>().completeOnboarding().then((_) {
      context.go('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, int>(
          builder: (context, currentPage) {
            return Column(
              children: [
                // Language toggle at top-right
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<LocaleCubit, Locale>(
                        builder: (context, locale) {
                          final isArabic = locale.languageCode == 'ar';
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildLangButton(
                                  label: 'EN',
                                  isSelected: !isArabic,
                                  onTap: () {
                                    context.read<LocaleCubit>().setLocale(
                                      const Locale('en'),
                                    );
                                  },
                                ),
                                _buildLangButton(
                                  label: 'AR',
                                  isSelected: isArabic,
                                  onTap: () {
                                    context.read<LocaleCubit>().setLocale(
                                      const Locale('ar'),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Pages
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      context.read<OnboardingCubit>().setPage(index);
                    },
                    children: [
                      // Screen 1 — Welcome
                      OnboardingPageWidget(
                        title: l10n.onboardingTitle1,
                        description: l10n.onboardingDesc1,
                        iconContent: _buildScreen1Icon(),
                      ),
                      // Screen 2 — Scan & Detect
                      OnboardingPageWidget(
                        title: l10n.onboardingTitle2,
                        description: l10n.onboardingDesc2,
                        statHighlight: l10n.onboardingHighlight2,
                        statText: l10n.onboardingStat2,
                        iconContent: _buildScreen2Icon(),
                      ),
                      // Screen 3 — Stay Protected
                      OnboardingPageWidget(
                        title: l10n.onboardingTitle3,
                        description: l10n.onboardingDesc3,
                        statHighlight: l10n.onboardingHighlight3,
                        statText: l10n.onboardingStat3,
                        iconContent: _buildScreen3Icon(),
                      ),
                    ],
                  ),
                ),
                // Bottom controls
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip Button
                      if (currentPage < 2)
                        TextButton(
                          onPressed: _finishOnboarding,
                          child: Text(
                            l10n.onboardingSkip,
                            style: TextStyle(
                              color: const Color(0xFF707070),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 60),
                      // Indicators
                      Row(
                        children: List.generate(
                          3,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            height: 8.h,
                            width: currentPage == index ? 24.w : 8.w,
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ),
                      ),
                      // Next / Done Button
                      currentPage == 2
                          ? ElevatedButton(
                              onPressed: _finishOnboarding,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 12.h,
                                ),
                              ),
                              child: Text(
                                l10n.onboardingDone,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : TextButton(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Text(
                                l10n.onboardingNext,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLangButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primaryColor,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // Screen 1: Shield + Search — Welcome to SafeScan
  Widget _buildScreen1Icon() {
    return SizedBox(
      width: 200.w,
      height: 200.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glow circle
          Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.15),
                  AppColors.primaryColor.withOpacity(0.03),
                ],
              ),
            ),
          ),
          // Main shield icon
          Icon(
            Icons.shield_rounded,
            size: 100.sp,
            color: AppColors.primaryColor,
          ),
          // Checkmark inside shield
          Positioned(
            top: 65.h,
            child: Icon(Icons.check_rounded, size: 40.sp, color: Colors.white),
          ),
          // Search icon bottom-right
          Positioned(
            bottom: 10.h,
            right: 10.w,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.search_rounded,
                size: 24.sp,
                color: Colors.white,
              ),
            ),
          ),
          // Link icon top-left
          Positioned(
            top: 15.h,
            left: 15.w,
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.link_rounded,
                size: 20.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Screen 2: Bug + Magnifying glass + Alert — Scan & Detect
  Widget _buildScreen2Icon() {
    return SizedBox(
      width: 200.w,
      height: 200.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glow
          Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.12),
                  AppColors.primaryColor.withOpacity(0.02),
                ],
              ),
            ),
          ),
          // Main search icon
          Icon(
            Icons.manage_search_rounded,
            size: 100.sp,
            color: AppColors.primaryColor,
          ),
          // Bug icon top-right
          Positioned(
            top: 10.h,
            right: 10.w,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.bug_report_rounded,
                size: 22.sp,
                color: Colors.white,
              ),
            ),
          ),
          // Notification bell bottom-left
          Positioned(
            bottom: 10.h,
            left: 15.w,
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_active_rounded,
                size: 20.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          // Domain/globe icon bottom-right
          Positioned(
            bottom: 15.h,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.public_rounded,
                size: 20.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Screen 3: Color-coded results + history + protection
  Widget _buildScreen3Icon() {
    return SizedBox(
      width: 200.w,
      height: 200.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background glow
          Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.12),
                  AppColors.primaryColor.withOpacity(0.02),
                ],
              ),
            ),
          ),
          // Main verified icon
          Icon(
            Icons.verified_user_rounded,
            size: 100.sp,
            color: AppColors.primaryColor,
          ),
          // Green dot — safe
          Positioned(
            top: 20.h,
            left: 20.w,
            child: Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                color: Colors.green.shade400,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(Icons.check, size: 16.sp, color: Colors.white),
            ),
          ),
          // Yellow dot — suspicious
          Positioned(
            top: 10.h,
            right: 30.w,
            child: Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                color: Colors.amber.shade400,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Icon(
                Icons.priority_high,
                size: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
          // Red dot — malicious
          Positioned(
            top: 45.h,
            right: 10.w,
            child: Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.red.withOpacity(0.4), blurRadius: 6),
                ],
              ),
              child: Icon(Icons.close, size: 14.sp, color: Colors.white),
            ),
          ),
          // History icon bottom-left
          Positioned(
            bottom: 10.h,
            left: 20.w,
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history_rounded,
                size: 20.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
