part of 'scan_domain_cubit.dart';

@immutable
abstract class ScanDomainState {}

class ScanDomainInitial extends ScanDomainState {}

class ScanDomainLoading extends ScanDomainState {}

class ScanDomainLoaded extends ScanDomainState {
  final DomainResponseModel domainReport;

  ScanDomainLoaded(this.domainReport);
}

class ScanDomainError extends ScanDomainState {
  final String message;

  ScanDomainError(this.message);
}
