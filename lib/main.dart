import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('subway', (){
    print("test");
  });
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
        child: GetTime(),
        color: Colors.black,
      ),
    );
  }
}


class GetTime extends StatelessWidget {
  var now = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('Hi'),
        color: Colors.black,
      ),
    );
  }
}