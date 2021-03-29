import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/food.dart';
import '../shared/colors.dart';
import '../shared/styles.dart';

class FoodItem extends StatelessWidget {
  final Food food;
  final isProductPage;
  final Function onTapped;
  final double imgWidth;

  FoodItem(
      {this.food, this.imgWidth, this.onTapped, this.isProductPage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      // color: Colors.red,
      margin: EdgeInsets.only(left: 20),
      child: Stack(
        children: <Widget>[
          Container(
              width: 180,
              height: 180,
              child: RaisedButton(
                color: white,
                elevation: (isProductPage) ? 20 : 12,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: onTapped,
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: food.name,
                  child: CachedNetworkImage(
                    imageUrl: food.imageUrl,
                    width: (imgWidth != null) ? imgWidth : 100,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            child: (!isProductPage)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(food.name, style: foodNameText),
                      Text("${food.qty} pax", style: priceText),
                    ],
                  )
                : Text(' '),
          ),
        ],
      ),
    );
  }
}
