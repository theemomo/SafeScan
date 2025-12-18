import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:safe_scan/core/route/route_names.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/features/scan/presentation/cubits/scan_file_cubit/scan_file_cubit.dart';
import 'package:safe_scan/features/scan/presentation/widgets/dashed_container.dart';

class ScanFileWidget extends StatelessWidget {
  const ScanFileWidget({super.key});

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
                'assets/svgs/upload_file.svg',
                height: 34.h,
                width: 34.w,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "Choose File",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                height: 2,
              ),
            ),
            Text(
              "We'll check if it's safe to open",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF666666),
              ),
            ),
            SizedBox(height: 24.h),

            BlocConsumer<ScanFileCubit, ScanFileState>(
              listener: (context, state) {
                if (state is ScanFileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is ScanFileNotFound) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is ScanFileLoaded) {
                  context.goNamed(
                    RouteNames.fileReport,
                    extra: state.fileReport,
                  );
                }
              },
              builder: (context, state) {
                if (state is ScanFileLoading) {
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
                  onPressed: () async {
                    try {
                      // Pick the file
                      final result = await FilePicker.platform.pickFiles();
                      if (result == null || result.files.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("No file selected")),
                        );
                        return;
                      }

                      final file = File(result.files.single.path!);
                      final bytes = await file.readAsBytes();

                      // Calculate hashes
                      final md5Hash = md5.convert(bytes).toString();
                      final sha1Hash = sha1.convert(bytes).toString();
                      final sha256Hash = sha256.convert(bytes).toString();                 

                      context.read<ScanFileCubit>().scanFile(sha256Hash);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error picking file: $e")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55.h),
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    "Select File",
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
