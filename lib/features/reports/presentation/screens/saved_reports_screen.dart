import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/features/reports/domain/entities/report_extras.dart';
import 'package:safe_scan/features/reports/domain/entities/saved_report.dart';
import 'package:safe_scan/features/reports/presentation/cubits/saved_reports_cubit.dart';
import 'package:safe_scan/features/scan/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/scan/domain/entities/file_response_model.dart'
    as file_model;
import 'package:safe_scan/core/route/route_names.dart';

class SavedReportsScreen extends StatelessWidget {
  const SavedReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Load reports when screen opens
    context.read<SavedReportsCubit>().loadReports();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shield_outlined,
              color: AppColors.primaryColor,
              size: 22.sp,
            ),
            SizedBox(width: 4.w),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Safe',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'Scan',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Icon(
              Icons.search,
              color: const Color(0xFF707070),
              size: 22.sp,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Scan Reports',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Review security analysis results and threat assessments',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: BlocBuilder<SavedReportsCubit, SavedReportsState>(
                builder: (context, state) {
                  if (state is SavedReportsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor),
                    );
                  }

                  if (state is SavedReportsError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                      ),
                    );
                  }

                  if (state is SavedReportsLoaded) {
                    if (state.reports.isEmpty) {
                      return _EmptyState();
                    }
                    return ListView.separated(
                      itemCount: state.reports.length,
                      separatorBuilder: (_, __) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        final report = state.reports[index];
                        return _ReportCard(
                          report: report,
                          onTap: () => _openReport(context, report),
                          onDelete: () => _deleteReport(context, report),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openReport(BuildContext context, SavedReport report) {
    try {
      final jsonMap = report.decodedJson;
      if (report.scanType == 'domain') {
        final model = DomainResponseModel.fromJson(jsonMap);
        context.pushNamed(
          RouteNames.domainReport,
          extra: DomainReportExtra(
            model: model,
            cachedAiSummary: report.aiSummary,
          ),
        );
      } else {
        final model = file_model.FileResponseModel.fromJson(jsonMap);
        context.pushNamed(
          RouteNames.fileReport,
          extra: FileReportExtra(
            model: model,
            cachedAiSummary: report.aiSummary,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open report: ${e.toString()}'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _deleteReport(BuildContext context, SavedReport report) {
    if (report.id == null) return;
    context.read<SavedReportsCubit>().deleteReport(report.id!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Report removed from saved.'),
        backgroundColor: Colors.grey[800],
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

// ── Report card ───────────────────────────────────────────────────────────────

class _ReportCard extends StatelessWidget {
  final SavedReport report;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _ReportCard({
    required this.report,
    required this.onTap,
    required this.onDelete,
  });

  Color get _threatColor {
    switch (report.threatLabel) {
      case 'Dangerous':
        return Colors.red;
      case 'Suspicious':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  Color get _threatBg {
    switch (report.threatLabel) {
      case 'Dangerous':
        return const Color(0xFFFFEBEB);
      case 'Suspicious':
        return const Color(0xFFFFF3E0);
      default:
        return const Color(0xFFE8F5E9);
    }
  }

  IconData get _icon {
    if (report.scanType == 'file') return Icons.insert_drive_file_outlined;
    return Icons.language;
  }

  String get _typeBadge {
    if (report.scanType == 'file') return 'File';
    return 'URL';
  }

  String get _aiExcerpt {
    if (report.aiSummary.isEmpty) {
      return 'Comprehensive security scan completed with no threats detected';
    }
    // Strip markdown formatting for preview
    final clean = report.aiSummary
        .replaceAll(RegExp(r'[#*_`>]'), '')
        .replaceAll(RegExp(r'\n+'), ' ')
        .trim();
    return clean.length > 80 ? '${clean.substring(0, 80)}...' : clean;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _threatColor.withOpacity(0.4), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── TOP ROW: icon + badge + bookmark ──────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon circle
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: _threatBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_icon, color: _threatColor, size: 22.sp),
                ),
                SizedBox(width: 12.w),

                // Type badge + threat label
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(color: const Color(0xFFDDDDDD)),
                      ),
                      child: Text(
                        _typeBadge,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      report.threatLabel,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: _threatColor,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // Bookmark delete button
                GestureDetector(
                  onTap: onDelete,
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.grey[400],
                    size: 22.sp,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // ── TARGET ────────────────────────────────────────────
            Text(
              report.target,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 6.h),

            // ── AI EXCERPT ────────────────────────────────────────
            Text(
              _aiExcerpt,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 10.h),

            // ── VENDOR COUNT ──────────────────────────────────────
            Row(
              children: [
                Icon(Icons.warning_amber_rounded,
                    size: 14.sp, color: _threatColor),
                SizedBox(width: 4.w),
                Text(
                  '${report.maliciousCount}/${report.totalVendors} vendors flagged this',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: _threatColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // ── DIVIDER + DATE ────────────────────────────────────
            const Divider(height: 1, color: Color(0xFFEEEEEE)),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  report.formattedDate,
                  style:
                      TextStyle(fontSize: 11.sp, color: Colors.grey[500]),
                ),
                Text(
                  report.formattedTime,
                  style:
                      TextStyle(fontSize: 11.sp, color: Colors.grey[500]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bookmark_border_rounded,
              size: 40.sp,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'No saved reports yet',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Scan a domain or file and tap the\nbookmark icon to save it here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[500],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
