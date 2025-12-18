import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/features/scan/domain/entities/file_response_model.dart';
import 'package:safe_scan/features/scan/presentation/widgets/circle_indicator.dart';
import 'package:safe_scan/features/scan/domain/entities/file_response_model.dart'
    as file_model;

class FileReportScreen extends StatelessWidget {
  final FileResponseModel reportData;
  const FileReportScreen({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    final attributes = reportData.data!.attributes;

    final stats = attributes.lastAnalysisStats;
    final harmless = stats?.harmless ?? 0;
    final malicious = stats?.malicious ?? 0;

    final results = attributes.lastAnalysisResults ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svgs/shield.svg',
              height: 24.h,
              width: 24.w,
            ),
            Text(
              'Safe',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Scan',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SvgPicture.asset(
              'assets/svgs/search.svg',
              height: 18.75.h,
              width: 20.76.w,
              color: const Color(0xFF707070),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Text('Menu')),
            GestureDetector(
              onTap: () {},
              child: const ListTile(title: Text('Page A')),
            ),
            GestureDetector(
              onTap: () {
                BlocProvider.of<AuthCubit>(context).logout();
              },
              child: const ListTile(title: Text('Logout')),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          /// HEADER
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(Icons.arrow_back, size: 24.sp),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Report for ${attributes.meaningfulName ?? "Unknown file"}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text('Scan completed', style: TextStyle(fontSize: 10.sp)),
                  ],
                ),
              ],
            ),
          ),

          /// CONTENT
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// SUMMARY CARD
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(16.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E5E5)),
                    ),
                    child: Column(
                      children: [
                        CircleIndicator(
                          harmless: harmless,
                          malicious: malicious,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          malicious == 0
                              ? "This file appears to be clean"
                              : "$malicious security vendors flagged this file as malicious",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "$malicious / ${harmless + malicious} detections",
                          style: TextStyle(fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ),

                  /// SUMMARY CARD
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: 0.h,
                      bottom: 12.h,
                      right: 16.w,
                      left: 16.w,
                    ),
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E5E5)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "File Size",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: const Color(0xFF707070),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              reportData.data!.attributes.size.toString(),
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 15.sp),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "File Type",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFF707070),
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              reportData.data!.attributes.typeTag.toUpperCase(),
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// VENDOR RESULTS
                  ...results.values.map((item) {
                    final vendorName = item.engineName ?? 'Unknown vendor';
                    final detected =
                        item.category ?? file_model.Category.undetected;
                    final result = item.result?.name ?? 'unknown';

                    Color color;
                    IconData icon;
                    String label;

                    switch (detected) {
                      case file_model.Category.malicious:
                        color = Colors.red;
                        icon = Icons.warning_amber_rounded;
                        label = 'Malicious';
                        break;
                      case file_model.Category.suspicious:
                        color = Colors.orange;
                        icon = Icons.dangerous_rounded;
                        label = 'Suspicious';
                        break;
                      default:
                        color = Colors.green;
                        icon = Icons.check_circle_outline;
                        label = 'Clean';
                    }

                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 4.h,
                      ),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E5E5)),
                      ),
                      child: ListTile(
                        trailing: Icon(icon, color: color, size: 26.r),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                vendorName.length > 20
                                    ? '${vendorName.substring(0, 20)}...'
                                    : vendorName,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: color),
                              ),
                              child: Text(
                                label,
                                style: TextStyle(fontSize: 10.sp, color: color),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          result,
                          style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
