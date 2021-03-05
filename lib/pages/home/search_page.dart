import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy_aggregator/models/medication.dart';
import 'package:pharmacy_aggregator/models/notification.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_data.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_item.dart';
import 'package:pharmacy_aggregator/pages/notification/notification_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _searchController = new TextEditingController();
  FocusNode focusNode;


  List<Medication> medicationList = [
    Medication(
        "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
        "Berlin-Chemie", "Мезим форте таб. п/о №80", "от 565 тг", false),
    Medication(
        "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
        "Berlin-Chemie", "Мезим форте таб. п/о №80", "от 100 тг", false),
    Medication(
        "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
        "Berlin-Chemie", "Мезим форте таб. п/о №80", "от 200 тг", true),
    Medication(
        "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
        "Berlin-Chemie", "Мезим форте таб. п/о №80", "от 300 тг", false),
    Medication(
        "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
        "Berlin-Chemie", "Мезим форте таб. п/о №80", "от 456 тг", true),
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    focusNode.requestFocus();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.unfocus();
    focusNode.dispose();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar('Поиск лекарств'),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                getProjectDetails(value);
              },
              focusNode: focusNode,
              controller: _searchController,
              cursorColor: Colors.indigo[300],
              decoration: InputDecoration(
                hintText: "Введите название лекарства",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hoverColor: Colors.indigo,
                suffixIcon: Icon(Icons.search),
                contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              ),
            ),
            Expanded(
              child: projectWidget()
                // child: ListView.builder(
                //   scrollDirection: Axis.vertical,
                //     itemCount: medicationList.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return GestureDetector(
                //           onTap: () {
                //             Navigator.push(context,
                //                 MaterialPageRoute(builder: (context) => MedicationData()));
                //           },
                //           child: MedicationItem(item: medicationList[index]));
                //     }),
              ),
          ],
        ),
      ),
    );
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MedicationData()));
          },
          child: ListView.builder(
            itemCount: projectSnap.data.length,
            itemBuilder: (context, index) {
              Medication project = projectSnap.data[index];
              return MedicationItem(item: project);
            },
          ),
        );
      },
      future: getProjectDetails(_searchController.text),
    );
  }

  Future getProjectDetails(word) async {
    // print(word);
    // List<Medication> med = [];
    // for (Medication i in medicationList) {
    //   if (int.parse(i.price) > int.parse(word)) {
    //       med.add(i);
    //   }
    // }
    return medicationList;
  }
}
