import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/record.dart';
import 'package:pharmacy_aggregator/pages/record/record_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  List<Record> recordList = [];

  @override
  void initState() {
    super.initState();
    getProjectDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Учет'),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                columns: [
                  DataColumn(
                      label: Text(
                    "id",
                    overflow: TextOverflow.ellipsis,
                  )),
                  DataColumn(
                      label: Text("Наименование лекарств",
                          overflow: TextOverflow.ellipsis)),
                  DataColumn(
                      label: Text("Код (Артикул)",
                          overflow: TextOverflow.ellipsis)),
                  DataColumn(
                      label: Text("Кол-во наличии",
                          overflow: TextOverflow.ellipsis)),
                  DataColumn(
                      label: Text("Цена", overflow: TextOverflow.ellipsis)),
                ],
                rows: recordList
                    .map(
                      ((e) => DataRow(cells: [
                            DataCell(Text((recordList.indexOf(e)+1).toString())),
                            DataCell(Text(e.name)),
                            DataCell(Text(e.code)),
                            DataCell(Text(e.count.toString())),
                            DataCell(Text(e.price))
                          ])),
                    )
                    .toList(),
              )),
        ),
      ),
    );
  }

  Future<Null> _refresh() async {
    // await Future.delayed(Duration(seconds: 2));
    return null;
  }

  getProjectDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('Token');
    await http.get(
      "${AppConstants.baseUrl}product/accounting/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"
        },
      ).then((response) {
        print(response.statusCode);
        List<Record> list = List<Record>();
        var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
        print(responseBody);
        for (Object i in responseBody){
          Map<String,dynamic> j = i;
          list.add(Record(j['product']['name'], j['count'], j['product']['id'].toString(), j['price'].toString() + ' тг'));
        }
        setState(() {
          recordList = list;
        });
      }).catchError((error) => print(error));
  }
}
