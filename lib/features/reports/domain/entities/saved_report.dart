import 'dart:convert';

class SavedReport {
  final int? id;
  final String scanType; // 'domain' or 'file'
  final String target; // domain name or file meaningful-name
  final String threatLabel; // 'Safe', 'Suspicious', 'Dangerous'
  final int maliciousCount;
  final int totalVendors;
  final String aiSummary; // Full Gemini markdown text (empty if not loaded)
  final String rawJson; // Full toJson() of the VT response model
  final int savedAt; // millisecondsSinceEpoch

  const SavedReport({
    this.id,
    required this.scanType,
    required this.target,
    required this.threatLabel,
    required this.maliciousCount,
    required this.totalVendors,
    required this.aiSummary,
    required this.rawJson,
    required this.savedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'scan_type': scanType,
      'target': target,
      'threat_label': threatLabel,
      'malicious_count': maliciousCount,
      'total_vendors': totalVendors,
      'ai_summary': aiSummary,
      'raw_json': rawJson,
      'saved_at': savedAt,
    };
  }

  factory SavedReport.fromMap(Map<String, dynamic> map) {
    return SavedReport(
      id: map['id'] as int?,
      scanType: map['scan_type'] as String,
      target: map['target'] as String,
      threatLabel: map['threat_label'] as String,
      maliciousCount: map['malicious_count'] as int,
      totalVendors: map['total_vendors'] as int,
      aiSummary: map['ai_summary'] as String,
      rawJson: map['raw_json'] as String,
      savedAt: map['saved_at'] as int,
    );
  }

  DateTime get savedAtDateTime =>
      DateTime.fromMillisecondsSinceEpoch(savedAt);

  String get formattedDate {
    final dt = savedAtDateTime;
    return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
  }

  String get formattedTime {
    final dt = savedAtDateTime;
    final hour = dt.hour;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'Pm' : 'Am';
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$hour12:$minute $period';
  }

  /// Decode rawJson back to a usable Map.
  Map<String, dynamic> get decodedJson =>
      jsonDecode(rawJson) as Map<String, dynamic>;
}
