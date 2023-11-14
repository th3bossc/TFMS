import 'dart:ui';

import 'package:flutter/material.dart';

import 'entities.dart';

String ruppee="\u20B9";
Color cardColor=Color.fromRGBO(255, 240, 206,1);
Color textColor1=Color.fromRGBO(1, 116, 190,1);
Color textColor2=Color.fromRGBO(255, 196, 54,1);
Color textColor3=Color.fromRGBO(12, 53, 106,1);
Color paymentColor1=Color.fromRGBO(13,148,251,1);
TextStyle textTitleStyle=TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color:textColor3 );
TextStyle textContentStyle=TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: textColor1);
TextStyle textUnpaidStyle=TextStyle(fontWeight: FontWeight.w500,fontSize: 15,color: Colors.redAccent);
TextStyle textDueStyle=TextStyle(fontWeight: FontWeight.w700,fontSize: 15,color:Colors.red);


Profile? userProfile;