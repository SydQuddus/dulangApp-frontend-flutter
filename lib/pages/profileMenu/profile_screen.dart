import 'package:cached_network_image/cached_network_image.dart';
import 'package:dulang_new/pages/home.dart';
import 'package:dulang_new/services/cloud_storage_service.dart';
import 'package:dulang_new/services/food_data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dulang_new/models/food.dart';
import 'package:dulang_new/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/styles.dart';
import '../../shared/buttons.dart';
import '../../shared/colors.dart';
import 'foodUpdate_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key, this.user, this.profileId, this.tab})
      : super(key: key);
  final String user;
  final String profileId;
  final int tab;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Food> _foods;
  final dataService = FoodDataService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        color: black,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor],
                ),
              ),
            ),

            //Top Bar Profile Info
            StreamBuilder<DocumentSnapshot>(
                stream: Firestore.instance
                    .collection('users')
                    .document(widget.user)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      return Padding(
                        padding: EdgeInsets.only(top: 64.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white60, width: 2.0),
                                  ),
                                  padding: EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: snapshot.data['imageUrl'] != null
                                        ? CachedNetworkImage(
                                            imageUrl: snapshot.data['imageUrl'],
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) => Center(
                                                child:
                                                    CircularProgressIndicator()),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )
                                        : Container(
                                            width: 60,
                                            height: 60,
                                            color: Colors.blue,
                                            child: Icon(
                                              FontAwesomeIcons.user,
                                              color: black,
                                              size: 50,
                                            )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Text(snapshot.data['name'], style: h3),
                            Text("Member since 2020", style: h4White),
                            SizedBox(height: 10.0),
                            dulangMatButton(snapshot.data['location'], () {}),
                          ],
                        ),
                      );
                  }
                }),
            //End of Profile Top Bar Info

            Container(
              margin: EdgeInsets.only(top: 350.0),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
            ),
            FutureBuilder<List<Food>>(
                future: dataService.getFoodByUser(uid: widget.user),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _foods = snapshot.data;
                    return Container(
                      margin: EdgeInsets.only(top: 250.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.builder(
                          itemCount: _foods.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () async {
                              await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return new FoodUpdateScreen(
                                    user: widget.user,
                                    food: _foods[index],
                                    onDelete: () async {
                                      await cloudStorageService.deleteImage(
                                          _foods[index].imageFileName);
                                      await foodDataService.deleteFood(
                                          id: _foods[index].id);
                                      awesomeToast('Food removed');
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home(
                                                  user: widget.user, tab: 2)));
                                    },
                                    tab: widget.tab,
                                  );
                                }),
                              );
                            },
                            child: Card(
                              child: Container(
                                margin: EdgeInsets.all(4.0),
                                color: white,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 100,
                                      width: 160,
                                      child: CachedNetworkImage(
                                        imageUrl: _foods[index].imageUrl,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    FittedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(_foods[index].name,
                                              style: blackBoldText),
                                          Text(
                                              " | ${_foods[index].qty.toString()} pax",
                                              style: blackBoldText),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                        ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          ],
        ),
      ),
    );
  }
}
