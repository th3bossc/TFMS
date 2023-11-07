import 'package:flutter/material.dart';
import 'package:tfms_app/backend_config.dart';
import 'package:tfms_app/fineDetails.dart';

import 'entities.dart';
import 'globals.dart';

// String refreshToken="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwMDA3MTcwMSwiaWF0IjoxNjk5MjA3NzAxLCJqdGkiOiIzYTQwNDg0NDAyMTU0ZTVmYjAzNDcyNzVkN2I0YWNkYiIsInVzZXJfaWQiOiIxMjM0MTIzNCJ9.kSTq1Q0y05gQhNPiq0CyLAYWwtCU7k9yAh5FA3Ry3eI";


ValueNotifier<double> amount=ValueNotifier(0);

class Home extends StatelessWidget {
  Home({super.key,required this.creds});
  Creds creds;



  @override

  Widget build(BuildContext context) {
    return Column(
      children: [

        Material(

          elevation: 4,
          child: Column(
            children: [
              ValueListenableBuilder(
                
                valueListenable: amount,
                builder: (context,double value,child){
                  return SizedBox(
                      height:MediaQuery.of(context).size.height*0.3,
                      child: totalCard(value));}

              ),
              SizedBox(height: 30,),
              Container(decoration:BoxDecoration(border: Border(bottom: BorderSide(width: 2,color:textColor1))),
    child: Text("Active Fines",style: TextStyle(color:textColor1 ,fontSize: 20,fontWeight: FontWeight.w500),)),
              SizedBox(height: 20,),
            ],
          ),
        ),
        FineCard(auth_token:creds.access_token),



      ],
    );
  }
}

Widget totalCard(double Amount){

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Card(
      elevation: 10,
      surfaceTintColor: Colors.white,
      color: cardColor,
      child: Row(

        children: [
          Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:30),
                Text("Amount Due:",style: TextStyle(fontSize: 20,color:textColor2,fontWeight: FontWeight.w500)),
                SizedBox(height:5),
                // SizedBox(width: 5),
                Text(Amount.toString(),style: TextStyle(fontSize: 45,color:textColor2,fontWeight: FontWeight.w600))
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20,20,0,20),
            child: SizedBox(height:140,child: Image(image: AssetImage('assets/logo.webp'),color: cardColor,colorBlendMode: BlendMode.multiply,))),

        ],
      ),

    ),
  );
}

class FineCard extends StatefulWidget {
  FineCard({super.key,required this.auth_token});
  String auth_token="";
  @override
  State<FineCard> createState() => _FineCardState();
}

class _FineCardState extends State<FineCard> {
  List<Fine> fines=[];
  Future<void> refresh() async {
    fines=await backend().getFines(widget.auth_token);
    double totAmount=0;
    for(int i=0;i<fines.length;i++){
      totAmount+=fines[i].fineAmount;
    }
    amount.value=totAmount;
    // fines=await backend().getFines(refreshToken);  // HARD CODED
    setState(() {});

  }
  @override

  void initState(){
    super.initState();
    refresh();
  }
  Widget build(BuildContext context) {

    return Column(
      children: [
        SizedBox(height: 10,),
        ListView.builder(
          shrinkWrap: true,
          itemCount: fines.length,
            itemBuilder: (context,index){
            Fine fineItem=fines[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(10,0,10,10),
              child: InkWell(
                onTap: () async {
                  Fine selectedFine=await backend().getFine(widget.auth_token, fineItem.issueId);
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>FineDetails(authToken:widget.auth_token,fineItem:selectedFine)));
                },
                child: Card(
                  color: cardColor,
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
                            children: [Text(fineItem.fineName,style: TextStyle(fontSize: 20,color:textColor1),),
                              SizedBox(height: 5),
                              Text(fineItem.dateIssued.substring(0,10),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),)],
                          ),
                          Spacer(),
                          Text(fineItem.fineAmount.toString(),style: TextStyle(fontSize: 20,fontWeight:FontWeight.w400,color: textColor1),)

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
            }),
      ],
    );
  }
}