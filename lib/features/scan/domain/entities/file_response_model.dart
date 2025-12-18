import 'dart:convert';
import 'package:equatable/equatable.dart';

FileResponseModel fileResponseModelFromJson(String str) =>
    FileResponseModel.fromJson(json.decode(str));

class FileResponseModel extends Equatable {
  final Data? data;
  final VTError? error;

  const FileResponseModel({this.data, this.error});

  factory FileResponseModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('error')) {
      return FileResponseModel(
        error: VTError.fromJson(json['error']),
      );
    } else {
      return FileResponseModel(
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
      );
    }
  }

  bool get isNotFound =>
      error != null && error!.code.toLowerCase() == 'NotFoundError';

  @override
  List<Object?> get props => [data, error];
}

class VTError extends Equatable {
  final String code;
  final String message;

  const VTError({required this.code, required this.message});

  factory VTError.fromJson(Map<String, dynamic> json) {
    return VTError(
      code: json['code']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [code, message];
}



class Data extends Equatable {
  final String id;
  final String type;
  final Links links;
  final Attributes attributes;

  const Data({
    required this.id,
    required this.type,
    required this.links,
    required this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      links: json['links'] != null ? Links.fromJson(json['links']) : Links(self: ''),
      attributes: json['attributes'] != null
          ? Attributes.fromJson(json['attributes'])
          : Attributes.empty(),
    );
  }

  @override
  List<Object?> get props => [id, type, links, attributes];
}

class Attributes extends Equatable {
  final String meaningfulName;
  final Map<String, LastAnalysisResult> lastAnalysisResults;
  final int timesSubmitted;
  final String sha1;
  final int lastModificationDate;
  final String magic;
  final List<String> typeTags;
  final int reputation;
  final String typeTag;
  final LastAnalysisStats? lastAnalysisStats;
  final int firstSubmissionDate;
  final String md5;
  final List<Trid> trid;
  final int lastSubmissionDate;
  final String tlsh;
  final String sha256;
  final int lastAnalysisDate;
  final int uniqueSources;
  final List<String> tags;
  final int size;
  final String typeExtension;
  final List<String> names;
  final String typeDescription;
  final String ssdeep;
  final Filecondis? filecondis;
  final TotalVotes? totalVotes;
  final String magika;

  const Attributes({
    required this.meaningfulName,
    required this.lastAnalysisResults,
    required this.timesSubmitted,
    required this.sha1,
    required this.lastModificationDate,
    required this.magic,
    required this.typeTags,
    required this.reputation,
    required this.typeTag,
    required this.lastAnalysisStats,
    required this.firstSubmissionDate,
    required this.md5,
    required this.trid,
    required this.lastSubmissionDate,
    required this.tlsh,
    required this.sha256,
    required this.lastAnalysisDate,
    required this.uniqueSources,
    required this.tags,
    required this.size,
    required this.typeExtension,
    required this.names,
    required this.typeDescription,
    required this.ssdeep,
    required this.filecondis,
    required this.totalVotes,
    required this.magika,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    final resultsJson = json['last_analysis_results'];
    final Map<String, LastAnalysisResult> results =
        resultsJson is Map<String, dynamic>
            ? resultsJson.map((k, v) => MapEntry(
                  k,
                  LastAnalysisResult.fromJson(v ?? {}),
                ))
            : {};

    return Attributes(
      meaningfulName: json['meaningful_name']?.toString() ?? '',
      lastAnalysisResults: results,
      timesSubmitted: json['times_submitted'] ?? 0,
      sha1: json['sha1']?.toString() ?? '',
      lastModificationDate: json['last_modification_date'] ?? 0,
      magic: json['magic']?.toString() ?? '',
      typeTags: (json['type_tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      reputation: json['reputation'] ?? 0,
      typeTag: json['type_tag']?.toString() ?? '',
      lastAnalysisStats: json['last_analysis_stats'] != null
          ? LastAnalysisStats.fromJson(json['last_analysis_stats'])
          : null,
      firstSubmissionDate: json['first_submission_date'] ?? 0,
      md5: json['md5']?.toString() ?? '',
      trid: (json['trid'] as List?)?.map((e) => Trid.fromJson(e ?? {})).toList() ?? [],
      lastSubmissionDate: json['last_submission_date'] ?? 0,
      tlsh: json['tlsh']?.toString() ?? '',
      sha256: json['sha256']?.toString() ?? '',
      lastAnalysisDate: json['last_analysis_date'] ?? 0,
      uniqueSources: json['unique_sources'] ?? 0,
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      size: json['size'] ?? 0,
      typeExtension: json['type_extension']?.toString() ?? '',
      names: (json['names'] as List?)?.map((e) => e.toString()).toList() ?? [],
      typeDescription: json['type_description']?.toString() ?? '',
      ssdeep: json['ssdeep']?.toString() ?? '',
      filecondis: json['filecondis'] != null ? Filecondis.fromJson(json['filecondis']) : null,
      totalVotes: json['total_votes'] != null ? TotalVotes.fromJson(json['total_votes']) : null,
      magika: json['magika']?.toString() ?? '',
    );
  }

  static Attributes empty() {
    return Attributes(
      meaningfulName: '',
      lastAnalysisResults: {},
      timesSubmitted: 0,
      sha1: '',
      lastModificationDate: 0,
      magic: '',
      typeTags: [],
      reputation: 0,
      typeTag: '',
      lastAnalysisStats: null,
      firstSubmissionDate: 0,
      md5: '',
      trid: [],
      lastSubmissionDate: 0,
      tlsh: '',
      sha256: '',
      lastAnalysisDate: 0,
      uniqueSources: 0,
      tags: [],
      size: 0,
      typeExtension: '',
      names: [],
      typeDescription: '',
      ssdeep: '',
      filecondis: null,
      totalVotes: null,
      magika: '',
    );
  }

  @override
  List<Object?> get props => [
        meaningfulName,
        lastAnalysisResults,
        timesSubmitted,
        sha1,
        lastModificationDate,
        magic,
        typeTags,
        reputation,
        typeTag,
        lastAnalysisStats,
        firstSubmissionDate,
        md5,
        trid,
        lastSubmissionDate,
        tlsh,
        sha256,
        lastAnalysisDate,
        uniqueSources,
        tags,
        size,
        typeExtension,
        names,
        typeDescription,
        ssdeep,
        filecondis,
        totalVotes,
        magika,
      ];
}

// Other dependent classes

class Filecondis extends Equatable {
  final String dhash;
  final String rawMd5;

  const Filecondis({required this.dhash, required this.rawMd5});

  factory Filecondis.fromJson(Map<String, dynamic> json) {
    return Filecondis(
      dhash: json['dhash']?.toString() ?? '',
      rawMd5: json['raw_md5']?.toString() ?? '',
    );
  }

  @override
  List<Object?> get props => [dhash, rawMd5];
}

class LastAnalysisResult extends Equatable {
  final Method? method;
  final String engineName;
  final String? engineVersion;
  final String engineUpdate;
  final Category? category;
  final Result? result;

  const LastAnalysisResult({
    required this.method,
    required this.engineName,
    required this.engineVersion,
    required this.engineUpdate,
    required this.category,
    required this.result,
  });

  factory LastAnalysisResult.fromJson(Map<String, dynamic> json) {
    return LastAnalysisResult(
      method: methodValues.map[json['method']],
      engineName: json['engine_name']?.toString() ?? '',
      engineVersion: json['engine_version']?.toString(),
      engineUpdate: json['engine_update']?.toString() ?? '',
      category: categoryValues.map[json['category']],
      result: resultValues.map[json['result']],
    );
  }

  @override
  List<Object?> get props =>
      [method, engineName, engineVersion, engineUpdate, category, result];
}

class LastAnalysisStats extends Equatable {
  final int malicious;
  final int suspicious;
  final int undetected;
  final int harmless;
  final int timeout;
  final int confirmedTimeout;
  final int failure;
  final int typeUnsupported;

  const LastAnalysisStats({
    required this.malicious,
    required this.suspicious,
    required this.undetected,
    required this.harmless,
    required this.timeout,
    required this.confirmedTimeout,
    required this.failure,
    required this.typeUnsupported,
  });

  factory LastAnalysisStats.fromJson(Map<String, dynamic> json) {
    return LastAnalysisStats(
      malicious: json['malicious'] ?? 0,
      suspicious: json['suspicious'] ?? 0,
      undetected: json['undetected'] ?? 0,
      harmless: json['harmless'] ?? 0,
      timeout: json['timeout'] ?? 0,
      confirmedTimeout: json['confirmed-timeout'] ?? 0,
      failure: json['failure'] ?? 0,
      typeUnsupported: json['type-unsupported'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        malicious,
        suspicious,
        undetected,
        harmless,
        timeout,
        confirmedTimeout,
        failure,
        typeUnsupported,
      ];
}

class TotalVotes extends Equatable {
  final int harmless;
  final int malicious;

  const TotalVotes({required this.harmless, required this.malicious});

  factory TotalVotes.fromJson(Map<String, dynamic> json) {
    return TotalVotes(
      harmless: json['harmless'] ?? 0,
      malicious: json['malicious'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [harmless, malicious];
}

class Trid extends Equatable {
  final String fileType;
  final double probability;

  const Trid({required this.fileType, required this.probability});

  factory Trid.fromJson(Map<String, dynamic> json) {
    return Trid(
      fileType: json['file_type']?.toString() ?? '',
      probability: (json['probability'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [fileType, probability];
}

class Links extends Equatable {
  final String self;

  const Links({required this.self});

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(self: json['self']?.toString() ?? '');
  }

  @override
  List<Object?> get props => [self];
}

// Enums

enum Category { typeUnsupported, undetected, harmless, malicious, suspicious }

final categoryValues = const EnumValues<Category>({
  'type-unsupported': Category.typeUnsupported,
  'undetected': Category.undetected,
  'harmless': Category.harmless,
  'malicious': Category.malicious,
  'suspicious': Category.suspicious,
});

enum Method { blacklist }

final methodValues = const EnumValues<Method>({
  'blacklist': Method.blacklist,
});

enum Result { clean, phishing, unrated, malicious, suspicious }

final resultValues = const EnumValues<Result>({
  'clean': Result.clean,
  'phishing': Result.phishing,
  'unrated': Result.unrated,
  'malicious': Result.malicious,
  'suspicious': Result.suspicious,
});

class EnumValues<T> {
  final Map<String, T> map;
  const EnumValues(this.map);
}
