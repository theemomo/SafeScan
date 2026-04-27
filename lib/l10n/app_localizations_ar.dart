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
  String get securityAwareness => 'التوعية الأمنية';

  @override
  String get awarenessSubtitle =>
      'تعلم كيف تحمي نفسك من التهديدات السيبرانية الشائعة.';

  @override
  String get phishingAttacks => 'هجمات التصيد الاحتيالي';

  @override
  String get phishingDesc =>
      'التصيد الاحتيالي هو محاولة احتيالية للحصول على معلومات حساسة عن طريق التنكر ككيان موثوق به في الاتصالات الإلكترونية.';

  @override
  String get commonAttacks => 'أشهر الهجمات';

  @override
  String get spearPhishing => 'التصيد الموجه';

  @override
  String get spearPhishingDesc =>
      'هجمات مستهدفة تستخدم معلومات شخصية لخداع أفراد معينين.';

  @override
  String get whaling => 'صيد الحيتان';

  @override
  String get whalingDesc =>
      'هجمات تصيد موجهة خصيصاً لكبار المديرين التنفيذيين والأهداف البارزة.';

  @override
  String get smishing => 'التصيد عبر الرسائل النصية (Smishing)';

  @override
  String get smishingDesc =>
      'رسائل نصية احتيالية مصممة لخداعك للكشف عن معلومات شخصية.';

  @override
  String get vishing => 'التصيد الصوتي (Vishing)';

  @override
  String get vishingDesc =>
      'عمليات احتيال هاتفية يحاول فيها المهاجمون التلاعب بك لمشاركة البيانات أو تحويل الأموال.';

  @override
  String get protectionTips => 'كيف تحمي نفسك';

  @override
  String get tip1 =>
      'لا تنقر أبداً على الروابط المشبوهة أو تحمل مرفقات غير موثوقة.';

  @override
  String get tip2 =>
      'تحقق من عنوان البريد الإلكتروني للمرسل بعناية (مثال: support@paypaI.com مقابل support@paypal.com).';

  @override
  String get tip3 => 'قم بتمكين المصادقة الثنائية (2FA) على جميع حساباتك.';

  @override
  String get tip4 =>
      'لا تشارك أبداً كلمات المرور أو كلمات المرور لمرة واحدة أو المعلومات المالية عبر الهاتف أو البريد الإلكتروني.';

  @override
  String get tip5 => 'حافظ على تحديث البرامج وأنظمة التشغيل الخاصة بك.';

  @override
  String get attackStatistics => 'إحصائيات الهجمات العالمية';

  @override
  String get stat1 =>
      '36% من جميع انتهاكات البيانات تنطوي على التصيد الاحتيالي.';

  @override
  String get stat2 =>
      '83% من المؤسسات تعرضت لهجوم تصيد ناجح عبر البريد الإلكتروني في عام 2021.';

  @override
  String get stat3 => 'التصيد الموجه يمثل 95% من هجمات شبكات الشركات.';

  @override
  String get stat4 =>
      'يتم إرسال أكثر من 3.4 مليار بريد إلكتروني ضار حول العالم يومياً.';

  @override
  String get realWorldScenarios => 'سيناريوهات من العالم الحقيقي: ماذا لو...؟';

  @override
  String get whatIfClickLink => 'ماذا لو نقرت على رابط ضار؟';

  @override
  String get whatIfClickLinkDesc =>
      'إذا فتحت رابطاً ضاراً، فقد يتم توجيهك إلى صفحة تسجيل دخول مزيفة تبدو تماماً مثل خدمة تستخدمها (مثل البنك أو البريد الإلكتروني الخاص بك). إذا أدخلت بياناتك، يسرقها المهاجمون على الفور. في بعض الأحيان، قد تؤدي زيارة الموقع فقط إلى تنزيل برامج ضارة بصمت على جهازك.';

  @override
  String get whatIfOpenFile => 'ماذا لو فتحت ملفاً ضاراً؟';

  @override
  String get whatIfOpenFileDesc =>
      'قد يؤدي فتح مرفق ضار (مثل ملف PDF أو Word مزيف) إلى تشغيل تعليمات برمجية مخفية. يمكن أن يؤدي هذا إلى تثبيت \'برامج الفدية\' التي تقوم بتشفير جميع ملفاتك الشخصية وتطلب أموالاً لفتحها، أو \'برنامج تسجيل المفاتيح\' الذي يسجل كل ما تكتبه، بما في ذلك كلمات المرور الخاصة بك.';

  @override
  String get whatIfEnterDetails => 'ماذا لو قمت بإعطاء بياناتي؟';

  @override
  String get whatIfEnterDetailsDesc =>
      'بمجرد حصول المهاجمين على معلوماتك، يمكنهم إخراجك من حساباتك الخاصة، أو سرقة أموالك، أو انتحال شخصيتك لخداع أصدقائك أو عائلتك أو زملائك لإرسال الأموال إليهم.';
}
