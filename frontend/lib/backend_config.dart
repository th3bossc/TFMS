

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

  payFine(String authToken,String paymentMethod,int fineId) async{
    Uri uri=Uri.parse(url+"/fines/pay/${fineId}");
    http.Response response=await http.post(uri,headers: {"Authorization":"JWT $authToken"},body:{"payment_method":paymentMethod.toLowerCase()});
    // Map<String,dynamic> data=jsonDecode(response.body);
    // print(response.body);
    // if(data["message"]=="fine paied successfully"){
    //   return 1;
    // }
    // else{
    //   return 0;
    // }

  }

  Future<List<Transactions>> getTransactions(String authToken) async {
    Uri uri=Uri.parse(url+"/fines/transactions/");
    // print(authToken);
    http.Response response=await http.get(uri,headers: {"Authorization":"JWT ${authToken}"});
    List<dynamic> data=jsonDecode(response.body);
    // print(data);
    // String data=response.body;
    // print(jsonDecode(response.body)[0]);
    // List<Map<String,dynamic>> responseList=[];
    List<Transactions> transactionsList=[];
    for(int i=0;i<data.length;i++){
      // print(data[i]);
      transactionsList.add(Transactions.toTransactions(data[i]));
    }
    print(transactionsList);
    return transactionsList;
    // print(finesList);
    // print(responseList);

    // Map<String,dynamic> data=jsonDecode(response.body);
    // print(data);

  }

  Future<Transactions> getTransaction(String authToken,int transId) async{
    Uri uri=Uri.parse(url+"/fines/transactions/${transId}");
    http.Response response=await http.get(uri,headers: {"Authorization":"JWT ${authToken}"});
    Map<String,dynamic> data=jsonDecode(response.body);
    print(data);
    return Transactions.toTransactions(data);
  }

  Future<Profile> getProfile(String authToken) async{
    Uri uri=Uri.parse(url+"/users/profile");
    http.Response response=await http.get(uri,headers: {"Authorization":"JWT ${authToken}"});
    Map<String,dynamic> data=jsonDecode(response.body);
    print(data);
    return Profile.toProfile(data);
  }

  static updateProfile(String authToken,String phoneNo,String fName,String lName,String email,double salary) async {
    Uri uri=Uri.parse(url+"/users/profile");
    print(salary);
    http.Response response=await http.post(uri,headers: {"Authorization":"JWT ${authToken}"},body: {"phone_no":phoneNo,"first_name":fName,"last_name":lName,"email":email,"salary":salary});
    print(response.body);
    // Map<String,dynamic> data=jsonDecode(response.body);
    // print(data["message"]);
  }



}