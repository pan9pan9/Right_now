import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';
import 'package:flutter_test/flutter_test.dart';

void main() => runApp(MyApp());


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

  Future<List<Subway>> fetchXmlData() async {
    final response = await http.get(Uri.parse('http://swopenapi.seoul.go.kr/api/subway/6a684e6f49646d733130364c4b74466e/xml/realtimeStationArrival/1/3/회기'));
    final document = xml.parse(response.body);
    final items = document.findAllElements('row');

    var subway = <Subway>[];
    items.forEach((node) {
      subway.add(Subway.fromXml(node));
    });
      
    return subway;
  }
  

  
  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: FutureBuilder(
            future: fetchXmlData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  String text = "";
                  var length2 = snapshot.data?.length;
                  for(var i = 0; i < length2!; i++){
                    text += '${snapshot.data![i].trainLineNm} : ${snapshot.data![i].recptnDt}\n';
                  }
                  return Text(
                    text,
                  );
                } else {
                    return Text('No data');
                }
              } else {
                  return Text('Loading...');
              }
            },
          ),
        ),
      );
    }
}


class Subway {
  String? rowNum;
  String? selectedCount;
  String? totalCount;
  String? subwayId;
  String? updnLine;
  String? trainLineNm;
  String? statnFid;
  String? statnTid;
  String? statnId;
  String? statnNm;
  String? ordkey;
  String? subwayList;
  String? statnList;
  String? barvlDt;
  String? btrainNo;
  String? bstatnId;
  String? recptnDt;
  String? arvlMsg2;
  String? arvlMsg3;
  String? arvlCd;

  Subway({
      this.rowNum,
      this.selectedCount,
      this.totalCount,
      this.subwayId,
      this.updnLine,
      this.trainLineNm,
      this.statnFid,
      this.statnTid,
      this.statnId,
      this.statnNm,
      this.ordkey,
      this.subwayList,
      this.statnList,
      this.barvlDt,
      this.btrainNo,
      this.bstatnId,
      this.recptnDt,
      this.arvlMsg2,
      this.arvlMsg3,
      this.arvlCd});

    factory Subway.fromXml(XmlElement xml){
      return Subway(
        rowNum : PutElement.searchResult(xml, 'rowNum'),
        selectedCount : PutElement.searchResult(xml, 'selectedCount'),
        totalCount : PutElement.searchResult(xml, 'totalCount'),
        subwayId : PutElement.searchResult(xml, 'subwayId'),
        updnLine : PutElement.searchResult(xml, 'updnLine'),
        trainLineNm : PutElement.searchResult(xml, 'trainLineNm'),
        statnFid : PutElement.searchResult(xml, 'statnFid'),
        statnTid : PutElement.searchResult(xml, 'statnTid'),
        statnId : PutElement.searchResult(xml, 'statnId'),
        statnNm : PutElement.searchResult(xml, 'statnNm'),
        ordkey : PutElement.searchResult(xml, 'ordkey'),
        subwayList : PutElement.searchResult(xml, 'subwayList'),
        statnList : PutElement.searchResult(xml, 'statnList'),
        barvlDt : PutElement.searchResult(xml, 'barvlDt'),
        btrainNo : PutElement.searchResult(xml, 'btrainNo'),
        bstatnId : PutElement.searchResult(xml, 'bstatnId'),
        recptnDt : PutElement.searchResult(xml, 'recptnDt'),
        arvlMsg2 : PutElement.searchResult(xml, 'arvlMsg2'),
        arvlMsg3 : PutElement.searchResult(xml, 'arvlMsg3'),
        arvlCd : PutElement.searchResult(xml, 'arvlCd'),
      );
    }
}

class PutElement{
  static String searchResult(XmlElement xml, String key){
    return xml.findAllElements(key).map((e) => e.text).isEmpty? "" :xml.findAllElements(key).map((e)=> e.text).first;
  }
}