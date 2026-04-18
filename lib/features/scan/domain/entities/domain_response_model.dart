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

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'attributes': attributes.toJson(),
      };

  @override
  List<Object?> get props => [id, type, attributes];
}

class Attributes extends Equatable {
  final Map<String, String>? categories;
  final int? creationDate;
  final Favicon? favicon;
  final String? jarm;
  final int? lastAnalysisDate;
  final Map<String, LastAnalysisResult> lastAnalysisResults;
  final LastAnalysisStats? lastAnalysisStats;
  final List<LastDnsRecord> lastDnsRecords;
  final int? lastDnsRecordsDate;
  final Map<String, dynamic>? lastHttpsCertificate;
  final int? lastHttpsCertificateDate;
  final int? lastModificationDate;
  final int? lastUpdateDate;
  final Map<String, PopularityRank>? popularityRanks;
  final String? registrar;
  final int? reputation;
  final List<String>? tags;
  final TotalVotes? totalVotes;
  final String? whois;
  final int? whoisDate;

  const Attributes({
    this.categories,
    this.creationDate,
    this.favicon,
    this.jarm,
    this.lastAnalysisDate,
    required this.lastAnalysisResults,
    required this.lastAnalysisStats,
    required this.lastDnsRecords,
    this.lastDnsRecordsDate,
    this.lastHttpsCertificate,
    this.lastHttpsCertificateDate,
    this.lastModificationDate,
    this.lastUpdateDate,
    this.popularityRanks,
    this.registrar,
    this.reputation,
    this.tags,
    this.totalVotes,
    this.whois,
    this.whoisDate,
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
        
    final catJson = json['categories'];
    final Map<String, String>? categoriesMap = (catJson is Map<String, dynamic>) 
        ? catJson.map((k, v) => MapEntry(k, v.toString())) 
        : null;
        
    final popJson = json['popularity_ranks'];
    final Map<String, PopularityRank>? popMap = (popJson is Map<String, dynamic>)
        ? popJson.map((k, v) => MapEntry(k, PopularityRank.fromJson(v ?? {})))
        : null;

    final tagsJson = json['tags'];
    final List<String>? tagsList = (tagsJson is List)
        ? tagsJson.map((e) => e.toString()).toList()
        : null;

    return Attributes(
      categories: categoriesMap,
      creationDate: json['creation_date'],
      favicon: json['favicon'] != null ? Favicon.fromJson(json['favicon']) : null,
      jarm: json['jarm']?.toString(),
      lastAnalysisDate: json['last_analysis_date'],
      lastAnalysisResults: results,
      lastAnalysisStats: json['last_analysis_stats'] != null
          ? LastAnalysisStats.fromJson(json['last_analysis_stats'])
          : null,
      lastDnsRecords: dnsRecords,
      lastDnsRecordsDate: json['last_dns_records_date'],
      lastHttpsCertificate: json['last_https_certificate'] as Map<String, dynamic>?,
      lastHttpsCertificateDate: json['last_https_certificate_date'],
      lastModificationDate: json['last_modification_date'],
      lastUpdateDate: json['last_update_date'],
      popularityRanks: popMap,
      registrar: json['registrar']?.toString(),
      reputation: json['reputation'],
      tags: tagsList,
      totalVotes: json['total_votes'] != null ? TotalVotes.fromJson(json['total_votes']) : null,
      whois: json['whois']?.toString(),
      whoisDate: json['whois_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (categories != null) 'categories': categories,
      if (creationDate != null) 'creation_date': creationDate,
      if (favicon != null) 'favicon': favicon!.toJson(),
      if (jarm != null) 'jarm': jarm,
      if (lastAnalysisDate != null) 'last_analysis_date': lastAnalysisDate,
      'last_analysis_results': lastAnalysisResults.map((k, v) => MapEntry(k, v.toJson())),
      if (lastAnalysisStats != null) 'last_analysis_stats': lastAnalysisStats!.toJson(),
      'last_dns_records': lastDnsRecords.map((e) => e.toJson()).toList(),
      if (lastDnsRecordsDate != null) 'last_dns_records_date': lastDnsRecordsDate,
      if (lastHttpsCertificate != null) 'last_https_certificate': lastHttpsCertificate,
      if (lastHttpsCertificateDate != null) 'last_https_certificate_date': lastHttpsCertificateDate,
      if (lastModificationDate != null) 'last_modification_date': lastModificationDate,
      if (lastUpdateDate != null) 'last_update_date': lastUpdateDate,
      if (popularityRanks != null) 'popularity_ranks': popularityRanks!.map((k, v) => MapEntry(k, v.toJson())),
      if (registrar != null) 'registrar': registrar,
      if (reputation != null) 'reputation': reputation,
      if (tags != null) 'tags': tags,
      if (totalVotes != null) 'total_votes': totalVotes!.toJson(),
      if (whois != null) 'whois': whois,
      if (whoisDate != null) 'whois_date': whoisDate,
    };
  }

  @override
  List<Object?> get props => [
        categories,
        creationDate,
        favicon,
        jarm,
        lastAnalysisDate,
        lastAnalysisResults,
        lastAnalysisStats,
        lastDnsRecords,
        lastDnsRecordsDate,
        lastHttpsCertificate,
        lastHttpsCertificateDate,
        lastModificationDate,
        lastUpdateDate,
        popularityRanks,
        registrar,
        reputation,
        tags,
        totalVotes,
        whois,
        whoisDate,
      ];
}

class Favicon extends Equatable {
  final String dhash;
  final String rawMd5;

  const Favicon({required this.dhash, required this.rawMd5});

  factory Favicon.fromJson(Map<String, dynamic> json) => Favicon(
        dhash: json['dhash']?.toString() ?? '',
        rawMd5: json['raw_md5']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'dhash': dhash,
        'raw_md5': rawMd5,
      };

  @override
  List<Object?> get props => [dhash, rawMd5];
}

class PopularityRank extends Equatable {
  final int rank;
  final int timestamp;

  const PopularityRank({required this.rank, required this.timestamp});

  factory PopularityRank.fromJson(Map<String, dynamic> json) => PopularityRank(
        rank: json['rank'] ?? 0,
        timestamp: json['timestamp'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'rank': rank,
        'timestamp': timestamp,
      };

  @override
  List<Object?> get props => [rank, timestamp];
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
  Map<T, String>? _reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    _reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return _reverseMap!;
  }
}
