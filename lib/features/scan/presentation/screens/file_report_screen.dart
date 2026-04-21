import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/di/injection_container.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/features/reports/domain/entities/report_extras.dart';
import 'package:safe_scan/features/reports/domain/entities/saved_report.dart';
import 'package:safe_scan/features/reports/presentation/cubits/saved_reports_cubit.dart';
import 'package:safe_scan/features/scan/domain/entities/file_response_model.dart';
import 'package:safe_scan/features/scan/presentation/widgets/circle_indicator.dart';
import 'package:safe_scan/features/scan/presentation/cubits/ai_explanation_cubit/ai_explanation_cubit.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class FileReportScreen extends StatelessWidget {
  final FileReportExtra extra;
  const FileReportScreen({super.key, required this.extra});

  FileResponseModel get reportData => extra.model;

  String _formatDate(int timestamp) {
    if (timestamp == 0) return 'N/A';
    return DateTime.fromMillisecondsSinceEpoch(
      timestamp * 1000,
    ).toIso8601String().split('T')[0];
  }

  String _formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = (bytes.toString().length - 1) ~/ 3;
    if (i >= suffixes.length) i = suffixes.length - 1;
    return "${(bytes / (1024 * i * i)).toStringAsFixed(decimals)} ${suffixes[i]}";
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ).copyWith(top: 16.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.sp, color: Colors.grey),
          SizedBox(width: 8.w),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  String _threatLabel(int malicious, int suspicious) {
    if (malicious > 0) return 'Dangerous';
    if (suspicious > 0) return 'Suspicious';
    return 'Safe';
  }

  @override
  Widget build(BuildContext context) {
    final attributes = reportData.data!.attributes;
    final stats = attributes.lastAnalysisStats;

    final harmless = stats?.harmless ?? 0;
    final malicious = stats?.malicious ?? 0;
    final suspicious = stats?.suspicious ?? 0;
    final totalDetections = harmless + malicious;

    return BlocProvider<SavedReportsCubit>(
      create: (_) => getIt<SavedReportsCubit>(),
      child: Builder(
        builder: (context) {
          return BlocListener<SavedReportsCubit, SavedReportsState>(
            listener: (context, state) {
              if (state is SavedReportsSaved) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Report saved successfully!'),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              } else if (state is SavedReportsAlreadySaved) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Report already saved.'),
                    backgroundColor: Colors.orange,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              } else if (state is SavedReportsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            },
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
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
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF707070),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                  bottom: TabBar(
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppColors.primaryColor,
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    tabs: const [
                      Tab(text: 'Technical Report'),
                      Tab(text: 'AI Summary'),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    /// HEADER
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 8.h,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () => context.pop(),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Report for ${attributes.meaningfulName}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (attributes.lastAnalysisDate != 0)
                                  Text(
                                    'Last Scanned: ${_formatDate(attributes.lastAnalysisDate)}',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          /// BOOKMARK BUTTON
                          _FileBookmarkButton(
                            target: attributes.meaningfulName.isNotEmpty
                                ? attributes.meaningfulName
                                : attributes.sha256,
                            scanType: 'file',
                            threatLabel: _threatLabel(malicious, suspicious),
                            maliciousCount: malicious,
                            totalVendors: totalDetections,
                            rawJson: jsonEncode(reportData.toJson()),
                          ),
                        ],
                      ),
                    ),

                    /// CONTENT
                    Expanded(
                      child: TabBarView(
                        children: [
                          /// TAB 1: TECHNICAL
                          SingleChildScrollView(
                            child: _buildTechnicalTab(
                              context,
                              attributes,
                              harmless,
                              malicious,
                              totalDetections,
                            ),
                          ),

                          /// TAB 2: AI SUMMARY
                          BlocProvider(
                            create: (context) {
                              final cubit = AiExplanationCubit();
                              final cached = extra.cachedAiSummary;
                              if (cached != null && cached.isNotEmpty) {
                                cubit.loadCached(cached);
                              } else {
                                cubit.generateFileExplanation(reportData);
                              }
                              return cubit;
                            },
                            child:
                                BlocBuilder<
                                  AiExplanationCubit,
                                  AiExplanationState
                                >(
                                  builder: (context, state) {
                                    if (state is AiExplanationLoading) {
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const CircularProgressIndicator(
                                              color: AppColors.primaryColor,
                                            ),
                                            SizedBox(height: 16.h),
                                            Text(
                                              'Analyzing the scan results...',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else if (state is AiExplanationError) {
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(24.w),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.error_outline,
                                                size: 48.sp,
                                                color: Colors.red,
                                              ),
                                              SizedBox(height: 16.h),
                                              Text(
                                                state.message,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else if (state is AiExplanationLoaded) {
                                      return Container(
                                        color: Colors.white,
                                        child: Markdown(
                                          data: state.explanation,
                                          padding: EdgeInsets.all(24.w),
                                          styleSheet: MarkdownStyleSheet(
                                            p: TextStyle(
                                              fontSize: 15.sp,
                                              height: 1.5,
                                            ),
                                            h1: TextStyle(
                                              fontSize: 22.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor,
                                            ),
                                            h2: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                            h3: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            listBullet: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColors.primaryColor,
                                            ),
                                            strong: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            blockquote: TextStyle(
                                              color: Colors.grey[700],
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTechnicalTab(
    BuildContext context,
    Attributes attributes,
    int harmless,
    int malicious,
    int totalDetections,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
              CircleIndicator(harmless: harmless, malicious: malicious),
              SizedBox(height: 12.h),
              Text(
                malicious == 0
                    ? 'This file appears to be clean'
                    : '$malicious security vendors flagged this file as malicious.',
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

        /// FILE INFO DETAILS
        _buildSectionHeader('File Information'),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E5E5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(
                Icons.description,
                'Internal Name',
                attributes.meaningfulName,
              ),
              _buildInfoRow(
                Icons.file_present,
                'Type',
                attributes.typeDescription,
              ),
              _buildInfoRow(
                Icons.straighten,
                'Size',
                _formatBytes(attributes.size),
              ),
              _buildInfoRow(Icons.fingerprint, 'MD5', attributes.md5),
              _buildInfoRow(Icons.fingerprint, 'SHA1', attributes.sha1),
              _buildInfoRow(Icons.fingerprint, 'SHA256', attributes.sha256),
              if (attributes.firstSubmissionDate != 0)
                _buildInfoRow(
                  Icons.calendar_today,
                  'First Seen',
                  _formatDate(attributes.firstSubmissionDate),
                ),
              if (attributes.lastSubmissionDate != 0)
                _buildInfoRow(
                  Icons.update,
                  'Latest Submission',
                  _formatDate(attributes.lastSubmissionDate),
                ),
              _buildInfoRow(
                Icons.thumbs_up_down,
                'Reputation',
                attributes.reputation.toString(),
              ),
              if (attributes.totalVotes != null) ...[
                SizedBox(height: 8.h),
                Text(
                  'Community Votes:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '${attributes.totalVotes!.harmless}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    SizedBox(width: 16.w),
                    Icon(Icons.cancel, color: Colors.red, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '${attributes.totalVotes!.malicious}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
              ],
              if (attributes.tags.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: attributes.tags
                      .map(
                        (tag) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        ),

        /// MAGIC & TRID
        if (attributes.magic.isNotEmpty || attributes.trid.isNotEmpty) ...[
          _buildSectionHeader('Type Identification'),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E5E5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (attributes.magic.isNotEmpty)
                  _buildInfoRow(Icons.auto_fix_high, 'Magic', attributes.magic),
                if (attributes.trid.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    'TrID Detection:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  ...attributes.trid.map(
                    (t) => Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        '• ${t.fileType} (${(t.probability).toStringAsFixed(1)}%)',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],

        /// SECURITY VENDORS
        _buildSectionHeader('Security Vendors'),
        if (attributes.lastAnalysisResults.isEmpty)
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              'No analysis results available',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
          )
        else
          ...attributes.lastAnalysisResults.values.map((item) {
            final vendorName = item.engineName;
            final category = item.category;
            final result = item.result;

            final isMalicious = category == Category.MALICIOUS;
            final isSuspicious = category == Category.SUSPICIOUS;

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE5E5E5)),
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
                title: Text(
                  vendorName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp),
                ),
                subtitle: Text(
                  resultValues.reverse[result] ?? 'Unknown',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ),
            );
          }),

        SizedBox(height: 32.h),
      ],
    );
  }
}

// ── Bookmark button widget ────────────────────────────────────────────────────

class _FileBookmarkButton extends StatefulWidget {
  final String target;
  final String scanType;
  final String threatLabel;
  final int maliciousCount;
  final int totalVendors;
  final String rawJson;

  const _FileBookmarkButton({
    required this.target,
    required this.scanType,
    required this.threatLabel,
    required this.maliciousCount,
    required this.totalVendors,
    required this.rawJson,
  });

  @override
  State<_FileBookmarkButton> createState() => _FileBookmarkButtonState();
}

class _FileBookmarkButtonState extends State<_FileBookmarkButton> {
  bool _isSaved = false;
  bool _checking = true;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    try {
      final saved = await context.read<SavedReportsCubit>().isReportSaved(
        widget.target,
        widget.scanType,
      );
      if (mounted) {
        setState(() {
          _isSaved = saved;
          _checking = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isSaved = false;
          _checking = false;
        });
      }
    }
  }

  void _onTap(BuildContext context) {
    if (_isSaved) {
      context.read<SavedReportsCubit>().saveReport(
        SavedReport(
          scanType: widget.scanType,
          target: widget.target,
          threatLabel: widget.threatLabel,
          maliciousCount: widget.maliciousCount,
          totalVendors: widget.totalVendors,
          aiSummary: '',
          rawJson: widget.rawJson,
          savedAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    } else {
      String aiSummary = '';
      try {
        final aiState = context.read<AiExplanationCubit?>()?.state;
        if (aiState is AiExplanationLoaded) {
          aiSummary = aiState.explanation;
        }
      } catch (_) {}

      context.read<SavedReportsCubit>().saveReport(
        SavedReport(
          scanType: widget.scanType,
          target: widget.target,
          threatLabel: widget.threatLabel,
          maliciousCount: widget.maliciousCount,
          totalVendors: widget.totalVendors,
          aiSummary: aiSummary,
          rawJson: widget.rawJson,
          savedAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
      setState(() => _isSaved = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: SizedBox(
          width: 20.w,
          height: 20.h,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.primaryColor,
          ),
        ),
      );
    }
    return IconButton(
      tooltip: _isSaved ? 'Already saved' : 'Save report',
      icon: Icon(
        _isSaved ? Icons.bookmark : Icons.bookmark_border,
        color: _isSaved ? AppColors.primaryColor : Colors.grey,
      ),
      onPressed: () => _onTap(context),
    );
  }
}
