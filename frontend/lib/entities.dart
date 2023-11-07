import 'package:flutter/cupertino.dart';

class Creds{
  Creds({required this.refresh_token,required this.access_token});
  String refresh_token;
  String access_token;

  static toCreds(Map<String,dynamic> data){
    return Creds(refresh_token: data["refresh"], access_token: data["access"]);
  }
}

class Fine{
  Fine({required this.issueId,required this.dateIssued,required this.fineName,required this.status,required this.deadLine,required this.fineAmount});

  int issueId;
  String dateIssued;
  String fineName;
  String status;
  String deadLine;
  double fineAmount;

  static toFine(Map<String,dynamic> data){
    return Fine(issueId:data["issue_id"], dateIssued: data["date_issued"], fineName: data["fine_name"], status: data["status"],
        deadLine:data["deadline"], fineAmount: data["fine_amount"]);

  }
  static nullFine(){
    return Fine(issueId: 0, dateIssued: "", fineName: "", status: "", deadLine: "", fineAmount: 0.0);
  }


}

