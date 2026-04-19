import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_scan/features/settings/data/locale_repository.dart';

class LocaleCubit extends Cubit<Locale> {
  final LocaleRepository _repo;

  LocaleCubit(this._repo) : super(const Locale('en'));

  /// Load persisted locale on app start.
  Future<void> loadLocale() async {
    final code = await _repo.getLocale();
    if (code != null) emit(Locale(code));
  }

  /// Switch to a new locale and persist it.
  Future<void> setLocale(Locale locale) async {
    await _repo.saveLocale(locale.languageCode);
    emit(locale);
  }
}
