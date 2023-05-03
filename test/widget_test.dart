import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';


void main() {
  final bookshelfXml = '''<realtimeStationArrival>
<RESULT>
<code>INFO-000</code>
<developerMessage/>
<link/>
<message>정상 처리되었습니다.</message>
<status>200</status>
<total>13</total>
</RESULT>
<row>
<rowNum>1</rowNum>
<selectedCount>3</selectedCount>
<totalCount>13</totalCount>
<subwayId>1001</subwayId>
<updnLine>상행</updnLine>
<trainLineNm>소요산행 - 외대앞방면</trainLineNm>
<statnFid>1001000124</statnFid>
<statnTid>1001000122</statnTid>
<statnId>1001000123</statnId>
<statnNm>회기</statnNm>
<ordkey>01000소요산0</ordkey>
<subwayList>1001,1063</subwayList>
<statnList>1001000123,1063075118</statnList>
<barvlDt>0</barvlDt>
<btrainNo>0112</btrainNo>
<bstatnId>190</bstatnId>
<bstatnNm>소요산</bstatnNm>
<recptnDt>2023-05-03 15:47:33</recptnDt>
<arvlMsg2>회기 도착</arvlMsg2>
<arvlMsg3>회기</arvlMsg3>
<arvlCd>1</arvlCd>
</row>
<row>
<rowNum>2</rowNum>
<selectedCount>3</selectedCount>
<totalCount>13</totalCount>
<subwayId>1063</subwayId>
<updnLine>상행</updnLine>
<trainLineNm>문산행 - 청량리방면</trainLineNm>
<statnFid>1063075119</statnFid>
<statnTid>1063075117</statnTid>
<statnId>1063075118</statnId>
<statnNm>회기</statnNm>
<ordkey>01002문산0</ordkey>
<subwayList>1001,1063,1067</subwayList>
<statnList>1001000123,1063075118</statnList>
<barvlDt>0</barvlDt>
<btrainNo>5092</btrainNo>
<bstatnId>234</bstatnId>
<bstatnNm>문산</bstatnNm>
<recptnDt>2023-05-03 15:47:38</recptnDt>
<arvlMsg2>[2]번째 전역 (상봉)</arvlMsg2>
<arvlMsg3>상봉</arvlMsg3>
<arvlCd>99</arvlCd>
</row>
<row>
<rowNum>3</rowNum>
<selectedCount>3</selectedCount>
<totalCount>13</totalCount>
<subwayId>1067</subwayId>
<updnLine>상행</updnLine>
<trainLineNm>청량리행 - 청량리방면</trainLineNm>
<statnFid>1067080118</statnFid>
<statnTid>1067080116</statnTid>
<statnId>1067080117</statnId>
<statnNm>회기</statnNm>
<ordkey>01010청량리0</ordkey>
<subwayList>1001,1063,1067</subwayList>
<statnList>1001000123,1063075118,1067080117</statnList>
<barvlDt>0</barvlDt>
<btrainNo>8060</btrainNo>
<bstatnId>166</bstatnId>
<bstatnNm>청량리</bstatnNm>
<recptnDt>2023-05-03 15:48:27</recptnDt>
<arvlMsg2>[10]번째 전역 (평내호평)</arvlMsg2>
<arvlMsg3>평내호평</arvlMsg3>
<arvlCd>99</arvlCd>
</row>
</realtimeStationArrival>''';

  test('subway', () {
    final document = XmlDocument.parse(bookshelfXml);
    final items = document.findAllElements('row');
    var subway = <Subway>[];
    items.forEach((node) {
      subway.add(Subway.fromXml(node));
    });
    print(subway.length);
    subway.forEach((subway){
      print('${subway.trainLineNm} : ${subway.recptnDt}');
    });
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