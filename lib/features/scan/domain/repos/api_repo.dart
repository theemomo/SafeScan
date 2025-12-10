import 'package:safe_scan/features/scan/domain/entities/domain_response_model.dart';

abstract class ApiRepo {
  Future<DomainResponseModel> fetchDomainReport(String domain);
  Future<DomainResponseModel> fetchFileReport(String fileHash);
}
