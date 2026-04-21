import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safe_scan/features/reports/domain/entities/saved_report.dart';
import 'package:safe_scan/features/reports/domain/repos/local_database_repo.dart';

class SharedPreferencesReportsDB implements LocalDatabaseRepo {
  static const _keyReports = 'safe_scan_saved_reports_list';

  int _nextId(List<SavedReport> reports) {
    if (reports.isEmpty) return 1;
    final ids = reports.map((e) => e.id ?? 0).toList();
    ids.sort();
    return ids.last + 1;
  }

  Future<void> _saveReports(List<SavedReport> reports) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = reports.map((r) => jsonEncode(r.toMap())).toList();
    await prefs.setStringList(_keyReports, jsonList);
  }

  @override
  Future<List<SavedReport>> getAllReports() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_keyReports) ?? [];

    final reports = jsonList.map((str) {
      final map = jsonDecode(str) as Map<String, dynamic>;
      return SavedReport.fromMap(map);
    }).toList();

    // Sort descending by savedAt
    reports.sort((a, b) => b.savedAt.compareTo(a.savedAt));
    return reports;
  }

  /// Insert a report. Returns the new row id.
  @override
  Future<int> insertReport(SavedReport report) async {
    final reports = await getAllReports();
    // Assign a new ID if it doesn't have one
    int id = report.id ?? _nextId(reports);

    // Check if we are replacing by ID
    final index = reports.indexWhere((r) => r.id == id);

    final updatedReport = SavedReport(
      id: id,
      scanType: report.scanType,
      target: report.target,
      threatLabel: report.threatLabel,
      maliciousCount: report.maliciousCount,
      totalVendors: report.totalVendors,
      aiSummary: report.aiSummary,
      rawJson: report.rawJson,
      savedAt: report.savedAt,
    );

    if (index >= 0) {
      reports[index] = updatedReport;
    } else {
      reports.add(updatedReport);
    }

    await _saveReports(reports);
    return id;
  }

  /// Delete a report by id.
  @override
  Future<void> deleteReport(int id) async {
    final reports = await getAllReports();
    reports.removeWhere((r) => r.id == id);
    await _saveReports(reports);
  }

  /// Check if a report already exists by target + type.
  @override
  Future<bool> reportExists(String target, String scanType) async {
    final reports = await getAllReports();
    return reports.any((r) => r.target == target && r.scanType == scanType);
  }

  /// Update the ai_summary for an existing saved report.
  @override
  Future<void> updateAiSummary(int id, String aiSummary) async {
    final reports = await getAllReports();
    final index = reports.indexWhere((r) => r.id == id);
    if (index >= 0) {
      final old = reports[index];
      final updated = SavedReport(
        id: old.id,
        scanType: old.scanType,
        target: old.target,
        threatLabel: old.threatLabel,
        maliciousCount: old.maliciousCount,
        totalVendors: old.totalVendors,
        aiSummary: aiSummary,
        rawJson: old.rawJson,
        savedAt: old.savedAt,
      );
      reports[index] = updated;
      await _saveReports(reports);
    }
  }
}
