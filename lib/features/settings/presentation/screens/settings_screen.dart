import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/route/route_names.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/l10n/app_localizations.dart';
import 'package:safe_scan/features/settings/presentation/cubits/locale_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = context.watch<LocaleCubit>().state;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87, size: 22.sp),
            onPressed: () => context.pop(),
          ),
        ),
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
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset(
              'assets/svgs/search.svg',
              height: 18.75.h,
              width: 20.76.w,
              color: const Color(0xFF707070),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 28.h),

            // ── Page Title ──────────────────────────────────────────
            Text(
              l10n.settings,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              l10n.settingsSubtitle,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF707070),
              ),
            ),

            SizedBox(height: 24.h),

            // ── Settings Items ──────────────────────────────────────
            _SettingsTile(
              icon: Icons.edit_outlined,
              label: l10n.changePassword,
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.black54,
                size: 20.sp,
              ),
              onTap: () {
                // TODO: navigate to Change Password screen
              },
            ),

            const _Divider(),

            _SettingsTile(
              icon: Icons.notifications_none_rounded,
              label: l10n.notifications,
              trailing: CupertinoSwitch(
                value: _notificationsEnabled,
                activeColor: AppColors.primaryColor,
                onChanged: (val) {
                  setState(() => _notificationsEnabled = val);
                },
              ),
              onTap: () {
                setState(() => _notificationsEnabled = !_notificationsEnabled);
              },
            ),

            const _Divider(),

            _SettingsTile(
              icon: Icons.language_outlined,
              label: l10n.language,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    currentLocale.languageCode == 'ar' ? 'العربية' : 'English',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF707070),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.chevron_right, color: Colors.black54, size: 20.sp),
                ],
              ),
              onTap: () {
                context.pushNamed(RouteNames.language);
              },
            ),

            const _Divider(),

            _SettingsTile(
              icon: Icons.help_outline_rounded,
              label: l10n.helpSupport,
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.black54,
                size: 20.sp,
              ),
              onTap: () {
                // TODO: navigate to Help & Support screen
              },
            ),

            const _Divider(),
          ],
        ),
      ),
    );
  }
}

// ── Reusable settings row ─────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            Icon(icon, size: 20.sp, color: Colors.black87),
            SizedBox(width: 14.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 0.8, color: Colors.grey.shade200);
  }
}
