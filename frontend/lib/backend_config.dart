import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tfms_app/entities.dart';
String url="https://th3bossc.pythonanywhere.com";

class backend{

  Future<Creds> login(String phoneNo,String pwd) async {
    Uri uri=Uri.parse(url+"/api/token/");
     http.Response response=await http.post(uri,body: {"phone_no":phoneNo,"password":pwd});
     Map<String,dynamic> data=jsonDecode(response.body);
     if(response.statusCode==401){
       return Creds(refresh_token: "Invalid", access_token: "Invalid");
     }

     return Creds.toCreds(data);
  }

  Future<List<Fine>> getFines(String authToken) async {
    Uri uri=Uri.parse(url+"/fines/");
    // print(authToken);
    http.Response response=await http.get(uri,headers: {"Authorization":"JWT ${authToken}"});
    List<dynamic> data=jsonDecode(response.body);
    // print(data);
    // String data=response.body;
    // print(jsonDecode(response.body)[0]);
    // List<Map<String,dynamic>> responseList=[];
    List<Fine> finesList=[];
    for(int i=0;i<data.length;i++){
      // print(data[i]);
      finesList.add(Fine.toFine(data[i]));
    }
    print(finesList);
    return finesList;
    // print(finesList);
    // print(responseList);

    // Map<String,dynamic> data=jsonDecode(response.body);
    // print(data);

  }

  Future<Fine> getFine(String authToken,int fineId) async{
    Uri uri=Uri.parse(url+"/fines/${fineId}");
    http.Response response=await http.get(uri,headers: {"Authorization":"JWT ${authToken}"});
    Map<String,dynamic> data=jsonDecode(response.body);
    print(data);
    return Fine.toFine(data);
  }

}