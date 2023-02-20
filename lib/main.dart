import 'package:drag_drop_game/views/screens/homepage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp(),);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>HomePage(),
      },
    );
  }
}
