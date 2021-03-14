import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/models/pharmacy.dart';

import '../pharmacy_page.dart';

class MedicationCount extends StatefulWidget {
  List<dynamic> listPharmacy;
  String title;
  MedicationCount(this.listPharmacy, this.title);
  @override
  _MedicationCountState createState() => _MedicationCountState();
}

class _MedicationCountState extends State<MedicationCount> {
  var array = [];
  var array2 = [];

  @override
  void initState() {
    for (var i in widget.listPharmacy){
      array.add('"${i['pharmacy']['name']}" - ${i['count']} шт.');
      array2.add('от ${i['price']} тг.');
    }
    super.initState();

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(widget.title),
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
                trailing: Text(array2[index], style: TextStyle(fontSize: 15, color: Colors.black54)),
                tileColor: Colors.white,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PharmacyPage(Pharmacy(widget.listPharmacy[index]['id'],widget.listPharmacy[index]['pharmacy'], widget.listPharmacy[index]['count'], widget.listPharmacy[index]['price'],widget.listPharmacy[index]['product']))),);
              }),
            );
          }),
          Divider(color: Colors.black),
      ]),
    );
  }
}
