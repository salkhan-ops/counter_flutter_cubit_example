import 'package:counter_flutter_cubit_example/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      lazy: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Counter App (Flutter Bloc)',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CounterApp(title: 'Counter App (Flutter Bloc)'),
      ),
    );
  }
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key, required this.title});

  final String title;

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: BlocConsumer<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.wasIncremented == true) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'The number incremented',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 200),
            ));
          } else if (state.wasIncremented == false && state.counterValue != 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'The number decremented',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
                duration: Duration(milliseconds: 200),
              ),
            );
          } else if (state.wasIncremented == false && state.counterValue == 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'The number reset to zero',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.blue,
                duration: Duration(milliseconds: 200),
              ),
            );
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: Center(
                      child: Text(
                        '${state.counterValue}',
                        style: TextStyle(
                            fontSize: 100,
                            color: state.counterValue >= 0
                                ? Colors.green
                                : Colors.red),
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    height: 250,
                    width: 250,
                    padding: EdgeInsets.all(20),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        // BlocProvider.of<CounterCubit>(context).decrement();
                        context.read<CounterCubit>().decrement();
                      },
                      child: Icon(Icons.remove, size: 25, color: Colors.white),
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        // BlocProvider.of<CounterCubit>(context).refresh();
                         context.read<CounterCubit>().refresh();
                      },
                      child: Icon(Icons.refresh, size: 25, color: Colors.white),
                      backgroundColor: Colors.blue,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        // BlocProvider.of<CounterCubit>(context).increment();
                        context.read<CounterCubit>().increment();
                      },
                      child: Icon(Icons.add, size: 25, color: Colors.white),
                      backgroundColor: Colors.green,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
