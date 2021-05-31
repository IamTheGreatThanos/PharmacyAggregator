import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/medication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'medication_data.dart';

class SimilarPage extends StatefulWidget {

  int productId;
  SimilarPage(this.productId);

  @override
  _SimilarPageState createState() => _SimilarPageState();
}

class _SimilarPageState extends State<SimilarPage> {
  final globalKey = GlobalKey<ScaffoldState>();
  List<Medication> medicationList = [];

  @override
  void initState() {
    getProducts(widget.productId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
        key: globalKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 5, right: 5),
              child: SizedBox(
                height: (medicationList.length ~/ 3 + 1) * itemWidth + 100,
                child: GridView.count(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 3,
                  physics: new NeverScrollableScrollPhysics(),
                  childAspectRatio: (itemWidth / itemHeight),
                  children: List.generate(medicationList.length, (index) {
                    return CircleImage(
                        onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MedicationData(
                                          medicationList[index])))
                            },
                        imgURL: medicationList[index].img,
                        titleText: medicationList[index].name);
                  }),
                ),
              ),
            ),
          ),
        ));
  }
  getProducts(int productId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('Token');
    await http.get(
      "${AppConstants.baseUrl}product/similar/$productId",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Authorization": "Token $token"
      },
    ).then((response) {
      print(response.statusCode);
      // print("asdasdasdasdasdassssssssssss");
      List<Medication> list = List<Medication>();
      print(response.body);
      var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
      print(responseBody);
      for (Object i in responseBody){
        Map<String,dynamic> j = i;
        if (j['available'].length != 0){
          list.add(Medication(j['id'], j['name'], j['manufacturer']['name'], j['photo'] , j['description'], 'от ' + j['available'][0]['price'].toString() + 'тг.', true, j['composition'], j['available']));
        }
        else{
          list.add(Medication(j['id'], j['name'], j['manufacturer']['name'], j['photo'] , j['description'], 'от 0 тг.', true, j['composition'], j['available']));
        }
      }
      setState(() {
        medicationList = list;
      });
    }).catchError((error) => print(error));
  }
}

class CircleImage extends StatelessWidget {
  final GestureTapCallback onTap;
  final String imgURL;
  final String titleText;

  const CircleImage({Key key, this.onTap, this.imgURL, this.titleText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 3.7;
    return Container(
      width: size,
      child: Column(
        children: [
          InkResponse(
            onTap: onTap,
            child: new Container(
              width: size,
              height: size,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl: imgURL,
                imageBuilder: (context, imageProvider) => Container(
                  // width: MediaQuery.of(context).size.width / 3,
                  // height: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, size: size),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(titleText,
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: AppFonts.montesseratMedium,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
