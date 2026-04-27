// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'SafeScan';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get loginTagline =>
      'سجّل دخولك لفحص روابطك بأمان والبقاء في مأمن من التهديدات الإلكترونية.';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get emailHint => 'أدخل البريد الإلكتروني أو رقم الهاتف';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get or => 'أو';

  @override
  String get facebook => 'فيسبوك';

  @override
  String get google => 'جوجل';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get registerTitle => 'إنشاء حساب';

  @override
  String get registerTagline => 'افحص الروابط وحمِ درعك الرقمي.';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get usernameHint => 'أدخل اسم المستخدم';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get gmail => 'جيميل';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟';

  @override
  String get homeTitle => 'تحليل الملفات والروابط المشبوهة';

  @override
  String get homeSubtitle =>
      'كشف البرامج الضارة ومشاركتها تلقائياً مع مجتمع الأمن';

  @override
  String get home => 'الرئيسية';

  @override
  String get savedReports => 'التقارير المحفوظة';

  @override
  String get systemSettings => 'إعدادات النظام';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get settings => 'الإعدادات';

  @override
  String get settingsSubtitle => 'خصّص تجربة تحليل الأمان الخاصة بك';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get language => 'اللغة';

  @override
  String get helpSupport => 'المساعدة والدعم';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get scanReports => 'تقارير الفحص';

  @override
  String get scanReportsSubtitle =>
      'راجع نتائج تحليل الأمان وتقييمات التهديدات';

  @override
  String get noSavedReports => 'لا توجد تقارير محفوظة بعد';

  @override
  String get noSavedReportsHint =>
      'افحص نطاقاً أو ملفاً ثم اضغط على\nأيقونة الإشارة المرجعية لحفظه هنا.';

  @override
  String get reportRemoved => 'تمّت إزالة التقرير من المحفوظات.';

  @override
  String couldNotOpenReport(String error) {
    return 'تعذّر فتح التقرير: $error';
  }

  @override
  String vendorsFlagged(String malicious, String total) {
    return 'أبلغ $malicious/$total من الموردين عن هذا';
  }

  @override
  String get file => 'ملف';

  @override
  String get url => 'رابط';

  @override
  String get domain => 'النطاق';

  @override
  String get files => 'الملفات';

  @override
  String get enterUrlToScan => 'أدخل الرابط للفحص';

  @override
  String get urlSafeHint => 'سنتحقق مما إذا كان آمناً للزيارة';

  @override
  String get enterDomainHint => 'أدخل نطاقاً أو رابطاً';

  @override
  String get scanDomain => 'فحص النطاق';

  @override
  String get pleaseEnterDomain =>
      'يرجى إدخال نطاق أو نطاق فرعي (مثال: domain.com)';

  @override
  String get invalidDomainFormat =>
      'تنسيق غير صحيح. استخدم: domain.com أو sub.domain.com';

  @override
  String get chooseFile => 'اختر ملفاً';

  @override
  String get fileSafeHint => 'سنتحقق مما إذا كان آمناً للفتح';

  @override
  String get selectFile => 'اختر ملفاً';

  @override
  String get noFileSelected => 'لم يتم اختيار أي ملف';

  @override
  String errorPickingFile(String error) {
    return 'خطأ في اختيار الملف: $error';
  }

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingDone => 'ابدأ الآن';

  @override
  String get onboardingTitle1 => 'مرحباً بك في Safe Scan';

  @override
  String get onboardingDesc1 =>
      'رفيقك الذكي في الأمن السيبراني — افحص الروابط والملفات والنطاقات بحثاً عن التهديدات في ثوانٍ باستخدام معلومات التهديدات الفورية.';

  @override
  String get onboardingStat1 => 'مدعوم بتطبيق Safe Scan';

  @override
  String get onboardingHighlight1 => '🛡️';

  @override
  String get onboardingTitle2 => 'افحص واكتشف التهديدات';

  @override
  String get onboardingDesc2 =>
      'حلّل الروابط للكشف عن التصيد الاحتيالي، وتحقق من بصمات الملفات في قواعد بيانات البرمجيات الخبيثة، واحصل على تقارير مفصلة عن سمعة النطاقات وعناوين IP.';

  @override
  String get onboardingStat2 => 'أكثر من 70 محرك مضاد فيروسات يفحص لأجلك';

  @override
  String get onboardingHighlight2 => '+70';

  @override
  String get onboardingTitle3 => 'ابقَ محمياً، ابقَ مطّلعاً';

  @override
  String get onboardingDesc3 =>
      'احصل على نتائج مرمّزة بالألوان — أخضر للآمن، أصفر للمشبوه، أحمر للخبيث. احفظ سجل الفحص واستقبل تنبيهات الأمان الفورية.';

  @override
  String get onboardingStat3 => 'من مصادر التهديدات الفورية';

  @override
  String get onboardingHighlight3 => '24/7';
}
