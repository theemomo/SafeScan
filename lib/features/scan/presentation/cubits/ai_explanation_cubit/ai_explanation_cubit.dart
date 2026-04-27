import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:safe_scan/features/scan/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/scan/domain/entities/file_response_model.dart'
    as file_model;

part 'ai_explanation_state.dart';

/// Cubit responsible for generating AI-powered explanations of scan results (Domains & Files).
/// Uses the Gemini API via the flutter_gemini package.
class AiExplanationCubit extends Cubit<AiExplanationState> {
  AiExplanationCubit() : super(AiExplanationInitial());

  /// Immediately emits [AiExplanationLoaded] with [cachedText].
  /// Used when opening a saved report that already has an AI summary.
  void loadCached(String cachedText) {
    if (cachedText.isNotEmpty) {
      emit(AiExplanationLoaded(cachedText));
    } else {
      emit(AiExplanationInitial());
    }
  }

  static const int _whoisMaxLength = 800;

  /// Generates an explanation for a Domain scan report.
  /// [appLanguage] should be the BCP-47 language code of the app locale (e.g. 'ar', 'en').
  Future<void> generateExplanation(
    DomainResponseModel reportData, {
    String appLanguage = 'en',
  }) async {
    emit(AiExplanationLoading());

    try {
      final scanSummary = _buildDomainScanSummary(reportData);
      final prompt = _buildPrompt(
        entityName: reportData.data?.id ?? 'this domain',
        entityType: 'domain',
        scanSummary: scanSummary,
        appLanguage: appLanguage,
      );

      await _executeGeminiPrompt(prompt);
    } catch (e) {
      final errorStr = e.toString();
      if (errorStr.contains('429')) {
        emit(
          AiExplanationError(
            'API Rate Limit Exceeded.\nPlease wait a minute before requesting another AI summary.',
          ),
        );
      } else {
        emit(AiExplanationError('AI Analysis failed: $errorStr'));
      }
    }
  }

  /// Generates an explanation for a File scan report.
  /// [appLanguage] should be the BCP-47 language code of the app locale (e.g. 'ar', 'en').
  Future<void> generateFileExplanation(
    file_model.FileResponseModel reportData, {
    String appLanguage = 'en',
  }) async {
    emit(AiExplanationLoading());

    try {
      final scanSummary = _buildFileScanSummary(reportData);
      final prompt = _buildPrompt(
        entityName: reportData.data?.attributes.meaningfulName ?? 'this file',
        entityType: 'file',
        scanSummary: scanSummary,
        appLanguage: appLanguage,
      );

      await _executeGeminiPrompt(prompt);
    } catch (e) {
      final errorStr = e.toString();
      if (errorStr.contains('429')) {
        emit(
          AiExplanationError(
            'API Rate Limit Exceeded.\nPlease wait a minute before requesting another AI summary.',
          ),
        );
      } else {
        emit(AiExplanationError('AI Analysis failed: $errorStr'));
      }
    }
  }

  /// Shared method to execute the prompt via Gemini.
  Future<void> _executeGeminiPrompt(String prompt) async {
    final response = await Gemini.instance.prompt(parts: [Part.text(prompt)]);

    final text = response?.output;

    if (text != null && text.isNotEmpty) {
      emit(AiExplanationLoaded(text));
    } else {
      emit(AiExplanationError('Gemini returned an empty response.'));
    }
  }

  /// Builds a structured scan summary string for a Domain.
  String _buildDomainScanSummary(DomainResponseModel reportData) {
    final domainName = reportData.data?.id ?? 'this domain';
    final attrs = reportData.data?.attributes;
    final stats = attrs?.lastAnalysisStats;

    final harmless = stats?.harmless ?? 0;
    final malicious = stats?.malicious ?? 0;
    final suspicious = stats?.suspicious ?? 0;
    final undetected = stats?.undetected ?? 0;
    final totalEngines = harmless + malicious + suspicious + undetected;

    final registrar = attrs?.registrar ?? 'Unknown';
    final reputation = attrs?.reputation?.toString() ?? 'N/A';
    final tags = attrs?.tags?.join(', ') ?? 'None';
    final whois = _truncateWhois(attrs?.whois);
    final categoriesStr = _buildCategoriesString(attrs?.categories);
    final maliciousVendors = _buildMaliciousVendorsString(
      attrs?.lastAnalysisResults.values.toList() ?? [],
    );

    final buffer = StringBuffer()
      ..writeln('Domain: $domainName')
      ..writeln('Total Engines Scanned: $totalEngines')
      ..writeln('Malicious/Suspicious Detections: ${malicious + suspicious}')
      ..writeln('Harmless: $harmless')
      ..writeln('Undetected: $undetected')
      ..writeln('Registrar: $registrar')
      ..writeln('Reputation Score: $reputation')
      ..writeln('Tags: $tags')
      ..writeln('Categories: $categoriesStr');

    if (maliciousVendors.isNotEmpty) {
      buffer.writeln('Flagged by vendors: $maliciousVendors');
    }

    buffer.writeln('WHOIS (partial): $whois');

    return buffer.toString();
  }

  /// Builds a structured scan summary string for a File.
  String _buildFileScanSummary(file_model.FileResponseModel reportData) {
    final attrs = reportData.data?.attributes;
    if (attrs == null) return 'No attributes found for this file.';

    final stats = attrs.lastAnalysisStats;
    final harmless = stats?.harmless ?? 0;
    final malicious = stats?.malicious ?? 0;
    final suspicious = stats?.suspicious ?? 0;
    final undetected = stats?.undetected ?? 0;
    final totalEngines = harmless + malicious + suspicious + undetected;

    final typeDescription = attrs.typeDescription;
    final fileSize = _formatBytes(attrs.size);
    final reputation = attrs.reputation.toString();
    final tags = attrs.tags.join(', ');
    final resultList = attrs.lastAnalysisResults.values.toList();

    final maliciousVendors = _buildFileMaliciousVendorsString(resultList);

    final buffer = StringBuffer()
      ..writeln('File Name: ${attrs.meaningfulName}')
      ..writeln('File Type: $typeDescription')
      ..writeln('File Size: $fileSize')
      ..writeln('SHA256: ${attrs.sha256}')
      ..writeln('Total Engines Scanned: $totalEngines')
      ..writeln('Malicious/Suspicious Detections: ${malicious + suspicious}')
      ..writeln('Harmless: $harmless')
      ..writeln('Undetected: $undetected')
      ..writeln('Reputation Score: $reputation')
      ..writeln('Tags: $tags');

    if (maliciousVendors.isNotEmpty) {
      buffer.writeln('Flagged by vendors: $maliciousVendors');
    }

    if (attrs.trid.isNotEmpty) {
      final tridInfo = attrs.trid.take(3).map((e) => e.fileType).join(', ');
      buffer.writeln('Type identification (TrID): $tridInfo');
    }

    return buffer.toString();
  }

  /// Returns a truncated WHOIS string, or a fallback message if unavailable.
  String _truncateWhois(String? whois) {
    if (whois == null || whois.isEmpty) return 'Not available';
    final clampedLength = whois.length.clamp(0, _whoisMaxLength);
    return whois.substring(0, clampedLength);
  }

  /// Builds a comma-separated string of category entries.
  String _buildCategoriesString(Map<String, String>? categories) {
    return categories?.entries.map((e) => '${e.key}: ${e.value}').join(', ') ??
        'None';
  }

  /// Builds a comma-separated string of vendors that flagged a Domain.
  String _buildMaliciousVendorsString(List<LastAnalysisResult> results) {
    return results
        .where(
          (r) =>
              r.category == Category.MALICIOUS ||
              r.category == Category.SUSPICIOUS,
        )
        .map((r) => '${r.engineName} (${resultValues.reverse[r.result]})')
        .join(', ');
  }

  /// Builds a comma-separated string of vendors that flagged a File.
  String _buildFileMaliciousVendorsString(
    List<file_model.LastAnalysisResult> results,
  ) {
    return results
        .where(
          (r) =>
              r.category == file_model.Category.MALICIOUS ||
              r.category == file_model.Category.SUSPICIOUS,
        )
        .map(
          (r) =>
              '${r.engineName} (${file_model.resultValues.reverse[r.result]})',
        )
        .join(', ');
  }

  /// Helper to format bytes to human readable string.
  String _formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    // const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    // var i = (bytes.toString().length - 1) ~/ 3;
    // var res = (bytes / (1000 * i * i)).toStringAsFixed(decimals);
    // Simplified logic for brevity in prompt building
    if (bytes < 1024) return "$bytes B";
    if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(1)} KB";
    return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
  }

  /// Builds the full prompt string for Gemini.
  /// [appLanguage] controls which language the AI must respond in.
  String _buildPrompt({
    required String entityName,
    required String entityType,
    required String scanSummary,
    String appLanguage = 'en',
  }) {
    final languageInstruction = appLanguage == 'ar'
        ? '''
أنت مساعد ذكاء اصطناعي مدمج داخل تطبيق جوال.
يجب أن تكون إجابتك باللغة العربية فقط، بغض النظر عن لغة المستخدم.
استخدم لغة عربية واضحة وبسيطة ومناسبة لمستخدم غير متخصص.
لا تخلط بين العربية والإنجليزية في نفس الرد إلا للمصطلحات التقنية الضرورية.
'''
        : '''
You are an AI assistant built inside a mobile app.
Always respond in English only, regardless of the user's input language.
Use clear, simple, and friendly language suitable for non-technical users.
Do not mix languages in the same response.
''';

    return '''
$languageInstruction
You are a cybersecurity expert helping everyday non-technical users understand online safety reports.
Analyze the following VirusTotal $entityType scan results and provide:

1. **Safety Verdict**: Is the $entityType "$entityName" safe? Give a clear, plain-language answer.
2. **What this $entityType does**: Explain its behavior and purpose based on the data.
3. **Risk level**: Low, Medium, or High, and why.
4. **Recommendations**: Simple, actionable advice for a non-technical user.

Use Markdown formatting (bold, bullet lists). Keep it simple and friendly. Avoid heavy technical jargon.

--- Scan Data ---
$scanSummary
''';
  }
}
