import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:employee_apps/blocs/onboarding/onboarding_bloc.dart';
import 'package:employee_apps/blocs/onboarding/onboarding_status_cubit.dart';
import 'package:employee_apps/blocs/selected_user/selected_user_bloc.dart';
import 'package:employee_apps/blocs/user/user_bloc.dart';
import 'package:employee_apps/data/repositories/onboarding_repository.dart';
import 'package:employee_apps/data/repositories/selected_user_repository.dart';
import 'package:employee_apps/data/repositories/user_repository.dart';
import 'package:employee_apps/data/services/dio_service.dart';
import 'package:employee_apps/data/services/secure_storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDI() {
  // Register External
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<Connectivity>(Connectivity());
  getIt.registerSingleton<Dio>(Dio());

  // Register Service
  getIt.registerSingleton<DioService>(DioService(
    dio: getIt<Dio>(),
    connectivity: getIt<Connectivity>(),
  ));
  getIt.registerSingleton<SecureStorageService>(SecureStorageService(
    secureStorageService: getIt<FlutterSecureStorage>(),
  ));

  // Register Repository
  getIt.registerSingleton(OnboardingRepository(
    secureStorageService: getIt<SecureStorageService>(),
  ));
  getIt.registerSingleton(UserRepository(
    dioService: getIt<DioService>(),
  ));
  getIt.registerSingleton(SelectedUserRepository(
    secureStorageService: getIt<SecureStorageService>(),
  ));

  // Register State Management
  getIt.registerSingleton(OnboardingStatusCubit(
    repository: getIt<OnboardingRepository>(),
  ));
  getIt.registerSingleton(OnboardingBloc());
  getIt.registerSingleton(UserBloc(
    repository: getIt<UserRepository>(),
  ));
  getIt.registerSingleton(SelectedUserBloc(
    repository: getIt<SelectedUserRepository>(),
  ));
}
