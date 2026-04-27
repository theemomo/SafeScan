import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_scan/core/utils/app_colors.dart';

class OnboardingPageWidget extends StatelessWidget {
  final String title;
  final String description;
  final Widget iconContent;
  final String? statText;
  final String? statHighlight;

  const OnboardingPageWidget({
    super.key,
    required this.title,
    required this.description,
    required this.iconContent,
    this.statText,
    this.statHighlight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Graphic container
          Container(
            height: 300.h,
            width: double.infinity,
            alignment: Alignment.center,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                iconContent,
                // Stats card (only if statText is provided)
                if (statText != null)
                  Positioned(
                    bottom: -20.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withOpacity(0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (statHighlight != null) ...[
                            Text(
                              statHighlight!,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ],
                          Text(
                            statText!,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 60.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF707070),
              fontSize: 15.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
