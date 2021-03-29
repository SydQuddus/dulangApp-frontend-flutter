import 'dart:io';

import 'package:dulang_new/models/cloud_storage_result.dart';
import 'package:dulang_new/models/food.dart';
import 'package:dulang_new/pages/home.dart';
import 'package:dulang_new/services/cloud_storage_service.dart';
import 'package:dulang_new/services/food_data_service.dart';
import 'package:dulang_new/shared/toast.dart';
import 'package:dulang_new/utils/image_selector.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/buttons.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({Key key, @required this.user, this.tab})
      : super(key: key);
  final String user;
  final int tab;
  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final foodNameController = TextEditingController();

  String selectedFoodType = 'Food';

  var _foodType = ['Food', 'Drink'];
  var _currentItemSelected = 'Food';

  int qtyInput;
  int _quantity = 1;

  File _selectedImage;
  File get image => _selectedImage;

  Future<void> _getImage() async {
    var tempImage = await imageSelector.selectImage();

    setState(() {
      _selectedImage = tempImage;
      print('_image: $_selectedImage');
    });
  }

  @override
  Widget build(BuildContext context) {
    var profileID = widget.user;
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          centerTitle: true,
          leading: BackButton(
            color: darkText,
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Home(user: widget.user, tab: widget.tab))),
          ),
          title: Text("Add food or Drinks", style: h4),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 100, bottom: 100),
                        padding: EdgeInsets.only(top: 100, bottom: 50),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextField(
                              controller: foodNameController,
                              textAlign: TextAlign.center,
                              autofocus: true,
                              style: h4,
                              decoration: InputDecoration(
                                hintText: 'enter food name',
                                hintStyle: h6Grey,
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                            DropdownButton<String>(
                              items: _foodType.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Center(
                                    child: Text(dropDownStringItem, style: h6),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected;
                                  selectedFoodType = _currentItemSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 20),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 25),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text('Quantity', style: h6),
                                    margin: EdgeInsets.only(bottom: 15),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: OutlineButton(
                                          onPressed: () {
                                            setState(() {
                                              _quantity += 1;
                                            });
                                          },
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 20, right: 20),
                                        child: Text(_quantity.toString(),
                                            style: h3),
                                      ),
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: OutlineButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_quantity == 1) return;
                                              _quantity -= 1;
                                            });
                                          },
                                          child: Icon(Icons.remove),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 180,
                              child: dulangFlatBtn(
                                'Add Food',
                                () async {
                                  if (foodNameController.text != '' &&
                                      _selectedImage != null) {
                                    print(foodNameController.text);
                                    print(selectedFoodType);

                                    CloudStorageResult storageResult;
                                    storageResult =
                                        await cloudStorageService.uploadImage(
                                            imageToUpload: _selectedImage,
                                            title: foodNameController.text);

                                    await foodDataService.addFood(
                                        food: new Food(
                                            userid: profileID,
                                            name: foodNameController.text,
                                            type: selectedFoodType,
                                            imageUrl: storageResult.imageUrl,
                                            imageFileName:
                                                storageResult.imageFileName,
                                            qty: _quantity),
                                        userid: widget.user);
                                    awesomeToast('Food added');

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home(
                                                user: widget.user,
                                                tab: widget.tab)));
                                  } else {
                                    awesomeToast(
                                        'Please complete food information');
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                  color: Color.fromRGBO(0, 0, 0, .05))
                            ]),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        height: 160,
                        child: InkWell(
                          onTap: _getImage,
                          child: Container(
                            color: Colors.grey,
                            child: _selectedImage == null
                                ? Icon(FontAwesomeIcons.plus)
                                : Image.file(
                                    _selectedImage,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
