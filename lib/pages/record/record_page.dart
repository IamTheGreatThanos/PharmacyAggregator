import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';


class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Учет'),
      backgroundColor: Colors.white,
      body:
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: [
              DataColumn(label: Text("id", overflow: TextOverflow.ellipsis  ,)),
              DataColumn(label: Text("Наименование лекарств", overflow: TextOverflow.ellipsis)),
              DataColumn(label: Text("Код (Артикул)", overflow: TextOverflow.ellipsis)),
              DataColumn(label: Text("Кол-во наличии", overflow: TextOverflow.ellipsis)),
              DataColumn(label: Text("Цена", overflow: TextOverflow.ellipsis)),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text("01")),
                DataCell(Text("Мезим")),
                DataCell(Text("00982514")),
                DataCell(Text("500")),
                DataCell(Text("780 тг"))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
