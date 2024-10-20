import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      age: 10,
      name: "some name",
      child: InheritedExample(),
    );
  }
}

class InheritedExample extends StatelessWidget {
  const InheritedExample({super.key});

  @override
  Widget build(BuildContext context) {
    int someAge = MyInheritedWidget.of(context).age;
    String someName = MyInheritedWidget.of(context).name;
    
    return MaterialApp(
        home: Scaffold(
          body: Center(child: Text("Some text - $someName, $someAge")),
        ),
      );
  }
}


class MyInheritedWidget extends InheritedWidget {
  final String name;
  final int age;

  MyInheritedWidget({
    required this.name,
    required this.age,
    required Widget child
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
  }
}