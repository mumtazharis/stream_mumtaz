import 'package:flutter/material.dart';
import 'stream.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Mumtaz',
      theme: ThemeData(
        
        primarySwatch: Colors.deepPurple,
      ),
      home: const StreamHomePage(),
    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});
  @override
  State<StreamHomePage> createState() => StreamHomePageState();
}

class StreamHomePageState extends State<StreamHomePage> {
  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;

  // void changeColor() async {
  //   await for (var eventColor in colorStream.getColors()){
  //     setState(() {
  //       bgColor = eventColor;
  //     });
  //   }
  // }
  void changeColor() async {
    colorStream.getColors().listen((eventColor){
      setState(() {
        bgColor = eventColor;
      });
    });
  }

  @override
  void initState(){
    super.initState();
    colorStream = ColorStream();
    changeColor();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Mumtaz'),
      ),
      body: Container(
        decoration: BoxDecoration(color: bgColor),
      )
    );
  }
}
