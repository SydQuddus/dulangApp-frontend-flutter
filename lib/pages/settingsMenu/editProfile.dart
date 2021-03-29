//import 'package:dulang_new/pages/profile.dart';
//import 'package:dulang_new/models/mock_profile.dart';
import 'dart:io';

import 'package:dulang_new/models/cloud_storage_result.dart';
import 'package:dulang_new/services/cloud_storage_service.dart';
import 'package:dulang_new/services/profile_data_service.dart';
import 'package:dulang_new/shared/toast.dart';
import 'package:dulang_new/utils/image_selector.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/buttons.dart';
import '../home.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({@required this.user, @required this.tab});
  final String user;
  final int tab;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();

  File _selectedImage;
  File get image => _selectedImage;

  Future<void> _getImage() async {
    var tempImage = await imageSelector.selectImage();

    setState(() {
      _selectedImage = tempImage;
      print('_image: $_selectedImage');
    });
  }

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
          title: Text("Update Profile", style: h4),
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
                              controller: nameController,
                              textAlign: TextAlign.center,
                              autofocus: false,
                              style: h4,
                              decoration: InputDecoration(
                                hintText: 'Enter new nickname',
                                hintStyle: h6Grey,
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 20),
                            ),
                            Container(
                              width: 180,
                              child: dulangFlatBtn(
                                'Update Profile',
                                () async {
                                  if (nameController.text != '' &&
                                      image != null) {
                                    CloudStorageResult storageResult;
                                    storageResult =
                                        await cloudStorageService.uploadImage(
                                            imageToUpload: _selectedImage,
                                            title: nameController.text);

                                    await profileDataService.updateProfile(
                                      id: widget.user,
                                      name: nameController.text,
                                      imageUrl: storageResult.imageUrl,
                                      imageFileName:
                                          storageResult.imageFileName,
                                    );

                                    awesomeToast('Profile Updated');

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home(
                                                user: widget.user, tab: 3)));
                                  } else {
                                    awesomeToast(
                                        'Please complete profile information');
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: 180,
                              child: dulangOutlineBtn(
                                'Cancel',
                                () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Home(user: widget.user, tab: 0),
                                  ),
                                ),
                              ),
                            ),
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
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        height: 160,
                        child: InkWell(
                          onTap: _getImage,
                          child: Container(
                            color: Colors.grey,
                            child: _selectedImage == null
                                ? Icon(FontAwesomeIcons.plus)
                                : Image.file(
                                    _selectedImage,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
