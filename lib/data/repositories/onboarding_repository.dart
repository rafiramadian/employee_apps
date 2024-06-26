import 'package:employee_apps/data/services/secure_storage_service.dart';
import 'package:employee_apps/utils/key_constant.dart';

class OnboardingRepository {
  final SecureStorageService _secureStorageService;
  OnboardingRepository({
    required SecureStorageService secureStorageService,
  }) : _secureStorageService = secureStorageService;

  Future<bool> getOnboardingStatus() async {
    try {
      final value =
          await _secureStorageService.read(key: keyOnboarding) ?? 'true';
      if (value == 'true' || value.isEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future setOnboardingStatus(bool value) async {
    try {
      await _secureStorageService.write(
        key: keyOnboarding,
        data: value.toString(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
