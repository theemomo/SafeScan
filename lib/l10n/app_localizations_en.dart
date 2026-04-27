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
  String get securityAwareness => 'Security Awareness';

  @override
  String get awarenessSubtitle =>
      'Learn how to protect yourself against common cyber threats.';

  @override
  String get phishingAttacks => 'Phishing Attacks';

  @override
  String get phishingDesc =>
      'Phishing is a fraudulent attempt to obtain sensitive information by disguising as a trustworthy entity in electronic communication.';

  @override
  String get commonAttacks => 'Most Common Attacks';

  @override
  String get spearPhishing => 'Spear Phishing';

  @override
  String get spearPhishingDesc =>
      'Targeted attacks using personalized information to trick specific individuals.';

  @override
  String get whaling => 'Whaling';

  @override
  String get whalingDesc =>
      'Phishing attacks directed specifically at senior executives and high-profile targets.';

  @override
  String get smishing => 'Smishing (SMS Phishing)';

  @override
  String get smishingDesc =>
      'Fraudulent text messages designed to trick you into revealing personal info.';

  @override
  String get vishing => 'Vishing (Voice Phishing)';

  @override
  String get vishingDesc =>
      'Phone scams where attackers try to manipulate you into sharing data or transferring money.';

  @override
  String get protectionTips => 'How to Protect Yourself';

  @override
  String get tip1 =>
      'Never click on suspicious links or download unverified attachments.';

  @override
  String get tip2 =>
      'Verify the sender\'s email address carefully (e.g., support@paypaI.com vs support@paypal.com).';

  @override
  String get tip3 =>
      'Enable Two-Factor Authentication (2FA) on all your accounts.';

  @override
  String get tip4 =>
      'Never share your passwords, OTPs, or financial information over phone or email.';

  @override
  String get tip5 => 'Keep your software and operating systems up to date.';

  @override
  String get attackStatistics => 'Global Attack Statistics';

  @override
  String get stat1 => '36% of all data breaches involve phishing.';

  @override
  String get stat2 =>
      '83% of organizations experienced a successful email-based phishing attack in 2021.';

  @override
  String get stat3 =>
      'Spear phishing accounts for 95% of enterprise network attacks.';

  @override
  String get stat4 =>
      'Over 3.4 billion malicious emails are sent worldwide every day.';

  @override
  String get realWorldScenarios => 'Real-World Scenarios: What if...?';

  @override
  String get whatIfClickLink => 'What if I click a malicious link?';

  @override
  String get whatIfClickLinkDesc =>
      'If you open a malicious link, you might be directed to a fake login page that looks exactly like a service you use (e.g., your bank or email). If you enter your credentials, the attackers steal them immediately. Sometimes, just visiting the site can silently download malware to your device.';

  @override
  String get whatIfOpenFile => 'What if I open a malicious file?';

  @override
  String get whatIfOpenFileDesc =>
      'Opening a malicious attachment (like a fake PDF or Word document) can run hidden code. This could install \'Ransomware\' that encrypts all your personal files and demands money to unlock them, or a \'Keylogger\' that records everything you type, including your passwords.';

  @override
  String get whatIfEnterDetails => 'What if I give away my details?';

  @override
  String get whatIfEnterDetailsDesc =>
      'Once attackers have your information, they can lock you out of your own accounts, steal your money, or impersonate you to trick your friends, family, or colleagues into sending them money.';
}
