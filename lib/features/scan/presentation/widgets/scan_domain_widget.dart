import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/route/route_names.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/features/scan/presentation/cubits/scan_domain_cubit/scan_domain_cubit.dart';
import 'package:safe_scan/features/scan/presentation/widgets/dashed_container.dart';

class ScanDomainWidget extends StatefulWidget {
  const ScanDomainWidget({super.key});

  @override
  State<ScanDomainWidget> createState() => _ScanDomainWidgetState();
}

class _ScanDomainWidgetState extends State<ScanDomainWidget> {
  final TextEditingController _domainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DashedContainer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 234, 246, 255),
              radius: 40.r,
              child: SvgPicture.asset(
                'assets/svgs/enter_domain.svg',
                height: 34.h,
                width: 34.w,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "Enter URL to scan",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 2,
              ),
            ),
            Text(
              "We'll check if it's safe to visit",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF666666),
              ),
            ),
            SizedBox(height: 24.h),
            TextField(
              controller: _domainController,
              keyboardType: TextInputType.url,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: "Enter a Domain or URL",
                hintStyle: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFFAAAAAA),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.r),
                  borderSide: const BorderSide(color: Color(0xFFAAAAAA)),
                ),
                filled: true,
                fillColor: const Color(0xFFF1F1F4),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 16.w,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            BlocConsumer<ScanDomainCubit, ScanDomainState>(
              listener: (context, state) {
                if (state is ScanDomainError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is ScanDomainNotFound) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is ScanDomainLoaded) {
                  context.goNamed(
                    RouteNames.domainReport,
                    extra: state.domainReport,
                  );
                }
              },
              builder: (context, state) {
                if (state is ScanDomainLoading) {
                  return ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 55.h),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                    child: SizedBox(
                      height: 24.h,
                      width: 24.h,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    final input = _domainController.text.trim();

                    final domainRegex = RegExp(
                      r'^(?!:\/\/)([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$',
                    );

                    if (input.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please enter a domain or subdomain (e.g. domain.com)',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (!domainRegex.hasMatch(input)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Invalid format.\nUse: domain.com or sub.domain.com',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    // Valid domain or subdomain
                    context.read<ScanDomainCubit>().scanDomain(input);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55.h),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    "Scan Domain",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
