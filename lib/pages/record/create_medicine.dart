import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_aggregator/components/appBar.dart';
import 'package:pharmacy_aggregator/core/constants.dart';
import 'package:pharmacy_aggregator/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class CreateMedicine extends StatefulWidget {
  @override
  _CreateMedicineState createState() => _CreateMedicineState();
}

class _CreateMedicineState extends State<CreateMedicine> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController compositionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController countController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var avatarImage = DecorationImage(
      fit: BoxFit.fill,
      image: AssetImage("assets/images/Add_ava_placeholder.png"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar('Добавить лекарство'),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 30, left: 5, right: 5),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _imgFromGallery();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, image: avatarImage)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Название лекарство"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Описание"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: compositionController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Город"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: categoryController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Категория"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: manufactureController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Производитель"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: priceController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Цена"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: countController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        hintText: "Количество"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: ButtonTheme(
                      minWidth: 200,
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          var isConnected = checkInternetConnection();
                          isConnected.then((value) => {
                                if (value)
                                  {
                                    if (nameController.text.isNotEmpty &&
                                        compositionController.text.isNotEmpty &&
                                        categoryController.text.isNotEmpty &&
                                        manufactureController.text.isNotEmpty &&
                                        descriptionController.text.isNotEmpty &&
                                        priceController.text.isNotEmpty &&
                                        countController.text.isNotEmpty &&
                                        isChoosedImage)
                                      {
                                        upload(
                                            choosedImage,
                                            nameController.text,
                                            descriptionController.text,
                                            compositionController.text,
                                            categoryController.text,
                                            manufactureController.text,
                                            priceController.text,
                                            countController.text),
                                        createAlertDialog(context)
                                      }
                                    else
                                      {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Заполните все поля!'))),
                                      }
                                  }
                                else
                                  {
                                    showAlert(
                                        "Внимание",
                                        "У вас нет соединения с интернетом!",
                                        context)
                                  }
                              });
                          FocusScopeNode currentFocus = FocusScope.of(context);

                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        textColor: Colors.white,
                        color: Colors.amber[600],
                        elevation: 3.0,
                        child: Text(
                          "Создать",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  var isChoosedImage = false;
  var choosedImage;

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (image != null) {
        isChoosedImage = true;
        choosedImage = image;
        avatarImage =
            DecorationImage(fit: BoxFit.fill, image: FileImage(image));
      }
    });
  }

  upload(File imageFile, String name, String description, String composition,
      String category, String manufacturer, String price, String count) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse(AppConstants.baseUrl + "product/create/");

    var request = new http.MultipartRequest("POST", uri);
    var token = await getToken();
    request.headers['authorization'] = "Token $token";

    request.fields["name"] = name;
    request.fields["description"] = description;
    request.fields["composition"] = composition;
    request.fields["category"] = category;
    request.fields["manufacturer"] = manufacturer;
    request.fields["price"] = price;
    request.fields["count"] = count;

    var multipartFile = new http.MultipartFile('photo', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);

    var response = await request.send();

    // response.stream.transform(utf8.decoder).listen((event) {
    //   print(event);
    // });

    if (response.statusCode == 200) {
      print(response.statusCode);
      Navigator.pop(this.context);
      // Navigator.of(this.context).popUntil((route) => route.isFirst);

      // Navigator.push(
      //     this.context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) =>
      //             PharmacyPage())
      // );
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    } else {
      print(response.statusCode);
      Navigator.pop(this.context);
      // _scaffoldKey.currentState.showSnackBar(SnackBar(
      //     content: Text(
      //   'Проверьте соединения с интернетом или попробуйте позже!',
      // )));
      // print("status no ok");
    }
  }


}
