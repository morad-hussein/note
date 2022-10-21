import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:databaseflutter/Shared/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  @override
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var titelcontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  HomeLayout({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..CreateDatabase(),
      child: BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is AppInsertDatabase) {
          Navigator.pop(context);
        }
      }, builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(
              AppCubit.get(context).Titles[AppCubit.get(context).currentIndex],
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! GetDatabaseLoading,
            builder: (context) => AppCubit.get(context)
                .Screens[AppCubit.get(context).currentIndex],
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (AppCubit.get(context).showBottom) {
                if (formkey.currentState!.validate()) {
                  AppCubit.get(context).InsertToDatabase(
                      title: titelcontroller.text,
                      data: datecontroller.text,
                      time: timecontroller.text);
                }
              } else {
                scaffoldKey.currentState
                    ?.showBottomSheet(
                      (context) => Container(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titelcontroller,
                                  keyboardType: TextInputType.text,
                                  cursorColor: Colors.cyanAccent,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'title must be empty';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: " Task Title",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    prefixIcon: Icon(Icons.title),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: datecontroller,
                                  keyboardType: TextInputType.datetime,
                                  cursorColor: Colors.cyanAccent,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2022-10-25'),
                                    ).then((value) {
                                      datecontroller.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'date must be empty';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Task Date",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: timecontroller,
                                  keyboardType: TextInputType.datetime,
                                  cursorColor: Colors.cyanAccent,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timecontroller.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'time must be empty';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    labelText: "Task Time",
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    prefixIcon: Icon(Icons.wallet_giftcard),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      elevation: 23.0,
                    )
                    .closed
                    .then((value) {
                  AppCubit.get(context)
                      .ChangeBottomSheet(isShow: false, iconi: Icons.add);
                });
                AppCubit.get(context)
                    .ChangeBottomSheet(isShow: true, iconi: Icons.add);
              }
            },
            child: Icon(
              AppCubit.get(context).icon,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: AppCubit.get(context).currentIndex,
            onTap: (index) {
              AppCubit.get(context).changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                ),
                label: 'Mune',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle_outline,
                ),
                label: 'Check',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive_outlined,
                ),
                label: 'Archived',
              ),
            ],
          ),
        );
      }),
    );
  }
}
