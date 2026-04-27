import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/l10n/app_localizations.dart';

class AwarenessScreen extends StatelessWidget {
  const AwarenessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          l10n.securityAwareness,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shield_rounded,
                    color: AppColors.primaryColor,
                    size: 40.sp,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.phishingAttacks,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          l10n.awarenessSubtitle,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Definition Section
            _buildSectionTitle(l10n.phishingAttacks, Icons.info_outline_rounded),
            SizedBox(height: 12.h),
            Text(
              l10n.phishingDesc,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),

            // Statistics Section
            _buildSectionTitle(l10n.attackStatistics, Icons.bar_chart_rounded),
            SizedBox(height: 12.h),
            _buildStatisticCard(
              icon: Icons.data_usage_rounded,
              text: l10n.stat1,
              color: Colors.redAccent,
            ),
            SizedBox(height: 10.h),
            _buildStatisticCard(
              icon: Icons.business_rounded,
              text: l10n.stat2,
              color: Colors.orange,
            ),
            SizedBox(height: 10.h),
            _buildStatisticCard(
              icon: Icons.api_rounded,
              text: l10n.stat3,
              color: Colors.blueAccent,
            ),
            SizedBox(height: 10.h),
            _buildStatisticCard(
              icon: Icons.mail_outline_rounded,
              text: l10n.stat4,
              color: Colors.deepPurpleAccent,
            ),
            SizedBox(height: 24.h),

            // Common Attacks Section
            _buildSectionTitle(l10n.commonAttacks, Icons.warning_amber_rounded),
            SizedBox(height: 12.h),
            _buildAttackTypeTile(
              title: l10n.spearPhishing,
              description: l10n.spearPhishingDesc,
              icon: Icons.person_search_rounded,
            ),
            _buildAttackTypeTile(
              title: l10n.whaling,
              description: l10n.whalingDesc,
              icon: Icons.business_center_rounded,
            ),
            _buildAttackTypeTile(
              title: l10n.smishing,
              description: l10n.smishingDesc,
              icon: Icons.sms_failed_rounded,
            ),
            _buildAttackTypeTile(
              title: l10n.vishing,
              description: l10n.vishingDesc,
              icon: Icons.phone_disabled_rounded,
            ),
            SizedBox(height: 24.h),

            // Real-World Scenarios Section
            _buildSectionTitle(l10n.realWorldScenarios, Icons.help_outline_rounded),
            SizedBox(height: 12.h),
            _buildScenarioCard(
              title: l10n.whatIfClickLink,
              description: l10n.whatIfClickLinkDesc,
              icon: Icons.link_off_rounded,
              color: Colors.orange,
            ),
            _buildScenarioCard(
              title: l10n.whatIfOpenFile,
              description: l10n.whatIfOpenFileDesc,
              icon: Icons.file_present_rounded,
              color: Colors.redAccent,
            ),
            _buildScenarioCard(
              title: l10n.whatIfEnterDetails,
              description: l10n.whatIfEnterDetailsDesc,
              icon: Icons.password_rounded,
              color: Colors.purpleAccent,
            ),
            SizedBox(height: 24.h),

            // Protection Tips Section
            _buildSectionTitle(l10n.protectionTips, Icons.security_rounded),
            SizedBox(height: 12.h),
            _buildTipTile(l10n.tip1, 1),
            _buildTipTile(l10n.tip2, 2),
            _buildTipTile(l10n.tip3, 3),
            _buildTipTile(l10n.tip4, 4),
            _buildTipTile(l10n.tip5, 5),
            
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.black87, size: 22.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticCard({required IconData icon, required String text, required Color color}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioCard({required String title, required String description, required IconData icon, required Color color}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 22.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color.withOpacity(0.9),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            description,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13.sp,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttackTypeTile({required String title, required String description, required IconData icon}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 13.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipTile(String tip, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24.w,
            height: 24.h,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                index.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
