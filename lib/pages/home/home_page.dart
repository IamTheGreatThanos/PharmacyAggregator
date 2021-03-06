import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/models/medication.dart';
import 'package:pharmacy_aggregator/pages/home/search_page.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_data.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = new TextEditingController();
  FocusNode focusNode = new FocusNode();

  List<Medication> medicationList = [];

  @override
  void initState() {
    super.initState();
    getProducts();
    sendDeviceToken();
    focusNode.unfocus();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: buildAppBar("Главная"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getText("Введите название лекарства", Icons.search),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text("Категории лекарств",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.montesseratSemiBold,
                        color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleButton(
                        onTap: () =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicationPage(1))),
                        iconData: 'assets/images/1.png',
                        titleText: "Лекарственные препараты"),
                    CircleButton(
                        onTap: () =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicationPage(2))),
                        iconData: 'assets/images/2.png',
                        titleText: "Медицинские изделия и приборы"),
                    CircleButton(
                        onTap: () =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicationPage(4))),
                        iconData: 'assets/images/3.png',
                        titleText: "Травы, сборы, бальзамы"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleButton(
                        onTap: () =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicationPage(5))),
                        iconData: 'assets/images/4.png',
                        titleText: "Витамины и БАДы"),
                    CircleButton(
                        onTap: () =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicationPage(6))),
                        iconData: 'assets/images/5.png',
                        titleText: "Косметика  и средства гигиены"),
                    CircleButton(
                        onTap: () =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicationPage(3))),
                        iconData: 'assets/images/6.png',
                        titleText: "Мама и малыш"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14),
                child: Text("Рекомендуем",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: AppFonts.montesseratSemiBold,
                        color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 5, right: 5),
                child: SizedBox(
                  height: (medicationList.length~/3+1)*itemWidth+100,
                  child: GridView.count(
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 3,
                    physics: new NeverScrollableScrollPhysics(),
                    childAspectRatio: (itemWidth / itemHeight),
                    children: List.generate(medicationList.length, (index) {
                      return CircleImage(
                          onTap: () => {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedicationData(medicationList[index])))
                          },
                          imgURL: medicationList[index].img,
                          titleText: medicationList[index].name
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getText(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 5, 6, 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchPage()));
        },
        child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black45),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 13, 10, 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(text, style: TextStyle(color: Colors.black,
                      fontFamily: AppFonts.montesseratRegular)),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(icon, color: Colors.black),
                  ),
                ],
              ),
            )),
      ),
    );
  }


  sendDeviceToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      var isSended =
      sharedPreferences.getBool(AppConstants.isSendedDeviceToken);
      if (isSended == null || isSended == false) {
        var token = sharedPreferences.getString("Token");
        var deviceToken = sharedPreferences.getString(AppConstants.deviceToken);
        // print(deviceToken);
        if (deviceToken != null){
          var url = "${AppConstants.baseUrl}users/push/register/";
          var headers = {
            "Accept": "application/json",
            "Authorization": "Token $token"
          };
          final response = await http.post(url, headers: headers, body: {
            "reg_id": deviceToken,
            // "cmt": "fcm",
          });

          if (response.statusCode == 200) {
            Map<String, dynamic> status = jsonDecode(response.body);
            if (status['status'] == "ok") {
              print("send device token");
              sharedPreferences.setBool(AppConstants.isSendedDeviceToken, true);
              // print("sended device token");
            }
          }
        }
      }
    }

  getProducts() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('Token');
    await http.get(
      "${AppConstants.baseUrl}product/recomendation/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Accept": "application/json",
          "Authorization": "Token $token"
        },
      ).then((response) {
        List<Medication> list = List<Medication>();
        var responseBody = jsonDecode(utf8.decode(response.body.codeUnits));
        // print(responseBody);
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
    double size = MediaQuery
        .of(context)
        .size
        .width / 3.7;
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
                      errorWidget: (context, url, error) => Icon(Icons.error, size: size),
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

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String iconData;
  final String titleText;

  const CircleButton({Key key, this.onTap, this.iconData, this.titleText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery
        .of(context)
        .size
        .width / 3.7;
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
                color: Colors.indigo[900],
                shape: BoxShape.circle,
              ),
              child: new Image.asset(
                iconData,
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
