import 'package:dulang_new/models/food.dart';
import 'package:dulang_new/pages/requestMenu/request.dart';
import 'package:dulang_new/services/food_data_service.dart';
import 'package:dulang_new/shared/toast.dart';
import 'package:flutter/material.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import 'package:flutter/cupertino.dart';
import 'crowdRequest.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key key, this.user, this.tab}) : super(key: key);
  final String user;
  final int tab;
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  List<Food> _foodRequests;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          title: Text('Food Requests', style: blackBoldText),
          leading: Row(
            children: <Widget>[
              SizedBox(width: 12.0),
              Image.asset('assets/images/dulangLogoIcon.png',
                  fit: BoxFit.contain, height: 40),
            ],
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(child: Text("MY REQUESTS", style: lightBlackBoldText)),
              Tab(child: Text("CROWD REQUESTS", style: lightBlackBoldText))
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          FutureBuilder<List<Food>>(
            future: foodDataService.getMyFoodRequest(uid: widget.user),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _foodRequests = snapshot.data;
                return Container(
                    child: ListView.builder(
                  itemCount: _foodRequests.length,
                  itemBuilder: (context, index) => Request(
                    food: _foodRequests[index],
                    onLongPress: () async {
                      await foodDataService.cancelRequestFood(
                          id: _foodRequests[index].id,
                          requestedQty: _foodRequests[index].requestedQty);

                      _foodRequests.removeAt(index);

                      awesomeToast('Request Cancelled!');

                      setState(() {});
                    },
                    tab: widget.tab,
                  ),
                ));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          FutureBuilder<List<Food>>(
            future: foodDataService.getCrowdFoodRequest(uid: widget.user),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _foodRequests = snapshot.data;
                return Container(
                    child: ListView.builder(
                  itemCount: _foodRequests.length,
                  itemBuilder: (context, index) => CrowdRequest(
                    food: _foodRequests[index],
                    onLongPress: () async {
                      await foodDataService.cancelRequestFood(
                          id: _foodRequests[index].id,
                          requestedQty: _foodRequests[index].requestedQty);

                      _foodRequests.removeAt(index);

                      awesomeToast('Food request rejected!');

                      setState(() {});
                    },
                    tab: widget.tab,
                  ),
                ));
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ]),
      ),
    );
  }
}
