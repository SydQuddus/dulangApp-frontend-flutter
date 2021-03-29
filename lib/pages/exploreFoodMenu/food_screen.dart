import 'package:dulang_new/models/food.dart';
import 'package:dulang_new/services/food_data_service.dart';
import 'package:flutter/material.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/icons.dart';
import '../../shared/partials.dart';
import 'foodRequest_screen.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key key, this.user, this.tab}) : super(key: key);
  final String user;
  final int tab;
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _tabs = [
      StoreTab(user: widget.user, tab: widget.tab),
    ]; 

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('DULANG', style: blackBoldText),
        leading: Row(
          children: <Widget>[
            SizedBox(width: 12.0),
            Image.asset('assets/images/dulangLogoIcon.png',
                fit: BoxFit.contain, height: 40),
          ],
        ),
      ),
      body: _tabs[_selectedIndex],
    );
  }
}

class StoreTab extends StatefulWidget {
  final String user;
  final int tab;
  const StoreTab({Key key, this.user, this.tab}) : super(key: key);
  @override
  _StoreTabState createState() => _StoreTabState();
}

class _StoreTabState extends State<StoreTab> {
  List<Food> _foods;


  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      headerTopCategories(),
      FutureBuilder<List<Food>>(
        future: foodDataService.getFood(type: 'food'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _foods = snapshot.data;
            return deals(
              'Food for grab!',
              onViewMore: () {},
              items: _foods
                  .map(
                    (food) => FoodItem(
                      food: food,
                      onTapped: () async {
                        await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return new FoodRequestScreen(
                                food: food, user: widget.user, tab: widget.tab);
                          }),
                        );
                      },
                      imgWidth: 250,
                    ),
                  )
                  .toList(),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      FutureBuilder<List<Food>>(
        future: foodDataService.getFood(type: 'drink'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _foods = snapshot.data;
            return deals(
              'Drinks for grab!',
              onViewMore: () {},
              items: _foods
                  .map((food) => FoodItem(
                        food: food,
                        onTapped: () async {
                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return new FoodRequestScreen(
                                    food: food,
                                    user: widget.user,
                                    tab: widget.tab);
                              },
                            ),
                          );
                        },
                        imgWidth: 250,
                      ))
                  .toList(),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ]);
  }
}

Widget sectionHeader(String headerTitle, {onViewMore}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 15, top: 10),
        child: Text(headerTitle, style: h4),
      ),
      Container(
        margin: EdgeInsets.only(left: 15, top: 2),
        child: FlatButton(
          onPressed: onViewMore,
          child: Text('View all ›', style: contrastText),
        ),
      )
    ],
  );
}

// wrap the horizontal listview inside a sizedBox..
Widget headerTopCategories() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      sectionHeader('All Categories', onViewMore: () {}),
      SizedBox(
        height: 130,
        child: ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: <Widget>[
            headerCategoryItem('Cooked', Dulang.food, onPressed: () {}),
            headerCategoryItem('Frozen', Dulang.diamond, onPressed: () {}),
            headerCategoryItem('Snacks', Dulang.coffee_cup, onPressed: () {}),
            headerCategoryItem('Dessert', Dulang.poop, onPressed: () {}),
            headerCategoryItem('Fruits', Dulang.leaf, onPressed: () {}),
            headerCategoryItem('Vegetables', Dulang.leaf, onPressed: () {}),
          ],
        ),
      )
    ],
  );
}

Widget headerCategoryItem(String name, IconData icon, {onPressed}) {
  return Container(
    margin: EdgeInsets.only(left: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(bottom: 10),
            width: 86,
            height: 86,
            child: FloatingActionButton(
              shape: CircleBorder(),
              heroTag: name,
              onPressed: onPressed,
              backgroundColor: white,
              child: Icon(icon, size: 35, color: Colors.black87),
            )),
        Text(name + ' ›', style: categoryText)
      ],
    ),
  );
}

Widget deals(String dealTitle, {onViewMore, List<Widget> items}) {
  return Container(
    margin: EdgeInsets.only(top: 5),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        sectionHeader(dealTitle, onViewMore: onViewMore),
        SizedBox(
          height: 250,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: (items != null)
                ? items
                : <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text('No items available at this moment.',
                          style: taglineText),
                    )
                  ],
          ),
        ),
        SizedBox(height: 25)
      ],
    ),
  );
}