import 'package:path/path.dart';
import 'package:safe_scan/features/reports/domain/repos/local_database_repo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:safe_scan/features/reports/domain/entities/saved_report.dart';

class SqfliteReportsDB implements LocalDatabaseRepo {
  static const _dbName = 'safe_scan_reports.db';
  static const _dbVersion = 1;
  static const _table = 'saved_reports';

  Database? _db;

  Future<Database> get database async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            scan_type TEXT NOT NULL,
            target TEXT NOT NULL,
            threat_label TEXT NOT NULL,
            malicious_count INTEGER NOT NULL,
            total_vendors INTEGER NOT NULL,
            ai_summary TEXT NOT NULL,
            raw_json TEXT NOT NULL,
            saved_at INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  /// Fetch all reports ordered by newest first.
  @override
  Future<List<SavedReport>> getAllReports() async {
    final db = await database;
    final rows = await db.query(_table, orderBy: 'saved_at DESC');
    return rows.map(SavedReport.fromMap).toList();
  }

  /// Insert a report. Returns the new row id.
  @override
  Future<int> insertReport(SavedReport report) async {
    final db = await database;
    return db.insert(
      _table,
      report.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Delete a report by id.
  @override
  Future<void> deleteReport(int id) async {
    final db = await database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  /// Check if a report already exists by target + type.
  @override
  Future<bool> reportExists(String target, String scanType) async {
    final db = await database;
    final result = await db.query(
      _table,
      columns: ['id'],
      where: 'target = ? AND scan_type = ?',
      whereArgs: [target, scanType],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  /// Update the ai_summary for an existing saved report.
  @override
  Future<void> updateAiSummary(int id, String aiSummary) async {
    final db = await database;
    await db.update(
      _table,
      {'ai_summary': aiSummary},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final db = _db;
    if (db != null) await db.close();
  }
}
