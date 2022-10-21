import 'package:flutter/material.dart';

class DoneTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Done Tasks'
       , style: TextStyle(
          fontSize: 40,
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
