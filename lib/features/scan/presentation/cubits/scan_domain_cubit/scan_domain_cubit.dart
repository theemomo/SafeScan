import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:safe_scan/features/scan/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/scan/domain/errors/virustotal_exceptions.dart';
import 'package:safe_scan/features/scan/domain/repos/api_repo.dart';

part 'scan_domain_state.dart';

class ScanDomainCubit extends Cubit<ScanDomainState> {
  final ApiRepo apiRepo;

  ScanDomainCubit(this.apiRepo) : super(ScanDomainInitial());

  Future<void> scanDomain(String domain) async {
    emit(ScanDomainLoading());
    try {
      final DomainResponseModel domainReport = await apiRepo.fetchDomainReport(
        domain,
      );
      if (domainReport.isNotFound) {
        emit(ScanDomainNotFound('No report found for this domain.'));
      } else {
        emit(ScanDomainLoaded(domainReport));
      }
    } on NotFoundException catch (e) {
      emit(ScanDomainNotFound(e.message));
    } on VirusTotalException catch (e) {
      emit(ScanDomainError(e.message));
    } catch (e) {
      emit(ScanDomainError('An unexpected error occurred: ${e.toString()}'));
    }
  }
}
