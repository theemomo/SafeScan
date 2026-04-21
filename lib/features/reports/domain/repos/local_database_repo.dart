import 'package:safe_scan/features/reports/domain/entities/saved_report.dart';

abstract class LocalDatabaseRepo {

  /// Fetch all reports ordered by newest first.
  Future<List<SavedReport>> getAllReports();

  /// Insert a report. Returns the new row id.
  Future<int> insertReport(SavedReport report);

  /// Delete a report by id.
  Future<void> deleteReport(int id);

  /// Check if a report already exists by target + type.
  Future<bool> reportExists(String target, String scanType);

  /// Update the ai_summary for an existing saved report.
  Future<void> updateAiSummary(int id, String aiSummary);

}
