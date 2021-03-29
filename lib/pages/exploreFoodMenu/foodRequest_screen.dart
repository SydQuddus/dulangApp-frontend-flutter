import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dulang_new/services/food_data_service.dart';
import 'package:dulang_new/shared/toast.dart';
import 'package:flutter/material.dart';
import '../../models/food.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/partials.dart';
import '../../shared/buttons.dart';

import '../home.dart';

class FoodRequestScreen extends StatefulWidget {
  final int tab;
  final String user;
  final Food food;

  FoodRequestScreen(
      {@required this.food, @required this.user, @required this.tab});

  @override
  _FoodRequestScreenState createState() => _FoodRequestScreenState();
}

class _FoodRequestScreenState extends State<FoodRequestScreen> {
  int _quantity = 1;

  dynamic userData;

  Future<dynamic> getData() async {
    final DocumentReference document =
        Firestore.instance.collection("users").document(widget.user);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        userData = snapshot.data;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
                    builder: (context) => Home(user: widget.user, tab: 0))),
          ),
          title: Text(widget.food.name, style: h4),
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
                            Text("${widget.food.name}", style: h5),
                            Text("by ${widget.food.username}",
                                style: h6Primary),
                            Text("${widget.food.qty} pax", style: h3),
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
                                              if (_quantity < widget.food.qty)
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
                              child: dulangOutlineBtn('Cancel', () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home(
                                            user: widget.user,
                                            tab: widget.tab)));
                              }),
                            ),
                            Container(
                              width: 180,
                              child: dulangFlatBtn(
                                  'Request Food',
                                  (widget.food.qty > 0)
                                      ? () async {
                                          print(widget.user);
                                          if (widget.food.userid !=
                                              widget.user) {
                                            await foodDataService.requestFood(
                                                id: widget.food.id,
                                                foodRequesterID: widget.user,
                                                foodRequesterName:
                                                    userData['name'],
                                                foodRequesterLocation:
                                                    userData['location'],
                                                requestedQty: _quantity);

                                            awesomeToast('Food requested!');
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Home(
                                                        user: widget.user,
                                                        tab: 0)));
                                          } else {
                                            awesomeToast(
                                                'This food belongs to you!');
                                          }
                                        }
                                      : null),
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
                        child: FoodItem(
                          food: widget.food,
                          isProductPage: true,
                          onTapped: () {},
                          imgWidth: 250,
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
