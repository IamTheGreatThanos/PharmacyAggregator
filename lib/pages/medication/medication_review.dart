import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/models/review.dart';
import 'package:pharmacy_aggregator/pages/medication/write_review_page.dart';

class MedicationReview extends StatefulWidget {
  @override
  _MedicationReviewState createState() => _MedicationReviewState();
}

class _MedicationReviewState extends State<MedicationReview> {
  List<Review> array = [Review('Марина', '07 января 2021 в 14:05', '1234', 'МаринаМаринаМаринаМаринаМаринаМаринаМаринаМаринаМаринаМаринаМаринаМарина'),Review('Марина', '07 января 2021 в 14:05', '1234', 'МаринаМаринаМаринаМаринаМаринаМаринаМаринаМаринаМаринаМаринаМаринаМарина')];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width*0.75, 
              height: 35,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.indigo[800]),
              child: Center(child: Text('Оставить отзыв', style: TextStyle(fontSize: 16, color: Colors.white),))
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => WriteReviewPage()),);
            },
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.star, color: Colors.yellow, size: 30),
          ),
          Text('4.5 из 5', style: TextStyle(fontSize: 20))
        ]),
        Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(children: [
              Text('Cортировать:', style: TextStyle(fontSize: 12)),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal : 20),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  child: Text('по дате', style: TextStyle(fontSize: 12, color: Colors.blue)),
                  onTap: (){
                    print('по дате');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  child: Text('по оценке', style: TextStyle(fontSize: 12, color: Colors.blue)),
                  onTap: (){
                    print('по оценке');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  child: Text('по популярности', style: TextStyle(fontSize: 12, color: Colors.blue)),
                  onTap: (){
                    print('по популярности');
                  },
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Все отзывы:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ]),
        Divider(color: Colors.black),
        ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.black,
          ),
          shrinkWrap: true,
          itemCount: array.length,
          itemBuilder: (_, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(array[index].owner, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Text(array[index].date, style: TextStyle(fontSize: 14, color: Colors.black54))
                  ]),
                  Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: Row(children: [
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                        Icon(Icons.star, color: Colors.yellow, size: 20),
                      ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,5,10,5),
                    child: Text(array[index].text, style: TextStyle(fontSize: 15)),
                  ),
                ],),
              )
            );
          }),
          Divider(color: Colors.black)
      ]
    ));
  }
}
