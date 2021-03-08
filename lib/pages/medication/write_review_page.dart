import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';

class WriteReviewPage extends StatefulWidget {
  @override
  _WriteReviewPageState createState() => _WriteReviewPageState();
}

class _WriteReviewPageState extends State<WriteReviewPage> {
  TextEditingController nameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar('Аптека "Forte+"'),
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
                      Icon(Icons.star_border_outlined, color: Colors.yellow, size: 20),
                      Icon(Icons.star_border_outlined, color: Colors.yellow, size: 20),
                      Icon(Icons.star_border_outlined, color: Colors.yellow, size: 20),
                      Icon(Icons.star_border_outlined, color: Colors.yellow, size: 20),
                      Icon(Icons.star_border_outlined, color: Colors.yellow, size: 20),
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
                  controller: nameController,
                ),
              ),
            ],)
          ),
        ),
        RaisedButton(
          onPressed: () {},
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
}