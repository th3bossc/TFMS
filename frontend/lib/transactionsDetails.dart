import 'package:flutter/material.dart';
import 'package:tfms_app/entities.dart';

import 'globals.dart';
import 'landingpage.dart';

class TransactionDetails extends StatefulWidget {
  TransactionDetails({super.key,required this.authToken,required this.transItem});
  Creds authToken=Creds.nullCreds();
  Transactions transItem;

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context,widget.authToken),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 30,bottom: 20),
        child: IconButton(splashRadius:0.2,onPressed: () {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LandingPage(creds:widget.authToken)));
        }, icon: Icon(Icons.home,color: textColor3,size: 40,shadows: [Shadow(color: textColor1,blurRadius: 100)],),

        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            transDetailsCard(trans: widget.transItem,),
          ],
        ),
      ),
    );
  }
}

class transDetailsCard extends StatelessWidget {
  transDetailsCard({super.key,required this.trans});
  Transactions trans;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(child: Padding(
        padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.25),
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
                      Text("Fine issued for",style: textTitleStyle,),
                      Spacer(),
                      Flexible(child: Text(trans.fineType,style: textContentStyle,textAlign: TextAlign.end,)),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Transaction ID",style: textTitleStyle,),
                      Spacer(),
                      Text(trans.transId.toString(),style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Issued on",style: textTitleStyle,),
                      Spacer(),
                      Text(trans.datePaid.substring(0,10),style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Payment Method",style: textTitleStyle,),
                      Spacer(),
                      Text(trans.paymentMethod.toUpperCase(),style: textContentStyle,),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text("Transaction Amount",style: textTitleStyle,),
                      Spacer(),
                      Text(trans.amount.toString(),style: textContentStyle,),
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