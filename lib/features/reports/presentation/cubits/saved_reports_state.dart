part of 'saved_reports_cubit.dart';

abstract class SavedReportsState {}

class SavedReportsInitial extends SavedReportsState {}

class SavedReportsLoading extends SavedReportsState {}

class SavedReportsLoaded extends SavedReportsState {
  final List<SavedReport> reports;
  SavedReportsLoaded(this.reports);
}

class SavedReportsSaved extends SavedReportsState {}

class SavedReportsAlreadySaved extends SavedReportsState {}

class SavedReportsError extends SavedReportsState {
  final String message;
  SavedReportsError(this.message);
}
