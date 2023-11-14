import 'package:flutter/material.dart';
import 'package:tfms_app/backend_config.dart';

import 'entities.dart';
import 'globals.dart';


TextStyle labelStyle=TextStyle(fontSize: 20, fontWeight: FontWeight.w300,color: textColor3);
TextStyle titleStyle=TextStyle(fontSize: 18, fontWeight: FontWeight.w400);
TextStyle contentStyle=TextStyle(color:textColor1,fontSize: 20, fontWeight: FontWeight.w400,);
class ProfilePage extends StatefulWidget {
  ProfilePage({super.key,required this.creds});
  Creds creds;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController firstNameCon=TextEditingController(text:userProfile?.firstName );
  TextEditingController lastNameCon=TextEditingController(text:userProfile?.lastName );
  TextEditingController phoneCon=TextEditingController(text:userProfile?.phoneNo);
  TextEditingController licenseCon=TextEditingController(text: userProfile?.licenseNo);
  TextEditingController emailCon=TextEditingController(text: userProfile?.email);
  TextEditingController salaryCon=TextEditingController(text: userProfile?.salary.toString());
  bool editing=false;
  Future<void> switchEditing() async {
    if(editing){
      await backend.updateProfile(widget.creds.access_token, phoneCon.text, firstNameCon.text,lastNameCon.text, emailCon.text,double.parse(salaryCon.text));

    }
    setState(() {
      editing=!editing;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context,switchEditing,editing),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(width:MediaQuery.of(context).size.width,child: Container(decoration: BoxDecoration(border: Border.symmetric(horizontal:BorderSide(width:2,color: Colors.grey[200]!))),child: Padding(
              padding: const EdgeInsets.only(top:30.0,left: 50,bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width:MediaQuery.of(context).size.width*0.5,child: TextFormField(controller:firstNameCon,enabled:editing,decoration:!editing?InputDecoration(border: InputBorder.none):null,style: TextStyle(color:textColor3,fontSize: 30, fontWeight: FontWeight.w500,),)),
                  SizedBox(width:MediaQuery.of(context).size.width*0.5,child: TextFormField(controller:lastNameCon,enabled:editing,decoration:!editing?InputDecoration(border: InputBorder.none):null,style: TextStyle(color:textColor3,fontSize: 30, fontWeight: FontWeight.w500),)),
                ],
              ),
            ))),
            SizedBox(height: 60,),
            Padding(
              padding: const EdgeInsets.only(left:50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Aadhar No",style:titleStyle),
                  SizedBox(width:MediaQuery.of(context).size.width*0.75,child: TextFormField(initialValue: userProfile?.aadharNo,style: contentStyle,enabled: false,)),
                  SizedBox(height: 30,),
                  Text("License No",style:titleStyle),
                  SizedBox(width:MediaQuery.of(context).size.width*0.75,child: TextFormField(initialValue: userProfile?.licenseNo,style: contentStyle,enabled: false,)),
                  SizedBox(height: 30,),
                  Text("Phone No",style:titleStyle),
                  SizedBox(width:MediaQuery.of(context).size.width*0.75,child: TextFormField(controller:phoneCon,style: contentStyle,enabled: editing,)),
                  SizedBox(height: 30,),
                  Text("Salary",style:titleStyle),
                  SizedBox(width:MediaQuery.of(context).size.width*0.75,child: TextFormField(controller:salaryCon,style: contentStyle,enabled: editing,)),
                  SizedBox(height: 30,),
                  Text("Email",style:titleStyle),
                  SizedBox(width:MediaQuery.of(context).size.width*0.75,child: TextFormField(controller:emailCon,style: contentStyle,enabled: editing,)),

                ],
              ),
            ),



          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget appbar(BuildContext context,Function() switching,bool editing){
  return PreferredSize(
    preferredSize:Size.fromHeight(MediaQuery.of(context).size.height*0.08),
    child: AppBar(
      foregroundColor: Colors.white,
      backgroundColor:textColor3,
      title:Row(
        children: [
          const Text("Profile",
            style: TextStyle(color:Colors.white,fontSize: 22,fontWeight:FontWeight.bold ),),
          Spacer(),
          !editing?IconButton(onPressed: switching, icon: Icon(Icons.edit,color: Colors.white,size: 30,)):IconButton(onPressed: switching, icon: Icon(Icons.done_all,color: Colors.white,size: 30,))
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