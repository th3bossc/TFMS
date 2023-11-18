import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tfms_app/entities.dart';
import 'package:tfms_app/landingpage.dart';
import 'package:tfms_app/paymentpage.dart';

import 'backend_config.dart';
import 'globals.dart';
import 'login_screen.dart';

bool logging=true;
String? data=null;
Creds creds=Creds.nullCreds();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterSecureStorage().write(key: "login_creds",value: jsonEncode(
          {"refresh": "cred.refresh_token", "access": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzAwMDY4NzE5LCJpYXQiOjE2OTk5ODIzMTksImp0aSI6IjM1NWE2ZmQyNGU2YzQyMWY4OTZlOGYzNjk0NDgxNjVkIiwidXNlcl9pZCI6IjEyMzQxMjM0In0.1oQZcAOsDfig-3Eff-bOcrswHIe9vxmCDajte09r4tg"}));
  data=await FlutterSecureStorage().read(key:"login_creds");
  if(data!=null){
    creds=Creds.toCreds(jsonDecode(data!));
    userProfile=await backend().getProfile(creds.access_token);
    if(userProfile==null){
      data=null;
    }
  }
  print(data);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: PaymentGateway(fine: Fine.nullFine()),
      // home: LandingPage(creds: Creds(refresh_token: "", access_token: "")),

      home:data!=null?LandingPage(creds:creds,):Login(),
    );
  }
}

