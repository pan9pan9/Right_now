import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Rightnow(),
    );
  }
}


class Rightnow extends StatefulWidget {
  
  @override
  _RightnowState createState() => _RightnowState();
}

class _RightnowState extends State<Rightnow> {

  @override
  void initState() {

    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: GetTimer(),
        color: Colors.black,
      ),
    );
  }
}

class GetTimer extends StatelessWidget {

  @override
  var now = DateTime.now();
  Widget build(BuildContext context) {
    return Center(
      child: Text('${now.hour}' + ':'+ '${now.minute}' + ':' + '${now.second}',
      style: TextStyle(
        color: Colors.white,
      ),),
    );
  }
}