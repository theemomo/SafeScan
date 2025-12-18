import 'package:safe_scan/features/scan/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/scan/domain/entities/file_response_model.dart';

abstract class ApiRepo {
  Future<DomainResponseModel> fetchDomainReport(String domain);
  Future<FileResponseModel> fetchFileReport(String fileHash);
}
