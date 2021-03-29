import 'package:dulang_new/services/profile_data_service.dart';
import 'package:dulang_new/shared/toast.dart';
import 'package:flutter/material.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/buttons.dart';
import '../home.dart';

class EditAdress extends StatefulWidget {
  const EditAdress({@required this.user, @required this.tab});
  final String user;
  final int tab;
  @override
  _EditAdressState createState() => _EditAdressState();
}

class _EditAdressState extends State<EditAdress> {
  final locationController = TextEditingController();

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
                    builder: (context) => Home(user: widget.user, tab: 3))),
          ),
          title: Text("Update Location", style: h4),
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
                              controller: locationController,
                              textAlign: TextAlign.center,
                              autofocus: true,
                              // initialValue: '',
                              style: h4,
                              decoration: InputDecoration(
                                hintText: 'enter location',
                                hintStyle: h6Grey,
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                            Container(
                              width: 180,
                              child: dulangFlatBtn(
                                'Update Location',
                                () async {
                                  if (locationController.text != '') {
                                    await profileDataService.updateLocation(
                                      id: widget.user,
                                      location: locationController.text,
                                    );
                                    awesomeToast('Location Updated');

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home(
                                                user: widget.user, tab: 3)));
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
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
