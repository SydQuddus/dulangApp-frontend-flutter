import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dulang_new/services/food_data_service.dart';
import 'package:dulang_new/shared/icons.dart';
import 'package:dulang_new/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:dulang_new/models/food.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';

class Request extends StatefulWidget {
  final Food food;
  final Function onLongPress;
  final String user;
  final int tab;
  Request({this.food, this.onLongPress, this.user, @required this.tab});

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  bool accepted = false;

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
    return GestureDetector(
      onLongPress: widget.onLongPress,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: new FittedBox(
            child: Material(
                color: white,
                elevation: 8.0,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Color(0x802196F3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 250,
                      height: 200,
                      child: ClipRRect(
                          borderRadius: new BorderRadius.circular(24.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.food.imageUrl,
                            fit: BoxFit.fill,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )

                        
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                      child: Text(
                                          "${widget.food.name} x${widget.food.requestedQty}",
                                          style: requestStyle)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                          child: Text(
                                        widget.food.username,
                                        style: h3,
                                      )),
                                      Container(
                                          child: Text(" \u00B7 0.5 km",
                                              style: h3Grey)),
                                    ],
                                  )),
                                ),
                                Container(
                                    child: Text(
                                  "${widget.food.type} \u00B7 ${widget.food.foodLocation}",
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                )),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 55.0),
                        IconButton(
                          icon: Icon(Dulang.hand,
                              size: widget.food.requestCollected ? 50.0 : 40.0,
                              color: widget.food.requestCollected
                                  ? Colors.teal
                                  : Colors.grey),
                          tooltip: 'Collect food',
                          onPressed: () async {
                            if (widget.food.requestAccepted) {
                              await foodDataService.collectFood(
                                  id: widget.food.id);

                              setState(() {
                                awesomeToast('Food Collected!');
                                widget.food.requestCollected = true;
                              });
                            } else {
                              setState(() {
                                awesomeToast(
                                    'Food request is not yet accepted!');
                              });
                            }
                          },
                        ),
                        SizedBox(width: 25.0)
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
