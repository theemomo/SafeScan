import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:safe_scan/core/utils/app_colors.dart";
import "package:safe_scan/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart";
import "package:safe_scan/features/scan/presentation/widgets/tabs_widget.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
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
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Text('Menu')),
            GestureDetector(
              onTap: () => context.go('/page-a'),
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
      body: Padding(
        padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Analyze suspicious files and URLs',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  height: 2.2,
                ),
              ),
              Text(
                'Detect malware and automatically share with the security community',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 30.h),

              const TabsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
