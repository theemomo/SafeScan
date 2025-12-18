import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_scan/features/scan/data/virustotal_repo.dart';
import 'package:safe_scan/features/scan/presentation/cubits/scan_domain_cubit/scan_domain_cubit.dart';
import 'package:safe_scan/features/scan/presentation/cubits/scan_file_cubit/scan_file_cubit.dart';
import 'package:safe_scan/features/scan/presentation/widgets/scan_domain_widget.dart';
import 'package:safe_scan/features/scan/presentation/widgets/scan_file_widget.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({super.key});

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F1F4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(child: _tabBuilder("Domain", 0)),
              Expanded(child: _tabBuilder("Files", 1)),
            ],
          ),
        ),
        SizedBox(height: 50.h),
        IndexedStack(
          index: selectedTab,
          children: [
            BlocProvider(
              create: (context) => ScanDomainCubit(VirustotalRepo()),
              child: const ScanDomainWidget(),
            ),
            BlocProvider(
              create: (context) => ScanFileCubit(VirustotalRepo()),
              child: const ScanFileWidget(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _tabBuilder(String text, int index) {
    final isSelected = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          boxShadow: isSelected
              ? [
                  const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
