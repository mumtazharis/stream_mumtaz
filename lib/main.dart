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
  int lastNumber = 0;
  late StreamController numberStreamController;
  late NumberStream numberStream;
  late StreamTransformer transformer;
  late StreamSubscription subscription;

  void changeColor() async {
    colorStream.getColors().listen((eventColor){
      setState(() {
        bgColor = eventColor;
      });
    });
  }

  void addRandomNumber(){
    Random random = Random();
    int myNum = random.nextInt(10);
    if (!numberStreamController.isClosed){
      numberStream.addNumberToSink(myNum);
    } else {
      setState(() {
        lastNumber = -1;
      });
    }

    // numberStream.addError();
  }

  @override
  void initState(){
    // transformer = StreamTransformer<int, int>.fromHandlers(
    //   handleData: (value, sink){
    //     sink.add(value * 10);
    //   },
    //   handleError: (error, trace, sink){
    //     sink.add(-1);
    //   },
    //   handleDone: (sink) => sink.close()
    // );
    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    Stream stream = numberStreamController.stream;
    subscription = stream.listen((event){
      setState(() {
        lastNumber = event;
      });
    });
    subscription.onError((error){
      setState(() {
        lastNumber = -1;
      });
    });
    subscription.onDone((){
      print('OnDone was called');
    });
    // stream.transform(transformer).listen((event){
    //   setState(() {
    //     lastNumber = event;
    //   });
    // }).onError((error){
    //   setState(() {
    //     lastNumber = -1;
    //   });
    // });
    super.initState();


  }
  void stopStream(){
    numberStreamController.close();
  }
  @override
  void dispose(){
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Mumtaz'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(lastNumber.toString()),
            ElevatedButton(
              onPressed: () => addRandomNumber(), 
              child: Text('New Random Number'),
            ),
            ElevatedButton(
              onPressed: () => stopStream(), 
              child: const Text('Stop Subscription'))
          ],
        ),
      )
    );
  }
}
