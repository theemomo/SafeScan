import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safe_scan/features/scan/domain/entities/file_response_model.dart';
import 'package:safe_scan/features/scan/domain/errors/virustotal_exceptions.dart';
import 'package:safe_scan/features/scan/domain/repos/api_repo.dart';

part 'scan_file_state.dart';

class ScanFileCubit extends Cubit<ScanFileState> {
  final ApiRepo apiRepo;

  ScanFileCubit(this.apiRepo) : super(ScanFileInitial());

  Future<void> scanFile(String hash) async {
    emit(ScanFileLoading());
    try {
      final FileResponseModel fileReport = await apiRepo.fetchFileReport(hash);

      if (fileReport.isNotFound) {
        emit(ScanFileNotFound('No report found for this file hash.'));
      } else {
        emit(ScanFileLoaded(fileReport));
      }
    } on NotFoundException catch (e) {
      emit(ScanFileNotFound(e.message));
    } on VirusTotalException catch (e) {
      emit(ScanFileError(e.message));
    } catch (e) {
      emit(ScanFileError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
