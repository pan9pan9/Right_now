import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

void main() {

  Future<xml.XmlDocument> fetchXmlData() async {
    final response = await http.get(Uri.parse('http://swopenapi.seoul.go.kr/api/subway/6a684e6f49646d733130364c4b74466e/xml/realtimeStationArrival/1/3/회기'));
    return xml.parse(response.body);
  }
  
  test('subway', () async {
    final document = await fetchXmlData();
    final items = document.findAllElements('row');
    var subway = <Subway>[];
    items.forEach((node) {
      subway.add(Subway.fromXml(node));
    });
    for (var subway in subway) {
    Text(
      '${subway.trainLineNm} : ${subway.recptnDt}',
    );
  }
  });
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