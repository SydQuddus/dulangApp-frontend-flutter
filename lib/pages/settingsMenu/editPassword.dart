import 'package:flutter/material.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/buttons.dart';

//we are not implementing this feature yet.

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  TextEditingController currPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

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
          ),
          title: Text("Change Password", style: h4),
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
                              controller: currPassController,
                              textAlign: TextAlign.center,
                              autofocus: true,
                              // initialValue: '',
                              style: h4,
                              decoration: InputDecoration(
                                hintText: 'enter current password',
                                hintStyle: h6Grey,
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                            TextField(
                              controller: newPassController,
                              textAlign: TextAlign.center,
                              autofocus: true,
                              // initialValue: '',
                              style: h4,
                              decoration: InputDecoration(
                                hintText: 'enter new password',
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
                                'Update Password',
                                () {
                                  // if (currPassController.text ==
                                  //     currUser.password) {
                                  //   if (newPassController.text != '') {
                                  //     currUser.password =
                                  //         newPassController.text;
                                  //     Fluttertoast.showToast(
                                  //         msg: 'Password Successfully Changed ',
                                  //         toastLength: Toast.LENGTH_SHORT,
                                  //         gravity: ToastGravity.BOTTOM,
                                  //         timeInSecForIosWeb: 1,
                                  //         backgroundColor: Colors.grey,
                                  //         textColor: Colors.white,
                                  //         fontSize: 16.0);

                                  //     Navigator.pop(context);
                                  //   } else {
                                  //     Fluttertoast.showToast(
                                  //         msg: 'Please enter new password',
                                  //         toastLength: Toast.LENGTH_SHORT,
                                  //         gravity: ToastGravity.BOTTOM,
                                  //         timeInSecForIosWeb: 1,
                                  //         backgroundColor: Colors.grey,
                                  //         textColor: Colors.white,
                                  //         fontSize: 16.0);
                                  //   }
                                  // } else {
                                  //   Fluttertoast.showToast(
                                  //       msg: 'current password incorrect',
                                  //       toastLength: Toast.LENGTH_SHORT,
                                  //       gravity: ToastGravity.BOTTOM,
                                  //       timeInSecForIosWeb: 1,
                                  //       backgroundColor: Colors.grey,
                                  //       textColor: Colors.white,
                                  //       fontSize: 16.0);
                                  // }
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
