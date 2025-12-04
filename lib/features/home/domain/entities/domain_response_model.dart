import 'dart:convert';

DomainResponseModel domainResponseModelFromJson(String str) =>
    DomainResponseModel.fromJson(json.decode(str));

String domainResponseModelToJson(DomainResponseModel data) =>
    json.encode(data.toJson());

class DomainResponseModel {
  final Data data;

  DomainResponseModel({required this.data});

  factory DomainResponseModel.fromJson(Map<String, dynamic> json) =>
      DomainResponseModel(data: Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"data": data.toJson()};
}

class Data {
  final String id;
  final String type;
  final Attributes attributes;

  Data({required this.id, required this.type, required this.attributes});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    type: json["type"],
    attributes: Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "attributes": attributes.toJson(),
  };
}

class Attributes {
  final Map<String, LastAnalysisResult> lastAnalysisResults;
  final LastAnalysisStats lastAnalysisStats;
  final List<LastDnsRecord> lastDnsRecords;

  Attributes({
    required this.lastAnalysisResults,
    required this.lastAnalysisStats,
    required this.lastDnsRecords,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    lastAnalysisResults: Map.from(json["last_analysis_results"]).map(
      (k, v) => MapEntry<String, LastAnalysisResult>(
        k,
        LastAnalysisResult.fromJson(v),
      ),
    ),

    lastAnalysisStats: LastAnalysisStats.fromJson(json["last_analysis_stats"]),
    lastDnsRecords: List<LastDnsRecord>.from(
      json["last_dns_records"].map((x) => LastDnsRecord.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "last_analysis_results": Map.from(
      lastAnalysisResults,
    ).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "last_analysis_stats": lastAnalysisStats.toJson(),
    "last_dns_records": List<dynamic>.from(
      lastDnsRecords.map((x) => x.toJson()),
    ),
  };
}

class LastAnalysisResult {
  final Method method;
  final String engineName;
  final Category category;
  final Result result;

  LastAnalysisResult({
    required this.method,
    required this.engineName,
    required this.category,
    required this.result,
  });

  factory LastAnalysisResult.fromJson(Map<String, dynamic> json) =>
      LastAnalysisResult(
        method: methodValues.map[json["method"]]!,
        engineName: json["engine_name"],
        category: categoryValues.map[json["category"]]!,
        result: resultValues.map[json["result"]]!,
      );

  Map<String, dynamic> toJson() => {
    "method": methodValues.reverse[method],
    "engine_name": engineName,
    "category": categoryValues.reverse[category],
    "result": resultValues.reverse[result],
  };
}

enum Category { HARMLESS, MALICIOUS, UNDETECTED, SUSPICIOUS }

final categoryValues = EnumValues({
  "harmless": Category.HARMLESS,
  "malicious": Category.MALICIOUS,
  "undetected": Category.UNDETECTED,
  "suspicious": Category.SUSPICIOUS,
});

enum Method { BLACKLIST }

final methodValues = EnumValues({"blacklist": Method.BLACKLIST});

enum Result { CLEAN, PHISHING, UNRATED, MALICIOUS, SUSPICIOUS }

final resultValues = EnumValues({
  "clean": Result.CLEAN,
  "phishing": Result.PHISHING,
  "unrated": Result.UNRATED,
  "malicious": Result.MALICIOUS,
  "suspicious": Result.SUSPICIOUS,
});

class LastAnalysisStats {
  final int malicious;
  final int suspicious;
  final int undetected;
  final int harmless;
  final int timeout;

  LastAnalysisStats({
    required this.malicious,
    required this.suspicious,
    required this.undetected,
    required this.harmless,
    required this.timeout,
  });

  factory LastAnalysisStats.fromJson(Map<String, dynamic> json) =>
      LastAnalysisStats(
        malicious: json["malicious"],
        suspicious: json["suspicious"],
        undetected: json["undetected"],
        harmless: json["harmless"],
        timeout: json["timeout"],
      );

  Map<String, dynamic> toJson() => {
    "malicious": malicious,
    "suspicious": suspicious,
    "undetected": undetected,
    "harmless": harmless,
    "timeout": timeout,
  };
}

class LastDnsRecord {
  final String type;
  final int ttl;
  final String value;
  final int? priority;

  LastDnsRecord({
    required this.type,
    required this.ttl,
    required this.value,
    this.priority,
  });

  factory LastDnsRecord.fromJson(Map<String, dynamic> json) => LastDnsRecord(
    type: json["type"],
    ttl: json["ttl"],
    value: json["value"],
    priority: json["priority"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "ttl": ttl,
    "value": value,
    "priority": priority,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
