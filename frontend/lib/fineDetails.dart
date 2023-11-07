import 'package:flutter/material.dart';
import 'package:tfms_app/globals.dart';
import 'package:tfms_app/landingpage.dart';

import 'backend_config.dart';
import 'entities.dart';



class FineDetails extends StatefulWidget {
  FineDetails({super.key,required this.authToken,required this.fineItem});
  String authToken;
  Fine fineItem;

  @override
  State<FineDetails> createState() => _FineDetailsState();
}

class _FineDetailsState extends State<FineDetails> {

  // Fine fine=Fine.nullFine();

  // void getFineItem() async {
  //   fine=await backend().getFine(widget.authToken, widget.fineItem);
  //   setState(() {});
  //
  // }

  @override
  // void initState() {
  //   super.initState();
  //   getFineItem();
  //
  // }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appbar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailsCard(fine: widget.fineItem,),
            SizedBox(height: 40,),
            Buttons(fine:widget.fineItem),
          ],
        ),
      ),
    );
  }
}


class DetailsCard extends StatelessWidget {
  DetailsCard({super.key,required this.fine});
  Fine fine;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Card(
          color: cardColor,
          surfaceTintColor: Colors.white,
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text(fine.fineName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text("Issued on",style: textTitleStyle,),
                      Spacer(),
                      Text(fine.dateIssued.substring(0,10),style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Due Date",style: textTitleStyle,),
                      Spacer(),
                      Text(fine.deadLine.substring(0,10),style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Issued to",style: textTitleStyle,),
                      Spacer(),
                      Text("",style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Status",style: textTitleStyle,),
                      Spacer(),
                      Text(fine.status.toUpperCase(),style:(fine.status=="unpaid")? textUnpaidStyle:textDueStyle),
                    ],
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class Buttons extends StatelessWidget {
  Buttons({super.key,required this.fine});

  Fine fine;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: (){}, child: Center(
          child: Container(
            color: textColor3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("PAY",style: TextStyle(color: Colors.white,fontSize: 15),),
                  SizedBox(width: 15,),

                  // VerticalDivider(color: Colors.white,thickness: 2,),
                  SizedBox(width: 15,),
                  Text(fine.fineAmount.toString(),style: TextStyle(color: Colors.white,fontSize: 15),)
                ],
              ),
            ),
          ),
        )),
         SizedBox(height: 40),
         Visibility(
           //visible: (fine.status=="overdue"),  // SETTING VISIBILITY
           child: TextButton(onPressed: (){}, child: Center(
            child: Container(
              color: textColor3,
              child: const Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("EXTEND DEADLINE",style: TextStyle(color: Colors.white,fontSize: 15),),


                    // VerticalDivider(color: Colors.white,thickness: 2,),

                  ],
                ),
              ),
            ),
        )),
         ),
      ],
    );
  }
}

