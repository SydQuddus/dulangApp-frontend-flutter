import 'package:cached_network_image/cached_network_image.dart';
import 'package:dulang_new/services/food_data_service.dart';
import 'package:dulang_new/shared/icons.dart';
import 'package:dulang_new/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:dulang_new/models/food.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';

class CrowdRequest extends StatefulWidget {
  final Food food;
  final Function onLongPress;
  final String user;
  final int tab;
  CrowdRequest({this.food, this.onLongPress, this.user, @required this.tab});

  @override
  _CrowdRequestState createState() => _CrowdRequestState();
}

class _CrowdRequestState extends State<CrowdRequest> {
  bool accepted = false;
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
                                        widget.food.foodRequesterName,
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
                                  "${widget.food.type} \u00B7 ${widget.food.foodRequesterLocation}",
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
                          icon: Icon(Dulang.checkmark_cicle,
                              size: widget.food.requestAccepted ? 50.0 : 40.0,
                              color: widget.food.requestAccepted
                                  ? Colors.teal
                                  : Colors.grey),
                          tooltip: 'Accept food request',
                          onPressed: () async {
                            await foodDataService.acceptFoodRequest(
                                id: widget.food.id);

                            setState(() {
                              widget.food.requestAccepted = true;
                              awesomeToast('Food request accepted!');
                            });
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
