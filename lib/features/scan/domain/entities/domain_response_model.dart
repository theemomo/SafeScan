import 'dart:convert';
import 'package:equatable/equatable.dart';

DomainResponseModel domainResponseModelFromJson(String str) =>
    DomainResponseModel.fromJson(json.decode(str));

class DomainResponseModel extends Equatable {
  final Data? data;
  final VTError? error;

  const DomainResponseModel({this.data, this.error});

  factory DomainResponseModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('error') && json['error'] != null) {
      return DomainResponseModel(error: VTError.fromJson(json['error']));
    }
    return DomainResponseModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  bool get isNotFound =>
      error != null && error!.code.toLowerCase() == 'notFoundError';

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

// ------------------- Models -------------------

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

  @override
  List<Object?> get props => [id, type, attributes];
}

class Attributes extends Equatable {
  final Map<String, LastAnalysisResult> lastAnalysisResults;
  final LastAnalysisStats? lastAnalysisStats;
  final List<LastDnsRecord> lastDnsRecords;

  const Attributes({
    required this.lastAnalysisResults,
    required this.lastAnalysisStats,
    required this.lastDnsRecords,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    final resultsJson = json['last_analysis_results'];
    final Map<String, LastAnalysisResult> results =
        (resultsJson is Map<String, dynamic>)
            ? resultsJson.map((k, v) =>
                MapEntry(k, LastAnalysisResult.fromJson(v ?? {})))
            : {};

    final dnsJson = json['last_dns_records'];
    final List<LastDnsRecord> dnsRecords = (dnsJson is List)
        ? dnsJson.map((e) => LastDnsRecord.fromJson(e ?? {})).toList()
        : [];

    return Attributes(
      lastAnalysisResults: results,
      lastAnalysisStats: json['last_analysis_stats'] != null
          ? LastAnalysisStats.fromJson(json['last_analysis_stats'])
          : null,
      lastDnsRecords: dnsRecords,
    );
  }

  @override
  List<Object?> get props =>
      [lastAnalysisResults, lastAnalysisStats, lastDnsRecords];
}

class LastAnalysisResult extends Equatable {
  final Method method;
  final String engineName;
  final Category category;
  final Result result;

  const LastAnalysisResult({
    required this.method,
    required this.engineName,
    required this.category,
    required this.result,
  });

  factory LastAnalysisResult.fromJson(Map<String, dynamic> json) =>
      LastAnalysisResult(
        method: methodValues.map[json['method']] ?? Method.BLACKLIST,
        engineName: json['engine_name']?.toString() ?? '',
        category: categoryValues.map[json['category']] ?? Category.UNDETECTED,
        result: resultValues.map[json['result']] ?? Result.UNRATED,
      );

  Map<String, dynamic> toJson() => {
        'method': methodValues.reverse[method],
        'engine_name': engineName,
        'category': categoryValues.reverse[category],
        'result': resultValues.reverse[result],
      };

  @override
  List<Object?> get props => [method, engineName, category, result];
}

enum Category { HARMLESS, MALICIOUS, UNDETECTED, SUSPICIOUS }
final categoryValues = EnumValues({
  'harmless': Category.HARMLESS,
  'malicious': Category.MALICIOUS,
  'undetected': Category.UNDETECTED,
  'suspicious': Category.SUSPICIOUS,
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

class LastAnalysisStats extends Equatable {
  final int malicious;
  final int suspicious;
  final int undetected;
  final int harmless;
  final int timeout;

  const LastAnalysisStats({
    required this.malicious,
    required this.suspicious,
    required this.undetected,
    required this.harmless,
    required this.timeout,
  });

  factory LastAnalysisStats.fromJson(Map<String, dynamic> json) =>
      LastAnalysisStats(
        malicious: json['malicious'] ?? 0,
        suspicious: json['suspicious'] ?? 0,
        undetected: json['undetected'] ?? 0,
        harmless: json['harmless'] ?? 0,
        timeout: json['timeout'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'malicious': malicious,
        'suspicious': suspicious,
        'undetected': undetected,
        'harmless': harmless,
        'timeout': timeout,
      };

  @override
  List<Object?> get props => [malicious, suspicious, undetected, harmless, timeout];
}

class LastDnsRecord extends Equatable {
  final String type;
  final int ttl;
  final String value;
  final int? priority;

  const LastDnsRecord({
    required this.type,
    required this.ttl,
    required this.value,
    this.priority,
  });

  factory LastDnsRecord.fromJson(Map<String, dynamic> json) => LastDnsRecord(
        type: json['type']?.toString() ?? '',
        ttl: json['ttl'] ?? 0,
        value: json['value']?.toString() ?? '',
        priority: json['priority'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'ttl': ttl,
        'value': value,
        'priority': priority,
      };

  @override
  List<Object?> get props => [type, ttl, value, priority];
}

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
