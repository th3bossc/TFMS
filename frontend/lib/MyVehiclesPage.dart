import 'package:flutter/material.dart';
import 'package:tfms_app/globals.dart';
import 'package:tfms_app/vehicleDetails.dart';

import 'entities.dart';

Map<String,String> images={"LMV":"assets/car.jpg","MCWG":"assets/bike.jpg","MCWOG":"assets/scooter.jpg","HMV":"assets/truck.jpg"};

class Vehicles extends StatelessWidget {
  Vehicles({super.key,required creds});
  Creds creds=Creds.nullCreds();

  @override
  Widget build(BuildContext context) {
    List<Vehicle>? vehicles=userProfile?.vehicles;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20,),
        Center(
          child: Container(decoration:BoxDecoration(border: Border(bottom: BorderSide(width: 2,color:textColor1))),
              child: Text("My Vehicles",style: TextStyle(color:textColor1 ,fontSize: 20,fontWeight: FontWeight.w500),)),
        ),
        // SizedBox(height: 20,),
        SizedBox(height: 30,),

        Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: vehicles?.length,
              itemBuilder: (context,index){
                Vehicle? vehicleItem=vehicles?[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,10),
                  child: InkWell(
                    onTap: () async {
                      // Fine selectedFine=await backend().getFine(widget.creds.access_token, transItem.transId);
                      // Transactions selectedTrans=await backend().getTransaction(widget.creds.access_token, transItem.transId);
                      // Navigator.push(context, MaterialPageRoute(builder:(context)=>TransactionDetails(authToken:widget.creds,transItem:selectedTrans)));
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>VehicleDetails(authToken:creds,vehicle:vehicleItem)));

                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 3,
                      surfaceTintColor: Colors.white,
                      child: SizedBox(
                        // height: 75,

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(vehicleItem!.regNo,style: TextStyle(fontSize: 20,color:textColor1),),
                                  SizedBox(height: 5),
                                  Text(vehicleItem!.vehicleModel,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),)],
                              ),
                              Spacer(),
                              SizedBox(
                                height: 80,
                                child: Image.asset(images[vehicleItem.vehicleType]!),
                              )
                              // Text(ruppee+""+transItem.amount.toString(),style: TextStyle(fontSize: 20,fontWeight:FontWeight.w400,color: textColor1),)

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
