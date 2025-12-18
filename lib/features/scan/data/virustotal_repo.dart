import 'package:dio/dio.dart';
import 'package:safe_scan/features/scan/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/scan/domain/entities/file_response_model.dart';
import 'package:safe_scan/features/scan/domain/errors/virustotal_exceptions.dart';
import 'package:safe_scan/features/scan/domain/repos/api_repo.dart';

class VirustotalRepo extends ApiRepo {
  final Dio dio;

  VirustotalRepo({Dio? dio}) : dio = dio ?? Dio();

  @override
  Future<DomainResponseModel> fetchDomainReport(String domain) async {
    final url = 'https://www.virustotal.com/api/v3/domains/$domain';
    final headers = {
      'accept': 'application/json',
      'x-apikey': '27a3345dd74283ea143bad8dff4d4b5240ca5d018a7f9b24f7658656ba4de51d',
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
        final statusCode = e.response?.statusCode;
        final errorData = e.response?.data;
        final message = (errorData != null && errorData['error'] != null)
            ? errorData['error']['message'] ?? 'Unknown error'
            : 'Unknown error';

        switch (statusCode) {
          case 400:
            throw BadRequestException(message);
          case 401:
            throw UnauthorizedException(message);
          case 404:
            // This is the key: handle the "hash not found" scenario
            throw NotFoundException(message);
          case 500:
            throw ServerException(message, 500);
          default:
            throw UnknownException(message);
        }
      } else {
        throw NetworkException('No internet connection or server unreachable');
      }
    } catch (e) {
      throw UnknownException('An unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<FileResponseModel> fetchFileReport(String fileHash) async {
    final url = 'https://www.virustotal.com/api/v3/files/$fileHash';
    final headers = {
      'accept': 'application/json',
      'x-apikey': '27a3345dd74283ea143bad8dff4d4b5240ca5d018a7f9b24f7658656ba4de51d',
    };

    try {
      final response = await dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) {
        return FileResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          'Failed to fetch file report: Unknown error',
          response.statusCode ?? 0,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final errorData = e.response?.data;
        final message = (errorData != null && errorData['error'] != null)
            ? errorData['error']['message'] ?? 'Unknown error'
            : 'Unknown error';

        switch (statusCode) {
          case 400:
            throw BadRequestException(message);
          case 401:
            throw UnauthorizedException(message);
          case 404:
            // This is the key: handle the "hash not found" scenario
            throw NotFoundException(message);
          case 500:
            throw ServerException(message, 500);
          default:
            throw UnknownException(message);
        }
      } else {
        throw NetworkException('No internet connection or server unreachable');
      }
    } catch (e) {
      throw UnknownException('An unexpected error occurred: ${e.toString()}');
    }
  }
}
