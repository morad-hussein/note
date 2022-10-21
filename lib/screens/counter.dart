import 'package:databaseflutter/screens/cubit_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                'Counter Screen',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              centerTitle: true,
            ),
            body: Container(
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          CounterCubit.get(context).decrement();
                        },
                        child: Icon(
                          Icons.remove,
                          size: 35,
                          color: Colors.red,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          CounterCubit.get(context).increment();
                        },
                        child: Icon(
                          Icons.add,
                          size: 35,
                          color: Colors.red,)),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
