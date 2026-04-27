import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'SafeScan'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @loginTagline.
  ///
  /// In en, this message translates to:
  /// **'Login to safely scan your links and stay ahead of online threats.'**
  String get loginTagline;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter email or phone number'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Password'**
  String get passwordHint;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @google.
  ///
  /// In en, this message translates to:
  /// **'Google'**
  String get google;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get registerTitle;

  /// No description provided for @registerTagline.
  ///
  /// In en, this message translates to:
  /// **'Scan links and protect your digital shield.'**
  String get registerTagline;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @usernameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get usernameHint;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @gmail.
  ///
  /// In en, this message translates to:
  /// **'Gmail'**
  String get gmail;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Analyze suspicious files and URLs'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Detect malware and automatically share with the security community'**
  String get homeSubtitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @savedReports.
  ///
  /// In en, this message translates to:
  /// **'Saved Reports'**
  String get savedReports;

  /// No description provided for @systemSettings.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettings;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Customize your security analysis experience'**
  String get settingsSubtitle;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @scanReports.
  ///
  /// In en, this message translates to:
  /// **'Scan Reports'**
  String get scanReports;

  /// No description provided for @scanReportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review security analysis results and threat assessments'**
  String get scanReportsSubtitle;

  /// No description provided for @noSavedReports.
  ///
  /// In en, this message translates to:
  /// **'No saved reports yet'**
  String get noSavedReports;

  /// No description provided for @noSavedReportsHint.
  ///
  /// In en, this message translates to:
  /// **'Scan a domain or file and tap the\nbookmark icon to save it here.'**
  String get noSavedReportsHint;

  /// No description provided for @reportRemoved.
  ///
  /// In en, this message translates to:
  /// **'Report removed from saved.'**
  String get reportRemoved;

  /// No description provided for @couldNotOpenReport.
  ///
  /// In en, this message translates to:
  /// **'Could not open report: {error}'**
  String couldNotOpenReport(String error);

  /// No description provided for @vendorsFlagged.
  ///
  /// In en, this message translates to:
  /// **'{malicious}/{total} vendors flagged this'**
  String vendorsFlagged(String malicious, String total);

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @domain.
  ///
  /// In en, this message translates to:
  /// **'Domain'**
  String get domain;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get files;

  /// No description provided for @enterUrlToScan.
  ///
  /// In en, this message translates to:
  /// **'Enter URL to scan'**
  String get enterUrlToScan;

  /// No description provided for @urlSafeHint.
  ///
  /// In en, this message translates to:
  /// **'We\'ll check if it\'s safe to visit'**
  String get urlSafeHint;

  /// No description provided for @enterDomainHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a Domain or URL'**
  String get enterDomainHint;

  /// No description provided for @scanDomain.
  ///
  /// In en, this message translates to:
  /// **'Scan Domain'**
  String get scanDomain;

  /// No description provided for @pleaseEnterDomain.
  ///
  /// In en, this message translates to:
  /// **'Please enter a domain or subdomain (e.g. domain.com)'**
  String get pleaseEnterDomain;

  /// No description provided for @invalidDomainFormat.
  ///
  /// In en, this message translates to:
  /// **'Invalid format. Use: domain.com or sub.domain.com'**
  String get invalidDomainFormat;

  /// No description provided for @chooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose File'**
  String get chooseFile;

  /// No description provided for @fileSafeHint.
  ///
  /// In en, this message translates to:
  /// **'We\'ll check if it\'s safe to open'**
  String get fileSafeHint;

  /// No description provided for @selectFile.
  ///
  /// In en, this message translates to:
  /// **'Select File'**
  String get selectFile;

  /// No description provided for @noFileSelected.
  ///
  /// In en, this message translates to:
  /// **'No file selected'**
  String get noFileSelected;

  /// No description provided for @errorPickingFile.
  ///
  /// In en, this message translates to:
  /// **'Error picking file: {error}'**
  String errorPickingFile(String error);

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingDone.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingDone;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Safe Scan'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In en, this message translates to:
  /// **'Your smart cybersecurity companion — scan URLs, files, and domains for threats in seconds using real-time threat intelligence.'**
  String get onboardingDesc1;

  /// No description provided for @onboardingStat1.
  ///
  /// In en, this message translates to:
  /// **'Powered by Safe Scan App'**
  String get onboardingStat1;

  /// No description provided for @onboardingHighlight1.
  ///
  /// In en, this message translates to:
  /// **'🛡️'**
  String get onboardingHighlight1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Scan & Detect Threats'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In en, this message translates to:
  /// **'Analyze URLs for phishing, verify file hashes against malware databases, and get detailed domain & IP reputation reports — all in one place.'**
  String get onboardingDesc2;

  /// No description provided for @onboardingStat2.
  ///
  /// In en, this message translates to:
  /// **'70+ antivirus engines scanning for you'**
  String get onboardingStat2;

  /// No description provided for @onboardingHighlight2.
  ///
  /// In en, this message translates to:
  /// **'70+'**
  String get onboardingHighlight2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'Stay Protected, Stay Informed'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In en, this message translates to:
  /// **'Get color-coded results — green for safe, yellow for suspicious, red for malicious. Save your scan history and receive real-time security alerts.'**
  String get onboardingDesc3;

  /// No description provided for @onboardingStat3.
  ///
  /// In en, this message translates to:
  /// **'from real-time threat feeds'**
  String get onboardingStat3;

  /// No description provided for @onboardingHighlight3.
  ///
  /// In en, this message translates to:
  /// **'24/7'**
  String get onboardingHighlight3;
  /// No description provided for @securityAwareness.
  ///
  /// In en, this message translates to:
  /// **'Security Awareness'**
  String get securityAwareness;

  /// No description provided for @awarenessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn how to protect yourself against common cyber threats.'**
  String get awarenessSubtitle;

  /// No description provided for @phishingAttacks.
  ///
  /// In en, this message translates to:
  /// **'Phishing Attacks'**
  String get phishingAttacks;

  /// No description provided for @phishingDesc.
  ///
  /// In en, this message translates to:
  /// **'Phishing is a fraudulent attempt to obtain sensitive information by disguising as a trustworthy entity in electronic communication.'**
  String get phishingDesc;

  /// No description provided for @commonAttacks.
  ///
  /// In en, this message translates to:
  /// **'Most Common Attacks'**
  String get commonAttacks;

  /// No description provided for @spearPhishing.
  ///
  /// In en, this message translates to:
  /// **'Spear Phishing'**
  String get spearPhishing;

  /// No description provided for @spearPhishingDesc.
  ///
  /// In en, this message translates to:
  /// **'Targeted attacks using personalized information to trick specific individuals.'**
  String get spearPhishingDesc;

  /// No description provided for @whaling.
  ///
  /// In en, this message translates to:
  /// **'Whaling'**
  String get whaling;

  /// No description provided for @whalingDesc.
  ///
  /// In en, this message translates to:
  /// **'Phishing attacks directed specifically at senior executives and high-profile targets.'**
  String get whalingDesc;

  /// No description provided for @smishing.
  ///
  /// In en, this message translates to:
  /// **'Smishing (SMS Phishing)'**
  String get smishing;

  /// No description provided for @smishingDesc.
  ///
  /// In en, this message translates to:
  /// **'Fraudulent text messages designed to trick you into revealing personal info.'**
  String get smishingDesc;

  /// No description provided for @vishing.
  ///
  /// In en, this message translates to:
  /// **'Vishing (Voice Phishing)'**
  String get vishing;

  /// No description provided for @vishingDesc.
  ///
  /// In en, this message translates to:
  /// **'Phone scams where attackers try to manipulate you into sharing data or transferring money.'**
  String get vishingDesc;

  /// No description provided for @protectionTips.
  ///
  /// In en, this message translates to:
  /// **'How to Protect Yourself'**
  String get protectionTips;

  /// No description provided for @tip1.
  ///
  /// In en, this message translates to:
  /// **'Never click on suspicious links or download unverified attachments.'**
  String get tip1;

  /// No description provided for @tip2.
  ///
  /// In en, this message translates to:
  /// **'Verify the sender\'s email address carefully (e.g., support@paypaI.com vs support@paypal.com).'**
  String get tip2;

  /// No description provided for @tip3.
  ///
  /// In en, this message translates to:
  /// **'Enable Two-Factor Authentication (2FA) on all your accounts.'**
  String get tip3;

  /// No description provided for @tip4.
  ///
  /// In en, this message translates to:
  /// **'Never share your passwords, OTPs, or financial information over phone or email.'**
  String get tip4;

  /// No description provided for @tip5.
  ///
  /// In en, this message translates to:
  /// **'Keep your software and operating systems up to date.'**
  String get tip5;

  /// No description provided for @attackStatistics.
  ///
  /// In en, this message translates to:
  /// **'Global Attack Statistics'**
  String get attackStatistics;

  /// No description provided for @stat1.
  ///
  /// In en, this message translates to:
  /// **'36% of all data breaches involve phishing.'**
  String get stat1;

  /// No description provided for @stat2.
  ///
  /// In en, this message translates to:
  /// **'83% of organizations experienced a successful email-based phishing attack in 2021.'**
  String get stat2;

  /// No description provided for @stat3.
  ///
  /// In en, this message translates to:
  /// **'Spear phishing accounts for 95% of enterprise network attacks.'**
  String get stat3;

  /// No description provided for @stat4.
  ///
  /// In en, this message translates to:
  /// **'Over 3.4 billion malicious emails are sent worldwide every day.'**
  String get stat4;

  /// No description provided for @realWorldScenarios.
  ///
  /// In en, this message translates to:
  /// **'Real-World Scenarios: What if...?'**
  String get realWorldScenarios;

  /// No description provided for @whatIfClickLink.
  ///
  /// In en, this message translates to:
  /// **'What if I click a malicious link?'**
  String get whatIfClickLink;

  /// No description provided for @whatIfClickLinkDesc.
  ///
  /// In en, this message translates to:
  /// **'If you open a malicious link, you might be directed to a fake login page that looks exactly like a service you use (e.g., your bank or email). If you enter your credentials, the attackers steal them immediately. Sometimes, just visiting the site can silently download malware to your device.'**
  String get whatIfClickLinkDesc;

  /// No description provided for @whatIfOpenFile.
  ///
  /// In en, this message translates to:
  /// **'What if I open a malicious file?'**
  String get whatIfOpenFile;

  /// No description provided for @whatIfOpenFileDesc.
  ///
  /// In en, this message translates to:
  /// **'Opening a malicious attachment (like a fake PDF or Word document) can run hidden code. This could install \'Ransomware\' that encrypts all your personal files and demands money to unlock them, or a \'Keylogger\' that records everything you type, including your passwords.'**
  String get whatIfOpenFileDesc;

  /// No description provided for @whatIfEnterDetails.
  ///
  /// In en, this message translates to:
  /// **'What if I give away my details?'**
  String get whatIfEnterDetails;

  /// No description provided for @whatIfEnterDetailsDesc.
  ///
  /// In en, this message translates to:
  /// **'Once attackers have your information, they can lock you out of your own accounts, steal your money, or impersonate you to trick your friends, family, or colleagues into sending them money.'**
  String get whatIfEnterDetailsDesc;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
