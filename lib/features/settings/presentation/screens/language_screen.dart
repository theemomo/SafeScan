import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_scan/core/utils/app_colors.dart';
import 'package:safe_scan/features/settings/presentation/cubits/locale_cubit.dart';
import 'package:safe_scan/l10n/app_localizations.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
            size: 18.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.selectLanguage,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.selectLanguage,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Choose your preferred language',
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF707070),
              ),
            ),
            SizedBox(height: 32.h),
            _LanguageTile(
              label: l10n.english,
              nativeLabel: 'English',
              flagEmoji: '🇺🇸',
              isSelected: currentLocale.languageCode == 'en',
              onTap: () => _switchLocale(context, 'en'),
            ),
            SizedBox(height: 12.h),
            _LanguageTile(
              label: l10n.arabic,
              nativeLabel: 'العربية',
              flagEmoji: '🇸🇦',
              isSelected: currentLocale.languageCode == 'ar',
              onTap: () => _switchLocale(context, 'ar'),
            ),
          ],
        ),
      ),
    );
  }

  void _switchLocale(BuildContext context, String code) {
    context.read<LocaleCubit>().setLocale(Locale(code));
  }
}

// ── Language option tile ──────────────────────────────────────────────────────

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.label,
    required this.nativeLabel,
    required this.flagEmoji,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String nativeLabel;
  final String flagEmoji;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.06)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : const Color(0xFFE0E0E0),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Text(flagEmoji, style: TextStyle(fontSize: 28.sp)),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.black87,
                    ),
                  ),
                  if (label != nativeLabel)
                    Text(
                      nativeLabel,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF707070),
                      ),
                    ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 22.w,
                height: 22.h,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 14.sp,
                ),
              )
            else
              Container(
                width: 22.w,
                height: 22.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFCCCCCC),
                    width: 1.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
