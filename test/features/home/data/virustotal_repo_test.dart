import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:safe_scan/features/home/data/virustotal_repo.dart';
import 'package:safe_scan/features/home/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/home/domain/errors/virustotal_exceptions.dart';
import 'package:safe_scan/features/home/domain/repos/api_repo.dart';

import 'virustotal_repo_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late VirustotalRepo repo;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    repo = VirustotalRepo(dio: mockDio);
  });

  group('VirustotalRepo', () {
    test('should be a subclass of ApiRepo', () {
      expect(repo, isA<ApiRepo>());
    });

    group('fetchDomainReport', () {
      final tDomain = 'example.com';
      final tDomainResponseJson = {
        'data': {
          'id': 'u-a-example.com',
          'type': 'domain',
          'links': {'self': 'https://www.virustotal.com/api/v3/domains/example.com'},
          'attributes': {
            'last_analysis_results': {
              "Sophos": {
                "category": "harmless",
                "engine_name": "Sophos",
                "method": "blacklist",
                "result": "clean"
              },
            },
            'last_analysis_stats': {
              "malicious": 0,
              "suspicious": 0,
              "undetected": 1,
              "harmless": 1,
              "timeout": 0
            },
            'last_dns_records': [
              {
                'type': 'A',
                'ttl': 3600,
                'value': '93.184.216.34',
                'priority': null,
              }
            ],
          }
        }
      };

      final tDomainResponseModel = DomainResponseModel.fromJson(tDomainResponseJson);

      test('should return DomainResponseModel when the call to API is successful (200)', () async {
        when(mockDio.get(
          any,
          options: anyNamed('options'),
        )).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: tDomainResponseJson,
            statusCode: 200,
          ),
        );

        final result = await repo.fetchDomainReport(tDomain);

        expect(result, equals(tDomainResponseModel));
        verify(mockDio.get(
          'https://www.virustotal.com/api/v3/domains/$tDomain',
          options: anyNamed('options'),
        ));
        verifyNoMoreInteractions(mockDio);
      });

      test('should throw NotFoundException when the API call returns 404', () async {
        when(mockDio.get(
          any,
          options: anyNamed('options'),
        )).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              data: {'error': 'Domain not found'},
              statusCode: 404,
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        expect(
          () => repo.fetchDomainReport(tDomain),
          throwsA(isA<NotFoundException>()),
        );
        verify(mockDio.get(
          'https://www.virustotal.com/api/v3/domains/$tDomain',
          options: anyNamed('options'),
        ));
        verifyNoMoreInteractions(mockDio);
      });

      test('should throw UnauthorizedException when the API call returns 401', () async {
        when(mockDio.get(
          any,
          options: anyNamed('options'),
        )).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              data: {'error': 'Unauthorized'},
              statusCode: 401,
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        expect(
          () => repo.fetchDomainReport(tDomain),
          throwsA(isA<UnauthorizedException>()),
        );
      });

      test('should throw BadRequestException when the API call returns 400', () async {
        when(mockDio.get(
          any,
          options: anyNamed('options'),
        )).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              data: {'error': 'Bad Request'},
              statusCode: 400,
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        expect(
          () => repo.fetchDomainReport(tDomain),
          throwsA(isA<BadRequestException>()),
        );
      });

      test('should throw ServerException when the API call returns 500', () async {
        when(mockDio.get(
          any,
          options: anyNamed('options'),
        )).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            response: Response(
              requestOptions: RequestOptions(path: ''),
              data: {'error': 'Internal Server Error'},
              statusCode: 500,
            ),
            type: DioExceptionType.badResponse,
          ),
        );

        expect(
          () => repo.fetchDomainReport(tDomain),
          throwsA(isA<ServerException>()),
        );
      });

      test('should throw NetworkException when DioException occurs without a response', () async {
        when(mockDio.get(
          any,
          options: anyNamed('options'),
        )).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            type: DioExceptionType.connectionError,
          ),
        );

        expect(
          () => repo.fetchDomainReport(tDomain),
          throwsA(isA<NetworkException>()),
        );
        verify(mockDio.get(
          'https://www.virustotal.com/api/v3/domains/$tDomain',
          options: anyNamed('options'),
        ));
        verifyNoMoreInteractions(mockDio);
      });

      test('should throw UnknownException for any other generic exception', () async {
        when(mockDio.get(
          any,
          options: anyNamed('options'),
        )).thenThrow(Exception('Something unexpected happened'));

        expect(
          () => repo.fetchDomainReport(tDomain),
          throwsA(isA<UnknownException>()),
        );
        verify(mockDio.get(
          'https://www.virustotal.com/api/v3/domains/$tDomain',
          options: anyNamed('options'),
        ));
        verifyNoMoreInteractions(mockDio);
      });
    });

    group('fetchFileReport', () {
      test('should throw UnimplementedError', () async {
        expect(
          () => repo.fetchFileReport('some_hash'),
          throwsA(isA<UnimplementedError>()),
        );
      });
    });
  });
}
