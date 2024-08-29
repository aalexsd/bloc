import 'package:bloc_pattern_without_package/counter_event.dart';
import 'package:flutter/material.dart';

import 'counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final CounterBloc _counterBloc = CounterBloc();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _counterBloc.counterEventSink.add(IncrementEvent());
                    },
                    child: Icon(Icons.add)),
                SizedBox(
                  width: 10,
                ),
                StreamBuilder<int>(
                    initialData: 0,
                    stream: _counterBloc.counter,
                    builder: (context, AsyncSnapshot<int> snapshot) {
                      return Text(
                        '${snapshot.data}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    }),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      _counterBloc.counterEventSink.add(DecrementEvent());
                    },
                    child: Icon(Icons.remove)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
