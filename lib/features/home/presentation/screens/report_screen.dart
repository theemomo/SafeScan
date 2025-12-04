import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/features/home/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/home/presentation/widgets/circle_indicator.dart';

class ReportScreen extends StatelessWidget {
  final DomainResponseModel reportData;
  const ReportScreen({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
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
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(Icons.arrow_back, size: 24.sp),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Report for ${reportData.data.id}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              height: 2,
                            ),
                          ),
                          Text(
                            'Scan completed',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // ! Save this using local storage or bookmarks feature
                  Icon(Icons.bookmark_outline, size: 24.sp),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(16.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFE5E5E5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleIndicator(
                            harmless: reportData
                                .data
                                .attributes
                                .lastAnalysisStats
                                .harmless,
                            malicious: reportData
                                .data
                                .attributes
                                .lastAnalysisStats
                                .malicious,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              reportData
                                          .data
                                          .attributes
                                          .lastAnalysisStats
                                          .malicious ==
                                      0
                                  ? "This file appears to be clean"
                                  : '${reportData.data.attributes.lastAnalysisStats.malicious} Security vendors flagged this file as malicious.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              '${reportData.data.attributes.lastAnalysisStats.malicious} / ${reportData.data.attributes.lastAnalysisStats.harmless + reportData.data.attributes.lastAnalysisStats.malicious} detections',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                color: const Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Replace ListView.builder with Column + map()
                  ...reportData.data.attributes.lastAnalysisResults.values.map((
                    item,
                  ) {
                    final vendorName = item.engineName;
                    final result = item.result;
                    final Category detected = item.category;
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 3.h,
                      ),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFE5E5E5),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        trailing: Icon(
                          detected == Category.MALICIOUS
                              ? Icons
                                    .warning_amber_rounded // warning_amber_rounded
                              : detected == Category.SUSPICIOUS
                              ? Icons
                                    .dangerous_rounded // error_rounded
                              : Icons.check_circle_outline,
                          color: detected == Category.MALICIOUS
                              ? Colors.red
                              : detected == Category.SUSPICIOUS
                              ? Colors.orange
                              : Colors.green,
                          size: 26.r,
                        ),
                        title: Row(
                          children: [
                            Text(
                              vendorName,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                height: 2.5,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: detected == Category.MALICIOUS
                                    ? Colors.red.withOpacity(0.1)
                                    : detected == Category.SUSPICIOUS
                                    ? Colors.orange.withOpacity(0.1)
                                    : Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: detected == Category.MALICIOUS
                                      ? Colors.red
                                      : detected == Category.SUSPICIOUS
                                      ? Colors.orange
                                      : Colors.green,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                detected == Category.MALICIOUS
                                    ? 'Malicious'
                                    : detected == Category.SUSPICIOUS
                                    ? 'Suspicious'
                                    : 'Clean',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: detected == Category.MALICIOUS
                                      ? Colors.red
                                      : detected == Category.SUSPICIOUS
                                      ? Colors.orange
                                      : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          result.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF666666),
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
