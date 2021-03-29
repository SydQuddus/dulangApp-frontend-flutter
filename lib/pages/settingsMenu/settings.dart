import 'package:cached_network_image/cached_network_image.dart';
import 'package:dulang_new/pages/initialScreen/login.dart';
import 'package:dulang_new/shared/buttons.dart';
import 'package:dulang_new/shared/styles.dart';
import 'package:dulang_new/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'editPassword.dart';
import 'editProfile.dart';
import 'editAddress.dart';

class Settings extends StatefulWidget {
  const Settings({Key key, this.user, this.tab}) : super(key: key);
  final String user;
  final int tab;
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('Settings', style: blackBoldText),
        leading: Row(
          children: <Widget>[
            SizedBox(width: 12.0),
            Image.asset('assets/images/dulangLogoIcon.png',
                fit: BoxFit.contain, height: 40),
          ],
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('users')
            .document(widget.user)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              return SingleChildScrollView(
                //rightclick then wrap with container(column) tukar jadi Stack
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 0,
                      color: bgColor,
                      child: ListTile(
                        title: FittedBox(
                          child: Text(
                            snapshot.data['name'],
                            style: profileNameStyle,
                          ),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: snapshot.data['imageUrl'] != null
                              ? CachedNetworkImage(
                                  imageUrl: snapshot.data['imageUrl'],
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              : Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.blue,
                                  child: Icon(
                                    FontAwesomeIcons.user,
                                    color: black,
                                  )),
                        ),
                        trailing: IconButton(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                        user: widget.user,
                                        tab: widget.tab,
                                      ))),
                          icon: Icon(
                            Icons.edit,
                            color: black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.lock_outline,
                              color: primaryColor,
                            ),
                            title: Text("Change Password", style: blackText),
                            trailing: IconButton(
                              onPressed: () {},
                              // => Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => EditPassword())),
                              icon: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ), //ListTile
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ), //rightclickcontainer extract local varible (_buildDivider)
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey.shade400,
                          ), //Container
                          ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: primaryColor,
                            ),
                            title: Text("Update Location", style: blackText),
                            trailing: IconButton(
                              onPressed: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditAdress(
                                            user: widget.user,
                                            tab: widget.tab,
                                          ))),
                              icon: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ), //rightclickcontainer extract local varible (_buildDivider)
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.grey.shade400,
                          ), //Container
                          ListTile(
                            leading: Icon(
                              Icons.history,
                              color: primaryColor,
                            ),
                            title: Text("Donation History", style: blackText),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ), //ListTile
                        ], // <widget>[]
                      ), //Column
                    ), //Card
                    const SizedBox(height: 20.0),
                    Text(
                      "Notification Settings",
                      style: settingSectionStyle,
                    ), //TextStyle //Text
                    SwitchListTile(
                      dense: true,
                      activeColor: primaryColor,
                      contentPadding: const EdgeInsets.all(0),
                      value: true,
                      title: Text(
                        "Received notifications",
                        style: blackBoldText,
                      ),
                      onChanged: (val) {},
                    ), //SwitchListTile
                    SwitchListTile(
                      dense: true,
                      activeColor: primaryColor,
                      contentPadding: const EdgeInsets.all(0),
                      value: true,
                      title: Text(
                        "Received newsletter",
                        style: blackBoldText,
                      ),
                      onChanged: (val) {},
                    ), //SwitchListTile
                    SwitchListTile(
                      dense: true,
                      activeColor: primaryColor,
                      contentPadding: const EdgeInsets.all(0),
                      value: false,
                      title: Text(
                        "Email Notification",
                        style: blackBoldText,
                      ),
                      onChanged: (val) {},
                    ),
                    const SizedBox(height: 20.0),
                    Text("General Settings", style: settingSectionStyle),
                    //TextStyle //Text
                    SwitchListTile(
                      dense: true,
                      activeColor: primaryColor,
                      contentPadding: const EdgeInsets.all(0),
                      value: false,
                      title: Text(
                        "Data Saver",
                        style: blackBoldText,
                      ),
                      onChanged: (val) {},
                    ), //SwitchListTile
                    SwitchListTile(
                      dense: true,
                      activeColor: primaryColor,
                      contentPadding: const EdgeInsets.all(0),
                      value: true,
                      title: Text(
                        "Location",
                        style: blackBoldText,
                      ),
                      onChanged: (val) {},
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "About",
                      style: settingSectionStyle,
                    ),
                    const SizedBox(height: 13.0),
                    Text(
                      "Version Alpha 1.0",
                      style: blackText,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "Released 11 March 2020",
                      style: greyText,
                    ),
                    const SizedBox(height: 60.0),
                    logoutButton("Log Out", signOut),
                    const SizedBox(height: 40.0),
                    //SwitchListTile
                  ],
                  //<widget>[]
                ), //Column
              );
          }
        },
      ),
    );
  }

  Future<void> signOut() async {
    try {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
