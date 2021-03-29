import 'package:dulang_new/shared/styles.dart';
import 'package:flutter/material.dart';
import '../shared/icons.dart';
import './colors.dart';

FlatButton dulangFlatBtn(String text, onPressed) {
  return FlatButton(
    onPressed: onPressed,
    child: Text(text),
    textColor: white,
    color: primaryColor,
    disabledColor: grey,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
}

OutlineButton dulangOutlineBtn(String text, onPressed) {
  return OutlineButton(
    onPressed: onPressed,
    child: Text(text),
    textColor: primaryColor,
    highlightedBorderColor: highlightColor,
    borderSide: BorderSide(color: primaryColor),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  );
}

MaterialButton dulangMatButton(String text, onPressed) {
  return MaterialButton(
    onPressed: onPressed,
    color: Colors.black87,
    child: Text(text, style: whiteBoldText),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
  );
}

IconButton acceptButton(onPressed) {
  return IconButton(
    icon: Icon(Dulang.checkmark_cicle, size: 40.0, color: Colors.green),
    tooltip: 'Accept food request',
    onPressed: onPressed,
  );
}

IconButton waitingButton(onPressed) {
  return IconButton(
    icon: Icon(Dulang.clock, size: 40.0, color: Colors.green),
    tooltip: 'Waiting for accept',
    onPressed: onPressed,
  );
}

Container logoutButton(String text, onPressed) {
  return Container(
    height: 40.0,
    color: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(color: grey, style: BorderStyle.solid, width: 1.0),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6.0)),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(text, style: greyBoldText),
        ),
      ),
    ),
  );
}