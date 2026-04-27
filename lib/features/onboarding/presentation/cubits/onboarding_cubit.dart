import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safe_scan/core/utils/app_constants.dart';

class OnboardingCubit extends Cubit<int> {
  final SharedPreferences _sharedPreferences;

  OnboardingCubit(this._sharedPreferences) : super(0);

  void setPage(int page) {
    emit(page);
  }

  Future<void> completeOnboarding() async {
    await _sharedPreferences.setBool(AppConstants.hasSeenOnboarding, true);
  }
}
