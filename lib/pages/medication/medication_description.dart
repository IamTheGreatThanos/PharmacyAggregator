import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/medication.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_detail/medication_composition.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_detail/medication_count.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_detail/medication_feature.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: must_be_immutable
class MedicationDescription extends StatefulWidget {
  Medication medication;
  MedicationDescription(this.medication);
  @override
  _MedicationDescriptionState createState() => _MedicationDescriptionState();
}

class _MedicationDescriptionState extends State<MedicationDescription> {
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print(widget.medication.img);
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: widget.medication.img,
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error, size: MediaQuery.of(context).size.width / 3,),
                ),
                // Image.network(
                //   widget.medication.img,
                //   width: MediaQuery.of(context).size.width / 3,
                //   height: MediaQuery.of(context).size.width / 3,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 4, right: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          width: 140,
                          child: RaisedButton( 
                            child: Text("В избранное", style: TextStyle(fontSize: 14),),  
                            onPressed: (){
                              addToFavorite(widget.medication.id);
                            },
                            color: Colors.indigo[900],  
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                      getTitle("Торговое название"),
                      getText(widget.medication.name),
                      getTitle("Производитель"),
                      getText(widget.medication.manufacturer),
                      getTitle("Цена"),
                      getText(widget.medication.price),
                      // getTitle("Наличие"),
                      // getText("200 шт"),
                      Padding(padding: EdgeInsets.all(10)),
                      getDropDownText("Наличие", () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedicationCount(widget.medication.available, widget.medication.name)));
                      }),
                      getDropDownText("Описание", () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedicationFeature(widget.medication.description)));
                        // showDialog(context: context, builder: (BuildContext context) {
                        //  return  CustomAlertDialog(title : "Описание",);
                        // });
                      }),
                      getDropDownText("Состав", () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedicationComposition(widget.medication.composition)));
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
                    child: Icon(Icons.arrow_forward, color: Colors.black),
                  ),

                ],
              ),
            )),
      ),
    );
  }

  addToFavorite(int productID) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('Token');
    await http.post(
      "${AppConstants.baseUrl}product/favorites",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"
        },
        body: jsonEncode(<String, dynamic>{
          'id': productID,
        })
      ).then((response) {
        final snackBar = SnackBar(content: Text('Добавлено в избранное!'));
        globalKey.currentState.showSnackBar(snackBar);
      }).catchError((error) => print(error));
  }
}
