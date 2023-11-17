import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tfms_app/backend_config.dart';
import 'package:tfms_app/entities.dart';
import 'package:tfms_app/globals.dart';
import 'package:tfms_app/landingpage.dart';


class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneNo=TextEditingController();

  TextEditingController otp=TextEditingController();
  String? errorcode;
  Future<void> Authenticate() async {
    if (phoneNo.text.isNotEmpty && otp.text.isNotEmpty) {
      showDialog(barrierDismissible: false,
          context: context,
          builder: (context) => Center(child: CircularProgressIndicator()));
      print(phoneNo.text);
      print(otp.text);
      // phoneNo.text="8075762993";
      // otp.text="admin";

      Creds cred = await backend().login(phoneNo.text, otp.text);
      print(cred.refresh_token);
      if (cred.refresh_token == "Invalid") {
        Navigator.of(context).pop('dialog');
        setState(() {
          errorcode = "Invalid Credentials";
        });
      }
      else {
        userProfile = await backend().getProfile(cred.access_token);
        FlutterSecureStorage().write(key: "login_creds",
            value: jsonEncode(
                {"refresh": cred.refresh_token, "access": cred.access_token}));
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => LandingPage(creds: cred)), (
                Route<dynamic> route) => false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(child: Image(height:MediaQuery.of(context).size.height*0.2,image: AssetImage('assets/logo.webp'),),),
            const SizedBox(height: 50,),
            SizedBox(width:MediaQuery.of(context).size.width*0.8,child: TextFormField(controller: phoneNo,decoration:InputDecoration(errorText:errorcode,hintText:"Phone Number" ),)),
            const SizedBox(height: 30,),
            SizedBox(width:MediaQuery.of(context).size.width*0.8,child: TextFormField(obscureText:true,controller: otp,decoration:InputDecoration(errorText:errorcode,hintText:"OTP" ),)),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: Authenticate, child: SizedBox(width:80,height: 40,child: Center(child: Text("Login"))))



          ],
        ),
      ),
    );
  }
}

InputDecoration textBoxDecoration({String? error})=>InputDecoration(errorText:error,enabledBorder: OutlineInputBorder(),focusedBorder: OutlineInputBorder());