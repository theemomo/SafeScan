import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:safe_scan/features/home/domain/entities/domain_response_model.dart';
import 'package:safe_scan/features/home/domain/errors/virustotal_exceptions.dart';
import 'package:safe_scan/features/home/domain/repos/api_repo.dart';
import 'package:safe_scan/features/home/presentation/cubits/scan_domain_cubit/scan_domain_cubit.dart';

import 'scan_domain_cubit_test.mocks.dart';

@GenerateMocks([ApiRepo, DomainResponseModel])
void main() {
  late ScanDomainCubit scanDomainCubit;
  late MockApiRepo mockApiRepo;
  late MockDomainResponseModel mockDomainResponseModel;

  setUp(() {
    mockApiRepo = MockApiRepo();
    mockDomainResponseModel = MockDomainResponseModel();
    scanDomainCubit = ScanDomainCubit(mockApiRepo);
  });

  tearDown(() {
    scanDomainCubit.close();
  });

  group('ScanDomainCubit', () {
    test('initial state is ScanDomainInitial', () {
      expect(scanDomainCubit.state, isA<ScanDomainInitial>());
    });

    group('scanDomain', () {
      final tDomain = 'example.com';

      blocTest<ScanDomainCubit, ScanDomainState>(
        'emits [ScanDomainLoading, ScanDomainLoaded] when fetchDomainReport is successful',
        build: () {
          when(mockApiRepo.fetchDomainReport(any))
              .thenAnswer((_) async => mockDomainResponseModel);
          return scanDomainCubit;
        },
        act: (cubit) => cubit.scanDomain(tDomain),
        expect: () => [
          isA<ScanDomainLoading>(),
          isA<ScanDomainLoaded>(),
        ],
        verify: (_) {
          verify(mockApiRepo.fetchDomainReport(tDomain));
          verifyNoMoreInteractions(mockApiRepo);
        },
      );

      blocTest<ScanDomainCubit, ScanDomainState>(
        'emits [ScanDomainLoading, ScanDomainError] when fetchDomainReport throws NotFoundException',
        build: () {
          when(mockApiRepo.fetchDomainReport(any))
              .thenThrow(NotFoundException('Domain not found'));
          return scanDomainCubit;
        },
        act: (cubit) => cubit.scanDomain(tDomain),
        expect: () => [
          isA<ScanDomainLoading>(),
          isA<ScanDomainError>(),
        ],
        verify: (_) {
          verify(mockApiRepo.fetchDomainReport(tDomain));
          verifyNoMoreInteractions(mockApiRepo);
        },
      );
      
      blocTest<ScanDomainCubit, ScanDomainState>(
        'emits [ScanDomainLoading, ScanDomainError] with generic error message for other exceptions',
        build: () {
          when(mockApiRepo.fetchDomainReport(any))
              .thenThrow(Exception('Generic error'));
          return scanDomainCubit;
        },
        act: (cubit) => cubit.scanDomain(tDomain),
        expect: () => [
          isA<ScanDomainLoading>(),
          isA<ScanDomainError>().having(
            (error) => error.message,
            'message',
            'An unexpected error occurred: Exception: Generic error',
          ),
        ],
        verify: (_) {
          verify(mockApiRepo.fetchDomainReport(tDomain));
          verifyNoMoreInteractions(mockApiRepo);
        },
      );
    });
  });
}
