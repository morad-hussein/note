import 'package:databaseflutter/Shared/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import '../../Shared/component/share_component.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).tasks;

          return ListView.separated(
            itemBuilder: (cntx, index) => TaskItem(tasks[index],context),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.1,
                color: Colors.grey[300],
              ),
            ),
            itemCount: tasks.length,
          );
        });
  }
}
