import 'package:dulang_new/pages/requestMenu/request_screen.dart';
import 'package:flutter/material.dart';
import '../shared/colors.dart';
import '../shared/icons.dart';
import 'exploreFoodMenu/food_screen.dart';
import 'profileMenu/profile_screen.dart';
import 'settingsMenu/settings.dart';
import 'addFood_screen.dart';

class Home extends StatefulWidget {
  final String user;
  final int tab;

  const Home({Key key, this.user, this.tab}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  static String userID;
  Widget currentScreen = FoodScreen(user: userID);

  final List<Widget> screens = [
    FoodScreen(),
    RequestScreen(),
    ProfileScreen(),
    Settings(),
  ];

  @override
  void initState() {
    super.initState();
    userID = widget.user;
    //currentScreen = FoodScreen(user: userID); //problem
    currentTab = widget.tab;
    if (currentTab == 0) {
      currentScreen = FoodScreen(user: userID);
    }
    if (currentTab == 1) {
      currentScreen = RequestScreen(user: userID);
    }
    if (currentTab == 2) {
      currentScreen = ProfileScreen(user: userID);
    }
    if (currentTab == 3) {
      currentScreen = Settings(user: userID);
    }
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      //Add Button
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: primaryColor,
        onPressed: () async {
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) {
              return new AddFoodScreen(
                user: userID,
                tab: currentTab,
              );
            }),
          );
        },
      ),

      //Add Button Position
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //Bottom AppBar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = FoodScreen(
                            user: userID,
                            tab: currentTab,
                          );
                          currentTab = 0;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Dulang.food,
                            color: currentTab == 0 ? primaryColor : black),
                        Text('Food',
                            style: TextStyle(
                                color: currentTab == 0 ? primaryColor : black)),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = RequestScreen(
                            user: userID,
                            tab: currentTab,
                          );
                          currentTab = 1;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.chat,
                            color: currentTab == 1 ? primaryColor : black),
                        Text('Request',
                            style: TextStyle(
                                color: currentTab == 1 ? primaryColor : black)),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = ProfileScreen(
                            user: userID,
                            tab: currentTab,
                          );
                          currentTab = 2;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.person,
                            color: currentTab == 2 ? primaryColor : black),
                        Text('Profile',
                            style: TextStyle(
                                color: currentTab == 2 ? primaryColor : black)),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(
                        () {
                          currentScreen = Settings(
                            user: userID,
                            tab: currentTab,
                          );
                          currentTab = 3;
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.settings,
                            color: currentTab == 3 ? primaryColor : black),
                        Text('Settings',
                            style: TextStyle(
                                color: currentTab == 3 ? primaryColor : black)),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
