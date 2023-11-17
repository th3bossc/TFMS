import 'package:flutter/material.dart';
import 'package:tfms_app/transactionsDetails.dart';

import 'backend_config.dart';
import 'entities.dart';
import 'globals.dart';
class TransactionsPage extends StatefulWidget {
  TransactionsPage({super.key,required this.creds});
  Creds creds;
  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {

  List<Transactions> trans=[];
  Future<void> refresh() async {
    Future.delayed(Duration.zero,(){showDialog(barrierDismissible:false,context: context, builder: (context)=>Center(child: CircularProgressIndicator()));});
    // showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator()));
    trans=await backend().getTransactions(widget.creds.access_token);
    Navigator.of(context).pop('dialog');
    if(this.mounted) {
      setState(() {});

    }



  }

  @override
  void initState(){
    super.initState();
    // showDialog(context: context, builder: (context)=>Center(child: CircularProgressIndicator()));
    refresh();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Container(decoration:BoxDecoration(border: Border(bottom: BorderSide(width: 2,color:textColor1))),
            child: Text("My Transactions",style: TextStyle(color:textColor1 ,fontSize: 20,fontWeight: FontWeight.w500),)),
        // SizedBox(height: 20,),
        SizedBox(height: 30,),
        (trans.length==0)? const SizedBox(height:300,child: Align(alignment:Alignment.center,child: Text("No Transactions",style: TextStyle(color: Colors.grey,fontSize: 20),))):Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: trans.length,
              itemBuilder: (context,index){
                Transactions transItem=trans[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,10),
                  child: InkWell(
                    onTap: () async {
                      // Fine selectedFine=await backend().getFine(widget.creds.access_token, transItem.transId);
                      Transactions selectedTrans=await backend().getTransaction(widget.creds.access_token, transItem.transId);
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>TransactionDetails(authToken:widget.creds,transItem:selectedTrans)));


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
                                children: [Text(transItem.paymentMethod.toUpperCase(),style: TextStyle(fontSize: 20,color:textColor1),),
                                  SizedBox(height: 5),
                                  Text(transItem.datePaid.substring(0,10),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),)],
                              ),
                              Spacer(),
                              Text(ruppee+""+transItem.amount.toString(),style: TextStyle(fontSize: 20,fontWeight:FontWeight.w400,color: textColor1),)

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
