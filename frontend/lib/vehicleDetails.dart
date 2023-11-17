import 'package:flutter/material.dart';

import 'entities.dart';
import 'globals.dart';
import 'landingpage.dart';

Map<String,String> images={"LMV":"assets/car_full.jpg","MCWG":"assets/bike_full.jpg","MCWOG":"assets/scooter_full.jpg","HMV":"assets/truck_full.jpg"};

class VehicleDetails extends StatelessWidget {
  VehicleDetails({super.key,required this.authToken,required this.vehicle});
  Creds authToken=Creds.nullCreds();
  Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context,authToken),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 30,bottom: 20),
        child: IconButton(splashRadius:0.2,onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.home,color: textColor3,size: 40,shadows: [Shadow(color: textColor1,blurRadius: 100)],),

        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            SizedBox(height:100,child: Image.asset(images[vehicle.vehicleType]!)),
            vehicleDetailsCard(vehicle: vehicle,),
          ],
        ),
      ),
    );
  }
}

class vehicleDetailsCard extends StatelessWidget {
  vehicleDetailsCard({super.key,required this.vehicle});
  Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(child: Padding(
        padding:  EdgeInsets.only(top:50),
        child: Card(
          color: cardColor,
          surfaceTintColor: Colors.white,
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: Column(

                children: [
                  SizedBox(height: 20,),
                  // Text(trans.,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  // SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Vehicle Registration Number",style: textTitleStyle,),
                      Spacer(),
                      Text(vehicle.regNo,style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Vehicle Type",style: textTitleStyle,),
                      Spacer(),
                      Text(vehicle.vehicleType,style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Manufacturer",style: textTitleStyle,),
                      Spacer(),
                      Text(vehicle.vehicleCompany,style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Model Number",style: textTitleStyle,),
                      Spacer(),
                      Text(vehicle.vehicleModel,style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Color",style: textTitleStyle,),
                      Spacer(),
                      Text(vehicle.color,style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),

                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
