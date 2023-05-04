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
    final response = await http.get(Uri.parse('http://swopenapi.seoul.go.kr/api/subway/6a684e6f49646d733130364c4b74466e/xml/realtimeStationArrival/1/10/회기'));
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
          color: Colors.black,
          child: Center(
            child : FutureBuilder(
            future: fetchXmlData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  String text = "";
                  text += '${snapshot.data![9].recptnDt} ';
                  text += '${snapshot.data![1].recptnDt}';
                  dynamic firstlinesec = text.substring(37,39);
                  dynamic firstlinemin = text.substring(34,36);
                  dynamic firstlinehour = text.substring(31,33);
                  
                  dynamic khlinesec = text.substring(17,19);
                  dynamic khlinemin = text.substring(14,16);
                  dynamic khlinehour = text.substring(11,13);

                  firstlinesec = int.parse(firstlinesec);
                  firstlinemin = int.parse(firstlinemin);
                  firstlinehour = int.parse(firstlinehour);
                  khlinesec = int.parse(khlinesec);
                  khlinemin = int.parse(khlinemin);
                  khlinehour = int.parse(khlinehour);
                  
                  var firstlinetime = Duration(hours: firstlinehour, minutes: firstlinemin, seconds: firstlinesec);
                  var khlinetime = Duration(hours: khlinehour, minutes: khlinemin, seconds: khlinesec);
                  var nowtime = Duration(hours: now.hour, minutes: now.minute, seconds: now.second);

                  var firstline = firstlinetime.inSeconds - nowtime.inSeconds;
                  var khline = khlinetime.inSeconds - nowtime.inSeconds;
                  
                  return Text(
                    '1호선 청량리행\n$firstline\n경의중앙선 청량리행\n$khline',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 50,
                      color: Colors.white,
                    ),
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