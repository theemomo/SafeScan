part of 'scan_file_cubit.dart';

sealed class ScanFileState extends Equatable {
  const ScanFileState();
  @override
  List<Object> get props => [];
}

final class ScanFileInitial extends ScanFileState {}

class ScanFileLoading extends ScanFileState {}

class ScanFileLoaded extends ScanFileState {
  final FileResponseModel fileReport;

  const ScanFileLoaded(this.fileReport);
}

class ScanFileError extends ScanFileState {
  final String message;

  const ScanFileError(this.message);
}

class ScanFileNotFound extends ScanFileState {
  final String message;

  const ScanFileNotFound(this.message);
}
