import 'package:dio/dio.dart';
import 'package:safe_scan/features/home/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/home/domain/errors/virustotal_exceptions.dart';
import 'package:safe_scan/features/home/domain/repos/api_repo.dart';

class VirustotalRepo extends ApiRepo {
  final dio = Dio();
  @override
  Future<DomainResponseModel> fetchDomainReport(String domain) async {
    final url = 'https://www.virustotal.com/api/v3/domains/$domain';
    final headers = {
      'accept': 'application/json',
      'x-apikey':
          'YOUR_VIRUSTOTAL_API_KEY',
    };

    try {
      final response = await dio.get(url, options: Options(headers: headers));
      if (response.statusCode == 200) {
        return DomainResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          'Failed to fetch domain report: Unknown error',
          response.statusCode!,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException(
              e.response?.data['error'] ?? 'Bad Request',
            );
          case 401:
            throw UnauthorizedException(
              e.response?.data['error'] ?? 'Unauthorized',
            );
          case 404:
            throw NotFoundException(
              e.response?.data['error'] ?? 'Domain not found',
            );
          case 500:
            throw ServerException(
              e.response?.data['error'] ?? 'Internal Server Error',
              500,
            );
          default:
            throw UnknownException(
              e.response?.data['error'] ?? 'An unknown error occurred',
            );
        }
      } else {
        throw NetworkException('No internet connection or server unreachable');
      }
    } catch (e) {
      throw UnknownException('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<DomainResponseModel> fetchFileReport(String fileHash) {
    // TODO: implement fetchFileReport
    throw UnimplementedError();
  }
}
