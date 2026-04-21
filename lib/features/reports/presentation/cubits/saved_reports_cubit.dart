import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_scan/features/reports/domain/entities/saved_report.dart';
import 'package:safe_scan/features/reports/domain/repos/local_database_repo.dart';

part 'saved_reports_state.dart';

class SavedReportsCubit extends Cubit<SavedReportsState> {
  final LocalDatabaseRepo _repo;

  SavedReportsCubit(this._repo) : super(SavedReportsInitial());

  /// Load all reports from SQLite.
  Future<void> loadReports() async {
    emit(SavedReportsLoading());
    try {
      final reports = await _repo.getAllReports();
      emit(SavedReportsLoaded(reports));
    } catch (e) {
      emit(SavedReportsError('Failed to load reports: ${e.toString()}'));
    }
  }

  /// Save a new report. Emits [SavedReportsSaved] on success.
  Future<void> saveReport(SavedReport report) async {
    try {
      // Check duplicate
      final exists = await _repo.reportExists(report.target, report.scanType);
      if (exists) {
        emit(SavedReportsAlreadySaved());
        return;
      }
      await _repo.insertReport(report);
      emit(SavedReportsSaved());
    } catch (e) {
      emit(SavedReportsError('Failed to save report: ${e.toString()}'));
    }
  }

  /// Delete a report and reload the list.
  Future<void> deleteReport(int id) async {
    try {
      await _repo.deleteReport(id);
      final reports = await _repo.getAllReports();
      emit(SavedReportsLoaded(reports));
    } catch (e) {
      emit(SavedReportsError('Failed to delete report: ${e.toString()}'));
    }
  }

  /// Check if a report is already saved (useful for the bookmark icon state).
  Future<bool> isReportSaved(String target, String scanType) async {
    return _repo.reportExists(target, scanType);
  }
}
