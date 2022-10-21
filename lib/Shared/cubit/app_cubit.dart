import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/archived_tasks/archivied_tasks_screen.dart';
import '../../modules/done_tasks/done_tasks_screen.dart';
import '../../modules/new_tasks/new_tasks_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List tasks = [];
  List<Widget> Screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> Titles = [
    'NewTasksScreen',
    'DoneTasksScreen',
    'ArchivedTasksScreen',
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppBottom());
  }

  Database? db;

  void CreateDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (db, version) {
      print('create database ');
      db
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT, data TEXT , time TEXT , status TEXT )')
          .then((value) {
        print('create database table');
      }).catchError((error) {
        print('error when create database table ${error.toString()}');
      });
    }, onOpen: (db) {
      GetFromDatabase(db).then((value) {
        tasks = value;
        print(tasks);
        emit(AppCreateDatabase());
      });
      print('open database');
    }).then((value) {
      db = value;
      emit(AppCreateDatabase());
    });
  }

  InsertToDatabase({
    required String title,
    required String data,
    required String time,
  }) async {
    await db!.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,data,time,status) VALUES ("$title","$data","$time","new")')
          .then((value) {
        print(' $value insert successfully');
        emit(AppInsertDatabase());
        GetFromDatabase(db).then((value) {
          tasks = value;
          print(tasks);
          emit(AppCreateDatabase());
        });
      }).catchError((error) {
        print('error when insert database table ${error.toString()}');
      });
      return await null;
    });
  }

  Future<List<Map>> GetFromDatabase(db) async {
    emit(GetDatabaseLoading());
    return await db!.rawQuery('SELECT * FROM tasks');
  }

 void updateData({
  required String status,
    required int id,
}) async {
   db!.rawUpdate(
      'UPDATE tasks SET status = ?, value = ? WHERE id = ?',
      ['$status', id, ],
  ).then((value) {
    emit(AppStateUpdate());

   });

  }

  bool showBottom = false;
  IconData icon = Icons.add;

  void ChangeBottomSheet({
    required bool isShow,
    required IconData iconi,
  }) {
    showBottom = isShow;
    icon = iconi;
    emit(AppChangeBotton());
  }
}
