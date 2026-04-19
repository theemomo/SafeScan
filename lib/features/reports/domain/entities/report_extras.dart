import 'package:safe_scan/features/scan/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/scan/domain/entities/file_response_model.dart'
    as file_model;

/// Passed as GoRouter `extra` when navigating to DomainReportScreen.
/// [cachedAiSummary]: if non-null and non-empty the AI tab shows this text
/// immediately without calling Gemini.
class DomainReportExtra {
  final DomainResponseModel model;
  final String? cachedAiSummary;

  const DomainReportExtra({
    required this.model,
    this.cachedAiSummary,
  });
}

/// Passed as GoRouter `extra` when navigating to FileReportScreen.
class FileReportExtra {
  final file_model.FileResponseModel model;
  final String? cachedAiSummary;

  const FileReportExtra({
    required this.model,
    this.cachedAiSummary,
  });
}
