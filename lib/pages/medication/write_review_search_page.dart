import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/pharmacy.dart';
import 'package:http/http.dart' as http;
import 'package:pharmacy_aggregator/models/pharmacy_search_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class WriteReviewSearchPage extends StatefulWidget {
  PharmacySearch pharmacy;
  WriteReviewSearchPage(this.pharmacy);
  @override
  _WriteReviewSearchPageState createState() => _WriteReviewSearchPageState();
}

class _WriteReviewSearchPageState extends State<WriteReviewSearchPage> {
  var first = false;
  var second = false;
  var third = false;
  var fourth = false;
  var fifth = false;
  var rating = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: buildAppBar(widget.pharmacy.name),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text('Оставить отзыв об аптеке', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black45)),
                    child: Column(children: [
                      Row(children: [
                        Container(
                          height: 35,
                          width: 115,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(children: [
                              GestureDetector(
                                  onTap: () {
                                    first = true;
                                    second = false;
                                    third = false;
                                    fourth = false;
                                    fifth = false;
                                    rating = 1;
                                    setState((){});
                                  },
                                  child:Icon(first ? Icons.star : Icons.star_border_outlined, color: Colors.yellow, size: 20)),
                              GestureDetector(
                                  onTap: () {
                                    first = true;
                                    second = true;
                                    third = false;
                                    fourth = false;
                                    fifth = false;
                                    rating = 2;
                                    setState((){});
                                  },
                                  child:Icon(second ? Icons.star : Icons.star_border_outlined, color: Colors.yellow, size: 20)),
                              GestureDetector(
                                  onTap: () {
                                    first = true;
                                    second = true;
                                    third = true;
                                    fourth = false;
                                    fifth = false;
                                    rating = 3;
                                    setState((){});
                                  },
                                  child:Icon(third ? Icons.star : Icons.star_border_outlined, color: Colors.yellow, size: 20)),
                              GestureDetector(
                                  onTap: () {
                                    first = true;
                                    second = true;
                                    third = true;
                                    fourth = true;
                                    fifth = false;
                                    rating = 4;
                                    setState((){});
                                  },
                                  child:Icon(fourth ? Icons.star : Icons.star_border_outlined, color: Colors.yellow, size: 20)),
                              GestureDetector(
                                  onTap: () {
                                    first = true;
                                    second = true;
                                    third = true;
                                    fourth = true;
                                    fifth = true;
                                    rating = 5;
                                    setState((){});
                                  },
                                  child:Icon(fifth ? Icons.star : Icons.star_border_outlined, color: Colors.yellow, size: 20)),
                            ],),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width*0.55,
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Введите имя'
                            ),
                            keyboardType: TextInputType.text,
                            controller: nameController,
                          ),
                        ),
                      ]),
                      Divider(color: Colors.black),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Комментарий'
                          ),
                          keyboardType: TextInputType.text,
                          controller: commentController,
                        ),
                      ),
                    ],)
                ),
              ),
              RaisedButton(
                onPressed: () {
                  sendReview();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                textColor: Colors.white,
                color: Colors.indigo[900],
                elevation: 3.0,
                child: Text("Отправить", style: TextStyle(fontSize: 16,)),
              ),
            ])
    );
  }

  sendReview() async{
    if (rating != 0 && nameController.text != '' && commentController.text != ''){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var token = sharedPreferences.getString('Token');
      final response = await http.post(AppConstants.baseUrl + "product/create/review/",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Accept": "application/json",
            "Authorization": "Token $token"
          },
          body: jsonEncode(<String, dynamic>{
            'pharmacy': widget.pharmacy.id,
            'text': commentController.text,
            'rating': rating.toDouble()
          }));
      print(response.body);
      if (response.statusCode == 200) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              'Успешно!',
            )));

      } else {
        print("Falied to log in.");
      }
    }
    else{
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(
            'Выставьте оценку или заполните все поля!',
          )));
    }
  }
}