import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/models/record.dart';
import 'package:pharmacy_aggregator/pages/record/record_item.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  List<Record> recordList = [
    Record("Мезим", "500", "00952414", "780 тг"),
    Record("Мезим", "500", "00952414", "780 тг"),
    Record("Мезим", "500", "00952414", "780 тг"),
    Record("Мезим", "500", "00952414", "780 тг"),
  ];

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
                            DataCell(Text(recordList.indexOf(e).toString())),
                            DataCell(Text(e.name)),
                            DataCell(Text(e.code)),
                            DataCell(Text(e.count)),
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
}
