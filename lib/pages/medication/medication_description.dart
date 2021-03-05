import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/utill/my_dialog.dart';

class MedicationDescription extends StatefulWidget {
  const MedicationDescription({Key key}) : super(key: key);

  @override
  _MedicationDescriptionState createState() => _MedicationDescriptionState();
}

class _MedicationDescriptionState extends State<MedicationDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  "https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg",
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 4, right: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getTitle("Торговое название"),
                      getText("Мезим форте",),
                      getTitle("Производитель"),
                      getText("Berlin-Chemie"),
                      getTitle("Цена"),
                      getText("от 565 тг"),
                      getTitle("Наличие"),
                      getText("200 шт"),
                      getDropDownText("Описание", () {
                        showDialog(context: context, builder: (BuildContext context) {
                         return  CustomAlertDialog(title : "Описание",);
                        });
                      }),
                      getDropDownText("Состав", () {

                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
      
    );
  }

  Widget getTitle(String title) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
        child: Text(
          title,
          style: TextStyle(fontSize: 15, fontFamily: AppFonts.montesseratSemiBold,color: Colors.black),
        ));
  }

  Widget getText(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 2, 15, 5),
      child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black, width: 0.5))
            // borderRadius: BorderRadius.circular(8),
               ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 13, 0, 6),
            child:  Text(text, style: TextStyle(color: Colors.black45, fontSize: 14)),
          )),
    );
  }
  Widget getDropDownText(String text, _ontap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 2, 15, 5),
      child: GestureDetector(
        onTap: _ontap,
        child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black, width: 0.7))
              // borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 13, 0, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: AppFonts.montesseratSemiBold)),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.arrow_drop_down, color: Colors.black),
                  ),

                ],
              ),
            )),
      ),
    );
  }
}
