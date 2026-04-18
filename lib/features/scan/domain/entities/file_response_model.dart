import 'dart:convert';
import 'package:equatable/equatable.dart';

FileResponseModel fileResponseModelFromJson(String str) =>
    FileResponseModel.fromJson(json.decode(str));

class FileResponseModel extends Equatable {
  final Data? data;
  final VTError? error;

  const FileResponseModel({this.data, this.error});

  factory FileResponseModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('error') && json['error'] != null) {
      return FileResponseModel(error: VTError.fromJson(json['error']));
    }
    return FileResponseModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  bool get isNotFound =>
      error != null && error!.code.toLowerCase() == 'notfounderror';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (data != null) json['data'] = data!.toJson();
    if (error != null) {
      json['error'] = {'code': error!.code, 'message': error!.message};
    }
    return json;
  }

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
  final Attributes attributes;

  const Data({required this.id, required this.type, required this.attributes});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      attributes: Attributes.fromJson(json['attributes'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'attributes': attributes.toJson(),
      };

  @override
  List<Object?> get props => [id, type, attributes];
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
  final TotalVotes? totalVotes;
  final Map<String, String>? categories;

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
    required this.totalVotes,
    this.categories,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    final resultsJson = json['last_analysis_results'];
    final Map<String, LastAnalysisResult> results =
        (resultsJson is Map<String, dynamic>)
            ? resultsJson.map((k, v) =>
                MapEntry(k, LastAnalysisResult.fromJson(v ?? {})))
            : {};

    final tridJson = json['trid'];
    final List<Trid> trid = (tridJson is List)
        ? tridJson.map((e) => Trid.fromJson(e ?? {})).toList()
        : [];

    final tagsJson = json['tags'];
    final List<String> tags = (tagsJson is List)
        ? tagsJson.map((e) => e.toString()).toList()
        : [];

    final namesJson = json['names'];
    final List<String> names = (namesJson is List)
        ? namesJson.map((e) => e.toString()).toList()
        : [];

    final typeTagsJson = json['type_tags'];
    final List<String> typeTags = (typeTagsJson is List)
        ? typeTagsJson.map((e) => e.toString()).toList()
        : [];

    final catJson = json['categories'];
    final Map<String, String>? categoriesMap = (catJson is Map<String, dynamic>)
        ? catJson.map((k, v) => MapEntry(k, v.toString()))
        : null;

    return Attributes(
      meaningfulName: json['meaningful_name']?.toString() ?? '',
      lastAnalysisResults: results,
      timesSubmitted: json['times_submitted'] ?? 0,
      sha1: json['sha1']?.toString() ?? '',
      lastModificationDate: json['last_modification_date'] ?? 0,
      magic: json['magic']?.toString() ?? '',
      typeTags: typeTags,
      reputation: json['reputation'] ?? 0,
      typeTag: json['type_tag']?.toString() ?? '',
      lastAnalysisStats: json['last_analysis_stats'] != null
          ? LastAnalysisStats.fromJson(json['last_analysis_stats'])
          : null,
      firstSubmissionDate: json['first_submission_date'] ?? 0,
      md5: json['md5']?.toString() ?? '',
      trid: trid,
      lastSubmissionDate: json['last_submission_date'] ?? 0,
      tlsh: json['tlsh']?.toString() ?? '',
      sha256: json['sha256']?.toString() ?? '',
      lastAnalysisDate: json['last_analysis_date'] ?? 0,
      uniqueSources: json['unique_sources'] ?? 0,
      tags: tags,
      size: json['size'] ?? 0,
      typeExtension: json['type_extension']?.toString() ?? '',
      names: names,
      typeDescription: json['type_description']?.toString() ?? '',
      ssdeep: json['ssdeep']?.toString() ?? '',
      totalVotes: json['total_votes'] != null
          ? TotalVotes.fromJson(json['total_votes'])
          : null,
      categories: categoriesMap,
    );
  }

  Map<String, dynamic> toJson() => {
        'meaningful_name': meaningfulName,
        'last_analysis_results':
            lastAnalysisResults.map((k, v) => MapEntry(k, v.toJson())),
        'times_submitted': timesSubmitted,
        'sha1': sha1,
        'last_modification_date': lastModificationDate,
        'magic': magic,
        'type_tags': typeTags,
        'reputation': reputation,
        'type_tag': typeTag,
        'last_analysis_stats': lastAnalysisStats?.toJson(),
        'first_submission_date': firstSubmissionDate,
        'md5': md5,
        'trid': trid.map((e) => e.toJson()).toList(),
        'last_submission_date': lastSubmissionDate,
        'tlsh': tlsh,
        'sha256': sha256,
        'last_analysis_date': lastAnalysisDate,
        'unique_sources': uniqueSources,
        'tags': tags,
        'size': size,
        'type_extension': typeExtension,
        'names': names,
        'type_description': typeDescription,
        'ssdeep': ssdeep,
        'total_votes': totalVotes?.toJson(),
        if (categories != null) 'categories': categories,
      };

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
        totalVotes,
        categories,
      ];
}

class LastAnalysisResult extends Equatable {
  final Method method;
  final String engineName;
  final String? engineVersion;
  final String engineUpdate;
  final Category category;
  final Result result;

  const LastAnalysisResult({
    required this.method,
    required this.engineName,
    this.engineVersion,
    required this.engineUpdate,
    required this.category,
    required this.result,
  });

  factory LastAnalysisResult.fromJson(Map<String, dynamic> json) =>
      LastAnalysisResult(
        method: methodValues.map[json['method']] ?? Method.BLACKLIST,
        engineName: json['engine_name']?.toString() ?? '',
        engineVersion: json['engine_version']?.toString(),
        engineUpdate: json['engine_update']?.toString() ?? '',
        category: categoryValues.map[json['category']] ?? Category.UNDETECTED,
        result: resultValues.map[json['result']] ?? Result.UNRATED,
      );

  Map<String, dynamic> toJson() => {
        'method': methodValues.reverse[method],
        'engine_name': engineName,
        'engine_version': engineVersion,
        'engine_update': engineUpdate,
        'category': categoryValues.reverse[category],
        'result': resultValues.reverse[result],
      };

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

  factory LastAnalysisStats.fromJson(Map<String, dynamic> json) =>
      LastAnalysisStats(
        malicious: json['malicious'] ?? 0,
        suspicious: json['suspicious'] ?? 0,
        undetected: json['undetected'] ?? 0,
        harmless: json['harmless'] ?? 0,
        timeout: json['timeout'] ?? 0,
        confirmedTimeout: json['confirmed-timeout'] ?? 0,
        failure: json['failure'] ?? 0,
        typeUnsupported: json['type-unsupported'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'malicious': malicious,
        'suspicious': suspicious,
        'undetected': undetected,
        'harmless': harmless,
        'timeout': timeout,
        'confirmed-timeout': confirmedTimeout,
        'failure': failure,
        'type-unsupported': typeUnsupported,
      };

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

  factory TotalVotes.fromJson(Map<String, dynamic> json) => TotalVotes(
        harmless: json['harmless'] ?? 0,
        malicious: json['malicious'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'harmless': harmless,
        'malicious': malicious,
      };

  @override
  List<Object?> get props => [harmless, malicious];
}

class Trid extends Equatable {
  final String fileType;
  final double probability;

  const Trid({required this.fileType, required this.probability});

  factory Trid.fromJson(Map<String, dynamic> json) => Trid(
        fileType: json['file_type']?.toString() ?? '',
        probability: (json['probability'] as num?)?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        'file_type': fileType,
        'probability': probability,
      };

  @override
  List<Object?> get props => [fileType, probability];
}

enum Category { HARMLESS, MALICIOUS, UNDETECTED, SUSPICIOUS, TYPE_UNSUPPORTED }

final categoryValues = EnumValues({
  'harmless': Category.HARMLESS,
  'malicious': Category.MALICIOUS,
  'undetected': Category.UNDETECTED,
  'suspicious': Category.SUSPICIOUS,
  'type-unsupported': Category.TYPE_UNSUPPORTED,
});

enum Method { BLACKLIST }

final methodValues = EnumValues({'blacklist': Method.BLACKLIST});

enum Result { CLEAN, PHISHING, UNRATED, MALICIOUS, SUSPICIOUS }

final resultValues = EnumValues({
  'clean': Result.CLEAN,
  'phishing': Result.PHISHING,
  'unrated': Result.UNRATED,
  'malicious': Result.MALICIOUS,
  'suspicious': Result.SUSPICIOUS,
});

class EnumValues<T> {
  final Map<String, T> map;
  Map<T, String>? _reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    _reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return _reverseMap!;
  }
}
