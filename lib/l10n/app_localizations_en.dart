// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'SafeScan';

  @override
  String get login => 'Login';

  @override
  String get loginTagline =>
      'Login to safely scan your links and stay ahead of online threats.';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'Enter email or phone number';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Enter Password';

  @override
  String get or => 'Or';

  @override
  String get facebook => 'Facebook';

  @override
  String get google => 'Google';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get createAccount => 'Create Account';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get registerTagline => 'Scan links and protect your digital shield.';

  @override
  String get username => 'Username';

  @override
  String get usernameHint => 'Enter your username';

  @override
  String get signUp => 'Sign Up';

  @override
  String get gmail => 'Gmail';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get homeTitle => 'Analyze suspicious files and URLs';

  @override
  String get homeSubtitle =>
      'Detect malware and automatically share with the security community';

  @override
  String get home => 'Home';

  @override
  String get savedReports => 'Saved Reports';

  @override
  String get systemSettings => 'System Settings';

  @override
  String get logOut => 'Log out';

  @override
  String get settings => 'Settings';

  @override
  String get settingsSubtitle => 'Customize your security analysis experience';

  @override
  String get changePassword => 'Change password';

  @override
  String get notifications => 'Notifications';

  @override
  String get language => 'Language';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get scanReports => 'Scan Reports';

  @override
  String get scanReportsSubtitle =>
      'Review security analysis results and threat assessments';

  @override
  String get noSavedReports => 'No saved reports yet';

  @override
  String get noSavedReportsHint =>
      'Scan a domain or file and tap the\nbookmark icon to save it here.';

  @override
  String get reportRemoved => 'Report removed from saved.';

  @override
  String couldNotOpenReport(String error) {
    return 'Could not open report: $error';
  }

  @override
  String vendorsFlagged(String malicious, String total) {
    return '$malicious/$total vendors flagged this';
  }

  @override
  String get file => 'File';

  @override
  String get url => 'URL';

  @override
  String get domain => 'Domain';

  @override
  String get files => 'Files';

  @override
  String get enterUrlToScan => 'Enter URL to scan';

  @override
  String get urlSafeHint => 'We\'ll check if it\'s safe to visit';

  @override
  String get enterDomainHint => 'Enter a Domain or URL';

  @override
  String get scanDomain => 'Scan Domain';

  @override
  String get pleaseEnterDomain =>
      'Please enter a domain or subdomain (e.g. domain.com)';

  @override
  String get invalidDomainFormat =>
      'Invalid format. Use: domain.com or sub.domain.com';

  @override
  String get chooseFile => 'Choose File';

  @override
  String get fileSafeHint => 'We\'ll check if it\'s safe to open';

  @override
  String get selectFile => 'Select File';

  @override
  String get noFileSelected => 'No file selected';

  @override
  String errorPickingFile(String error) {
    return 'Error picking file: $error';
  }

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingDone => 'Get Started';

  @override
  String get onboardingTitle1 => 'Welcome to Safe Scan';

  @override
  String get onboardingDesc1 =>
      'Your smart cybersecurity companion — scan URLs, files, and domains for threats in seconds using real-time threat intelligence.';

  @override
  String get onboardingStat1 => 'Powered by Safe Scan App';

  @override
  String get onboardingHighlight1 => '🛡️';

  @override
  String get onboardingTitle2 => 'Scan & Detect Threats';

  @override
  String get onboardingDesc2 =>
      'Analyze URLs for phishing, verify file hashes against malware databases, and get detailed domain & IP reputation reports — all in one place.';

  @override
  String get onboardingStat2 => '70+ antivirus engines scanning for you';

  @override
  String get onboardingHighlight2 => '70+';

  @override
  String get onboardingTitle3 => 'Stay Protected, Stay Informed';

  @override
  String get onboardingDesc3 =>
      'Get color-coded results — green for safe, yellow for suspicious, red for malicious. Save your scan history and receive real-time security alerts.';

  @override
  String get onboardingStat3 => 'from real-time threat feeds';

  @override
  String get onboardingHighlight3 => '24/7';
}
