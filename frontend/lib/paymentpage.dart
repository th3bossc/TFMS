import 'package:flutter/material.dart';
import 'package:tfms_app/backend_config.dart';
import 'package:tfms_app/landingpage.dart';
import 'globals.dart';
import 'entities.dart';

ValueNotifier<int> selectedIndex=ValueNotifier(0);

List paymentMethods=[["UPI",'assets/cashless-payment.png'],["Card",'assets/credit-card.png'],["Netbanking",'assets/bank.png'],["NEFT",'assets/bank-transfer.png']];


class PaymentGateway extends StatelessWidget {
  PaymentGateway({super.key,required this.fine,required this.authToken});
  Fine fine;
  Creds authToken;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: payAppBar(context),
        body: Column(
          children: [
            SizedBox(height: 20,),
            PaymentCards(),
          ],
        ),
        bottomNavigationBar:PayButton(fine: fine,authToken: authToken,),
      ),

    );
  }
}

PreferredSizeWidget payAppBar(BuildContext context)=>PreferredSize(
  preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.09),
  child:   AppBar(
    backgroundColor: paymentColor1,
    leadingWidth: (MediaQuery.of(context).size.width*0.2),
    leading:  Image(height:(MediaQuery.of(context).size.height*0.1),fit:BoxFit.contain,image: const AssetImage('assets/logo.webp'),
      color: paymentColor1,colorBlendMode: BlendMode.overlay,),
    centerTitle: false,
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Motor Vehicle Department",style: TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.bold),),
        SizedBox(height: 5),
        Container(
            decoration:BoxDecoration(color:Colors.lightBlue,borderRadius:BorderRadius.circular(10) ),child: Padding(
              padding: const EdgeInsets.symmetric(vertical:3.0,horizontal: 10),
              child: Text("Razorpay Trusted Business",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.bold),),
            ))

      ],
    ),
  ),
);

class PaymentCards extends StatelessWidget {
  const PaymentCards({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: selectedIndex, builder: (context,currIndex,child){
      return Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: paymentMethods.length,
              itemBuilder:(context,index){
            return ListTile(
              shape: Border.all(color: (index==currIndex)?Colors.orange.shade500:Colors.grey.shade300,width: 2),
              leading: SizedBox(height:40,child: Image(image: AssetImage(paymentMethods[index][1]),color: paymentColor1,)),
              title: Text(paymentMethods[index][0],style: TextStyle(fontSize: 15),),
              onTap: (){
                selectedIndex.value=index;
            },
            );
          }),
        ),
      );
    });
  }
}

class PayButton extends StatelessWidget {
  PayButton({super.key,required this.fine,required this.authToken});

  Fine fine;
  Creds authToken;

  @override
  Widget build(BuildContext context) {
    return  BottomAppBar(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      height: MediaQuery.of(context).size.height*0.11,
      shadowColor: Colors.black,
      elevation: 20,
      child: Row(
        children: [
          SizedBox(width: 10,),
          Text("\u20B9"+" "+fine.fineAmount.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: TextButton(onPressed: () async {
              showDialog(barrierDismissible:false,context: context, builder: (context)=>Center(child: CircularProgressIndicator()));
              await backend().payFine(authToken.access_token, paymentMethods[selectedIndex.value][0], fine.issueId);
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LandingPage(creds:authToken)));
            }, child: Container(
                decoration:BoxDecoration(color:paymentColor1,borderRadius:BorderRadius.all(Radius.circular(5))),child: SizedBox(
              width: MediaQuery.of(context).size.width*0.55,child: Center(
                child: Text(
                  "Pay Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: 15),)),
            ))),
          )

        ],
      ),

    );
  }
}
