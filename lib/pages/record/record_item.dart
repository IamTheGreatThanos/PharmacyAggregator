import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/model/record.dart';

class RecordItem extends StatelessWidget {

  final Record record;

  RecordItem(this.record);

  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(label: Text("id", overflow: TextOverflow.ellipsis,)),
            DataColumn(label: Text(
                "Наименование лекарств", overflow: TextOverflow.ellipsis)),
            DataColumn(
                label: Text("Код (Артикул)", overflow: TextOverflow.ellipsis)),
            DataColumn(
                label: Text("Кол-во наличии", overflow: TextOverflow.ellipsis)),
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
      );

  }
}

// SingleChildScrollView(
//   scrollDirection: Axis.horizontal,
//   child: SingleChildScrollView(
//     scrollDirection: Axis.vertical,
//     child: DataTable(
//       columns: [
//         DataColumn(label: Text("id", overflow: TextOverflow.ellipsis  ,)),
//         DataColumn(label: Text("Наименование лекарств", overflow: TextOverflow.ellipsis)),
//         DataColumn(label: Text("Код (Артикул)", overflow: TextOverflow.ellipsis)),
//         DataColumn(label: Text("Кол-во наличии", overflow: TextOverflow.ellipsis)),
//         DataColumn(label: Text("Цена", overflow: TextOverflow.ellipsis)),
//       ],
//       rows: [
//         DataRow(cells: [
//           DataCell(Text("01")),
//           DataCell(Text("Мезим")),
//           DataCell(Text("00982514")),
//           DataCell(Text("500")),
//           DataCell(Text("780 тг"))
//         ])
//       ],
//     ),
//   ),
// ),