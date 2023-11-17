import 'package:flutter/cupertino.dart';

class Creds{
  Creds({required this.refresh_token,required this.access_token});
  String refresh_token;
  String access_token;

  static toCreds(Map<String,dynamic> data){
    return Creds(refresh_token: data["refresh"], access_token: data["access"]);
  }
  static nullCreds(){
    return Creds(refresh_token: "", access_token: "");
  }
}

class Fine{
  Fine({required this.issueId,required this.dateIssued,required this.fineName,required this.status,required this.deadLine,required this.fineAmount,required this.vehicleNo,required this.fineDesc});

  int issueId;
  String dateIssued;
  String fineName;
  String status;
  String deadLine;
  double fineAmount;
  String vehicleNo;
  String fineDesc;
  static toFine(Map<String,dynamic> data){
    return Fine(issueId:data["issue_id"], dateIssued: data["date_issued"], fineName: data["fine_name"], status: data["status"],
        deadLine:data["deadline"], fineAmount: data["fine_amount"],vehicleNo: data["vehicle_issued_to"]["reg_no"],fineDesc:data["fine_desc"] );

  }
  static nullFine(){
    return Fine(issueId: 0, dateIssued: "", fineName: "", status: "", deadLine: "", fineAmount: 0.0,vehicleNo: "",fineDesc: "");
  }


}

class Transactions{
  int transId;
  String datePaid;
  double amount;
  String paymentMethod;
  String fineType;

  Transactions({required this.transId,required this.datePaid,required this.amount,required this.paymentMethod,required this.fineType});
  
  static toTransactions(Map<String,dynamic> data){
    return Transactions(transId: data["transaction_id"], datePaid: data["date_paid"], amount: data["amount"], paymentMethod: data["payment_method"],fineType:data["fine_type"]);
  }
}

class Vehicle{
  String regNo;
  String vehicleType;
  String color;
  String vehicleCompany;
  String vehicleModel;
  String owner;

  Vehicle({required this.regNo,required this.vehicleType,required this.color,required this.vehicleCompany,required this.vehicleModel,required this.owner});

  static toVehicles(Map<String,dynamic> data){
    return Vehicle(regNo: data["reg_no"], vehicleType: data["vehicle_type"], color:data["color"], vehicleCompany:data["vehicle_company"], vehicleModel: data["vehicle_model"], owner: data["owner"]);
  }

}

class Profile{
  String aadharNo;
  String phoneNo;
  String licenseNo;
  String firstName;
  String lastName;
  String email;
  double salary;
  List<Vehicle> vehicles;
  Profile({required this.aadharNo,required this.phoneNo,required this.licenseNo,required this.firstName,required this.lastName,required this.email,required this.salary,required this.vehicles});

  static toProfile(Map<String,dynamic> data){
    List<Vehicle> vehicleList=[];
    List vehiclesFromData=data["vehicles"];
    for(int i=0;i<vehiclesFromData.length;i++){
      vehicleList.add(Vehicle.toVehicles(vehiclesFromData[i]));
    }
    return Profile(aadharNo:data["aadhar_no"], phoneNo: data["phone_no"], licenseNo: data["license_no"], firstName: data["first_name"], lastName: data["last_name"], email: data["email"], salary: data["salary"], vehicles: vehicleList);
  }

}

