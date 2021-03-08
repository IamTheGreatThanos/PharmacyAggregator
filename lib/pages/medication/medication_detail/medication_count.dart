import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';

class MedicationCount extends StatefulWidget {
  @override
  _MedicationCountState createState() => _MedicationCountState();
}

class _MedicationCountState extends State<MedicationCount> {
  var array = ['Аптека "Форте+" - 200шт', 'Аптека "Биосфера" - 160шт'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("Мезим форте таб. п/о №80"),
      body: Column(children:[
        Container(
          width: MediaQuery.of(context).size.width*0.9, 
          height: 40,
          decoration: BoxDecoration(border: Border.all(color: Colors.indigo[600])),
          child: Center(child: Text('Наличие товара', style: TextStyle(fontSize: 18),))
        ),
        ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
          shrinkWrap: true,
          itemCount: array.length,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 0),
              child: ListTile(
                title: Text(array[index],
                    style: TextStyle(fontSize: 15, color: Colors.black54)),
                trailing: Text('1638 тг', style: TextStyle(fontSize: 15, color: Colors.black54)),
                tileColor: Colors.white,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationCount()),);
              }),
            );
          }),
      ]),
    );
  }
}
