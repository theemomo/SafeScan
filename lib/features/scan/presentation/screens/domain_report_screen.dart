import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/features/scan/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/scan/presentation/widgets/circle_indicator.dart';

class DomainReportScreen extends StatelessWidget {
  final DomainResponseModel reportData;
  const DomainReportScreen({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    final stats = reportData.data!.attributes.lastAnalysisStats;

    final harmless = stats?.harmless ?? 0;
    final malicious = stats?.malicious ?? 0;
    final totalDetections = harmless + malicious;

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
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Report for ${reportData.data!.id}',
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
                              ? 'This domain appears to be clean'
                              : '$malicious security vendors flagged this domain as malicious.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '$malicious / $totalDetections detections',
                          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  /// ENGINE RESULTS
                  if (reportData.data!.attributes.lastAnalysisResults.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Text(
                        'No analysis results available',
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    )
                  else
                    ...reportData.data!.attributes.lastAnalysisResults.values
                        .map((item) {
                          final vendorName = item.engineName;
                          final category = item.category;
                          final result = item.result;

                          final isMalicious = category == Category.MALICIOUS;
                          final isSuspicious = category == Category.SUSPICIOUS;

                          return Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE5E5E5),
                              ),
                            ),
                            child: ListTile(
                              trailing: Icon(
                                isMalicious
                                    ? Icons.warning_amber_rounded
                                    : isSuspicious
                                    ? Icons.dangerous_rounded
                                    : Icons.check_circle_outline,
                                color: isMalicious
                                    ? Colors.red
                                    : isSuspicious
                                    ? Colors.orange
                                    : Colors.green,
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      vendorName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                ],
                              ),
                              subtitle: Text(
                                result.name,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
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
