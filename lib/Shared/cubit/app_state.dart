part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class AppBottom extends AppState {}

class AppCreateDatabase extends AppState {}

class AppInsertDatabase extends AppState {}

class AppGetDatabase extends AppState {}

class AppChangeBotton extends AppState {}

class GetDatabaseLoading extends AppState {}

class AppStateUpdate extends AppState {}
