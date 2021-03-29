import 'package:flutter/material.dart';
import './colors.dart';

/////////TEXT STYLES////////////////

const profileNameStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 27,
    color: black,
    fontWeight: FontWeight.bold);

const requestStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 33,
    color: Color(0xffe6020a),
    fontWeight: FontWeight.bold);

const settingSectionStyle = TextStyle(
    fontSize: 20.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    color: primaryColor);

const splashStyle = TextStyle(
    fontSize: 30.0,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    color: primaryColor);

const logoWhiteStyle = TextStyle(
    fontFamily: 'Montserrat', fontSize: 21, letterSpacing: 2, color: white);
const whiteText = TextStyle(color: white, fontFamily: 'Montserrat');
const whiteBoldText = TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat');
const blackText = TextStyle(color: black, fontFamily: 'Montserrat');
const blackBoldText = TextStyle(
    color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Montserrat');
const lightBlackBoldText = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontFamily: 'Montserrat');
const greyText = TextStyle(color: grey, fontFamily: 'Montserrat');
const greyBoldText = TextStyle(
    color: grey, fontFamily: 'Montserrat', fontWeight: FontWeight.bold);
const contrastText = TextStyle(color: primaryColor, fontFamily: 'Montserrat');
const contrastTextBold = TextStyle(
    color: primaryColor, fontFamily: 'Montserrat', fontWeight: FontWeight.w600);

const h3 = TextStyle(
    color: black,
    fontSize: 23,
    fontWeight: FontWeight.w800,
    fontFamily: 'Montserrat');

const h3Grey = TextStyle(
    color: grey,
    fontSize: 23,
    fontWeight: FontWeight.w800,
    fontFamily: 'Montserrat');

const h3White = TextStyle(
    color: white,
    fontSize: 23,
    fontWeight: FontWeight.w800,
    fontFamily: 'Montserrat');

const h4Grey = TextStyle(color: grey, fontSize: 18, fontFamily: 'Montserrat');

const h4White = TextStyle(color: white, fontSize: 18, fontFamily: 'Montserrat');

const h4 = TextStyle(
    color: black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat');

const h5 = TextStyle(
    color: black,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: 'Montserrat');

const h6 = TextStyle(
    color: black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Montserrat');

    const h6Primary = TextStyle(
    color: primaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Montserrat');

const h6Grey = TextStyle(
    color: grey,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: 'Montserrat');

const priceText = TextStyle(
    color: black,
    fontSize: 19,
    fontWeight: FontWeight.w800,
    fontFamily: 'Montserrat');

const foodNameText = TextStyle(
    color: black,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    fontFamily: 'Montserrat');

const tabLinkStyle = TextStyle(fontWeight: FontWeight.w500);

const taglineText = TextStyle(color: grey, fontFamily: 'Montserrat');
const categoryText = TextStyle(
    color: Color(0xff444444),
    fontWeight: FontWeight.w700,
    fontFamily: 'Montserrat');

const inputFieldTextStyle =
    TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w500);

const inputFieldHintTextStyle =
    TextStyle(fontFamily: 'Montserrat', color: Color(0xff444444));

const inputFieldPasswordTextStyle = TextStyle(
    fontFamily: 'Montserrat', fontWeight: FontWeight.w500, letterSpacing: 3);

const inputFieldHintPaswordTextStyle = TextStyle(
    fontFamily: 'Montserrat', color: Color(0xff444444), letterSpacing: 2);

///////////////////////////////////
/// BOX DECORATION STYLES
//////////////////////////////////

const authPlateDecoration = BoxDecoration(
    color: white,
    boxShadow: [
      BoxShadow(
          color: Color.fromRGBO(0, 0, 0, .1),
          blurRadius: 10,
          spreadRadius: 5,
          offset: Offset(0, 1))
    ],
    borderRadius: BorderRadiusDirectional.only(
        bottomEnd: Radius.circular(20), bottomStart: Radius.circular(20)));

/////////////////////////////////////
/// INPUT FIELD DECORATION STYLES
////////////////////////////////////

const inputFieldFocusedBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6)),
    borderSide: BorderSide(
      color: primaryColor,
    ));

const inputFieldDefaultBorderStyle = OutlineInputBorder(
    gapPadding: 0, borderRadius: BorderRadius.all(Radius.circular(6)));
