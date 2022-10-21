import 'package:databaseflutter/Shared/cubit/app_cubit.dart';
import 'package:flutter/material.dart';

Widget Textfrom({
  required TextEditingController Controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required IconData prefix,
  required double Radiu,
  Color? background,
  required IconData suffix,
  bool password = false,
}) =>
    TextFormField(
      obscureText: password,
      controller: Controller,
      keyboardType: type,
      validator: validate(),
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.red,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(prefix),
        suffixIcon: Icon(suffix),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Radiu),
          ),
        ),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.white,
  required Function function,
  required String text,
  double radius = 0.0,
}) =>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
    );

Widget TaskItem(Map model,context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: 40,
            child: Text(
              ' ${model['time']}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' ${model['title']}',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  ' ${model['data']}',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(status: "done", id: model['id'],);
            },
            icon: Icon(Icons.check_box),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.archive),
          ),
        ],
      ),
    );
