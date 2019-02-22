import 'package:flutter_bloc_stream_demo/bloc.dart';
import 'package:flutter_bloc_stream_demo/event_type.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Bloc Demo', bloc: Bloc()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.bloc}) : super(key: key);

  final String title;
  final Bloc bloc;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> _getActionButtons() {
    List<Widget> mList = [
      FloatingActionButton(
        onPressed: () =>
            widget.bloc.streamInEvent.add(EventType.Increment),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      SizedBox(width: 12.0),
      FloatingActionButton(
        onPressed: () =>
            widget.bloc.streamInEvent.add(EventType.Decrement),
        tooltip: 'Decrement',
        child: Icon(Icons.remove),
      ),
    ];

    return mList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: StreamBuilder(
            stream: widget.bloc.streamOutCounter,
            initialData: 0,
            builder: (context, snapshot) {
              return Center(
                child: Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.display1,
                ),
              );
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: _getActionButtons(),
        ));
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
