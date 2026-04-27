import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/route/route_names.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:safe_scan/l10n/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = context.watch<AuthCubit>().state;
    final String userName = authState is Authenticated
        ? (authState.user?.name ?? 'User')
        : 'User';
    final String userEmail = authState is Authenticated
        ? (authState.user?.email ?? '')
        : '';
    final String initials = userName.trim().isNotEmpty
        ? userName.trim()[0].toUpperCase()
        : 'U';

    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: AppColors.primaryColor,
                        size: 22.sp,
                      ),
                      SizedBox(width: 6.w),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Safe',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'Scan',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.primaryColor,
                        size: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8.h),

            // ── Nav Items ────────────────────────────────────────────
            _DrawerNavTile(
              icon: Icons.home_outlined,
              label: l10n.home,
              onTap: () {
                Navigator.of(context).pop();
                context.pushReplacementNamed(RouteNames.home);
              },
            ),
            _DrawerNavTile(
              icon: Icons.bookmark_border_rounded,
              label: l10n.savedReports,
              onTap: () {
                Navigator.of(context).pop();
                context.pushReplacementNamed(RouteNames.savedReports);
              },
            ),
            _DrawerNavTile(
              icon: Icons.settings_outlined,
              label: l10n.systemSettings,
              onTap: () {
                Navigator.of(context).pop();
                context.pushReplacementNamed(RouteNames.settings);
              },
            ),
            _DrawerNavTile(
              icon: Icons.security_rounded,
              label: l10n.securityAwareness,
              onTap: () {
                Navigator.of(context).pop();
                context.pushReplacementNamed(RouteNames.awareness);
              },
            ),

            const Spacer(),

            // ── Logout ───────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  context.read<AuthCubit>().logout();
                },
                leading: Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                  size: 20.sp,
                ),
                title: Text(
                  l10n.logOut,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                minLeadingWidth: 0,
                horizontalTitleGap: 10.w,
              ),
            ),

            SizedBox(height: 8.h),

            // ── User Info ────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 20.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.15),
                    child: Text(
                      initials,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        userEmail,
                        style: TextStyle(
                          color: const Color(0xFF707070),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerNavTile extends StatelessWidget {
  const _DrawerNavTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.black87, size: 20.sp),
        title: Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        minLeadingWidth: 0,
        horizontalTitleGap: 10.w,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        hoverColor: AppColors.primaryColor.withOpacity(0.05),
      ),
    );
  }
}
