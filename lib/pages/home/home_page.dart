import 'package:flutter/material.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/pages/medication/medication_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _searchController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("Главная"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
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
                        onTap: () =>  Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedicationPage() )),
                        iconData: Icons.favorite_border,
                        titleText: "Лекарственные препараты"),
                    CircleButton(
                        onTap: () =>  Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedicationPage() )),
                        iconData: Icons.favorite_border,
                        titleText: "Медицинские изделия и приборы"),
                    CircleButton(
                        onTap: () =>  Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedicationPage() )),
                        iconData: Icons.favorite_border,
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
                        onTap: () =>  Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedicationPage() )),
                        iconData: Icons.favorite_border,
                        titleText: "Витамины и БАДы"),
                    CircleButton(
                        onTap: () =>  Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedicationPage() )),
                        iconData: Icons.favorite_border,
                        titleText: "Косметика  и средства гигиены"),
                    CircleButton(
                        onTap: () =>  Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MedicationPage() )),
                        iconData: Icons.favorite_border,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleImage(
                        onTap: () => print("Cool"),
                        iconData: Icons.favorite_border,
                        titleText: "Навтизин капли назальные"),
                    CircleImage(
                        onTap: () => print("Cool"),
                        iconData: Icons.favorite_border,
                        titleText: "Навтизин капли назальные"),
                    CircleImage(
                        onTap: () => print("Cool"),
                        iconData: Icons.favorite_border,
                        titleText: "Навтизин капли назальные"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 5, right: 5, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleImage(
                        onTap: () => print("Cool"),
                        iconData: Icons.favorite_border,
                        titleText: "Навтизин капли назальные"),
                    CircleImage(
                        onTap: () => print("Cool"),
                        iconData: Icons.favorite_border,
                        titleText: "Навтизин капли назальные"),
                    CircleImage(
                        onTap: () => print("Cool"),
                        iconData: Icons.favorite_border,
                        titleText: "Навтизин капли назальные"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class CircleImage extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final String titleText;

  const CircleImage({Key key, this.onTap, this.iconData, this.titleText})
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
              child: Image.network("https://ksintez.ru/upload/resize_cache/iblock/2ee/880_750_1/Naftizin.jpg")
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
  final IconData iconData;
  final String titleText;

  const CircleButton({Key key, this.onTap, this.iconData, this.titleText})
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
                color: Colors.indigo[900],
                shape: BoxShape.circle,
              ),
              child: new Icon(
                iconData,
                color: Colors.white,
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
