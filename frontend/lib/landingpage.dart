import 'package:flutter/material.dart';
import 'package:tfms_app/home.dart';

import 'MyVehiclesPage.dart';
import 'Transactionpage.dart';
import 'entities.dart';
import 'globals.dart';
class LandingPage extends StatefulWidget {
  LandingPage({super.key,required this.creds});
  Creds creds;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int selectedIndex=0;

  void SetScreen(index){
    setState(() {
      selectedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> screens=[Home(creds:widget.creds),Transactions(creds:widget.creds),Vehicles(creds:widget.creds)];
    return Scaffold(
      appBar: appbar(context),
      bottomNavigationBar:BottomBar(SetScreen: SetScreen,selectedIndex:selectedIndex),
      body: screens[selectedIndex],
    );
  }
}

PreferredSizeWidget appbar(BuildContext context){
  return PreferredSize(
    preferredSize:Size.fromHeight(MediaQuery.of(context).size.height*0.08),
    child: AppBar(
        backgroundColor:textColor3,
        title:Row(
          children: [
            const Text("TFMS",
              style: TextStyle(color:Colors.white,fontSize: 22,fontWeight:FontWeight.bold ),),
            Spacer(),
            IconButton(onPressed: (){}, icon: Icon(Icons.person_3_rounded,color: Colors.white,size: 30,))
          ],
        ),
    //     leading:Padding(
    //       padding: const EdgeInsets.fromLTRB(5, 25, 10,0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Text("Traffic Fine Management System",
    //             style: TextStyle(color:Colors.white,fontSize: 20,fontWeight:FontWeight.bold ),),
    //         ],
    //       ),
    //     ),
    // leadingWidth: MediaQuery.of(context).size.width*0.8,
    // actions: [
    //   IconButton(onPressed: (){}, icon: Icon(Icons.person))
    // ],
    ),

  );

}


class BottomBar extends StatelessWidget {
  BottomBar({super.key,required this.SetScreen,required this.selectedIndex});
  Function SetScreen;
  int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.1,
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        iconSize: 35,
          elevation: 100,
          selectedItemColor: Colors.black,
          items: [
            bottomNavItem(Icons.home, "Fines"),
            bottomNavItem(Icons.monetization_on_rounded,"Transactions"),
            bottomNavItem(Icons.car_repair,"Vehicles"),

          ],
          onTap: (index){

            SetScreen(index);


          },
      ),
    );
  }
}

BottomNavigationBarItem bottomNavItem(IconData icon,String label){
  return BottomNavigationBarItem(label:label,icon: Icon(icon,),);
}

